import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/sleep_models.dart';
import '../../../data/repositories/sleep_repository.dart';
import '../../../core/services/sleep_analysis_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../locator.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../../core/services/workout_foreground_service.dart';


part 'sleep_state.dart';

class SleepCubit extends Cubit<SleepState> {
  final SleepRepository _repository = locator<SleepRepository>();
  final SleepAnalysisService _analysisService = locator<SleepAnalysisService>();
  StreamSubscription? _eventSub;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _previewTimer;
  VoidCallback? onAlarmFired;

  SleepCubit() : super(SleepState.initial()) {
    _init();
  }

  Timer? _autoTrackTimer;
  bool _alarmTriggered = false;
  DateTime? _lastManualStop;

  Future<void> _init() async {
    // 1. Load basic persistent data immediately to unblock UI
    final settings = await _repository.getSettings();
    final latest = await _repository.getLatestSession();

    // 2. Initial state emission (Unblocks 'Auto Track' button)
    emit(state.copyWith(
      settings: settings,
      latestSession: latest,
      smartAlarmStart: settings.smartAlarmStart,
      smartAlarmEnd: settings.smartAlarmEnd,
    ));

    // 3. Normalize alarms and sync with system in background
    DateTime? start = settings.smartAlarmStart;
    DateTime? end = settings.smartAlarmEnd;
    
    // Set default ringtone if not set
    if (settings.alarmSoundPath == null) {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assets = manifest.listAssets();
      final alarms = assets.where((key) {
        final nk = key.toLowerCase();
        final isAlarm = nk.contains('alarms/') &&
            (nk.endsWith('.mp3') || nk.endsWith('.wav') || nk.endsWith('.ogg'));
        
        if (!isAlarm) return false;
        
        // Filter to only 1-5
        final filename = nk.split('/').last.toLowerCase();
        return filename.contains('alarm-1') || 
               filename.contains('alarm-2') || 
               filename.contains('alarm-3') || 
               filename.contains('alarm-4') || 
               filename.contains('alarm-5');
      }).toList()..sort((a, b) {
        final aNum = int.tryParse(RegExp(r'alarm-(\d+)').firstMatch(a.toLowerCase())?.group(1) ?? '0') ?? 0;
        final bNum = int.tryParse(RegExp(r'alarm-(\d+)').firstMatch(b.toLowerCase())?.group(1) ?? '0') ?? 0;
        return aNum.compareTo(bNum);
      });
      if (alarms.length >= 3) {
        settings.alarmSoundPath = alarms[2]; // Ringtone 3
        await _repository.saveSettings(settings);
      }
    }

    if (start != null && end != null) {
      final now = DateTime.now();
      DateTime normalizedStart = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime normalizedEnd = DateTime(now.year, now.month, now.day, end.hour, end.minute);
      
      if (normalizedEnd.isBefore(now)) {
        normalizedStart = normalizedStart.add(const Duration(days: 1));
        normalizedEnd = normalizedEnd.add(const Duration(days: 1));
      }
      
      start = normalizedStart;
      end = normalizedEnd;
      
      settings.smartAlarmStart = start;
      settings.smartAlarmEnd = end;
      await _repository.saveSettings(settings);
      _scheduleSystemAlarm();
    }

    // 4. Initialize AI service (non-blocking for UI settings)
    try {
      await _analysisService.init().timeout(const Duration(seconds: 4));
    } catch (e) {
      debugPrint("SleepCubit: AI Service init failed/timeout: $e");
    }

    // 5. Final initialization emission
    bool isRingingResult = false;
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      isRingingResult = await Alarm.isRinging(1001);
    }

    emit(state.copyWith(
      smartAlarmStart: start,
      smartAlarmEnd: end,
      isAiReady: _analysisService.isReady,
      snoozeDurationMinutes: settings.lastSnoozeDurationMinutes ?? 15,
      isSmartAlarmEnabled: settings.isSmartAlarmEnabled,
      smartAlarmWindowMinutes: settings.smartAlarmWindowMinutes,
      // If alarm is already ringing when app opens (e.g. phone was locked),
      // immediately show the stop/snooze screen.
      alarmTriggered: isRingingResult,
    ));

    // If alarm was already ringing when cubit started, trigger UI
    if (isRingingResult) {
      _alarmTriggered = true;
      debugPrint("SleepCubit: Alarm was already ringing on init — showing screen.");
    }

    _startAutoCheckTimer();
    
    // Listen for real-time alarm triggers from the alarm package.
    // This fires BOTH in foreground and when app is resumed from background.
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // Set audio context to use Alarm channel on Android
      if (Platform.isAndroid) {
        AudioPlayer.global.setAudioContext(AudioContext(
          android: AudioContextAndroid(
            usageType: AndroidUsageType.alarm,
            contentType: AndroidContentType.sonification,
            audioFocus: AndroidAudioFocus.gainTransient,
          ),
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playback,
            options: {
              AVAudioSessionOptions.duckOthers,
              AVAudioSessionOptions.defaultToSpeaker,
            },
          ),
        ));
      }

      Alarm.ringing.listen((alarmSet) {
        if (alarmSet.alarms.any((a) => a.id == 1001)) {
          debugPrint("SleepCubit: Alarm.ringing event received — forcing UI state.");
          _triggerAlarm(fromSystem: true);
        }
      });
    }

    // 6. Recovery Logic
    if (latest != null && latest.endTime == null) {
      debugPrint("SleepCubit: Recovering unfinished sleep session.");
      emit(state.copyWith(
        isTracking: true,
        currentSession: latest,
        detectedEventsCount: latest.events.length,
      ));
      _resumeMonitoring(latest);
    }
  }

  void _resumeMonitoring(SleepSession session) async {
    // Re-request permissions just in case
    final hasPermission = await _analysisService.hasPermission();
    if (!hasPermission) return;

    await _analysisService.startMonitoring();
    _analysisService.sensitivity = state.sensitivity;

    _eventSub?.cancel();
    _eventSub = _analysisService.eventStream.listen((event) {
      if (state.currentSession != null) {
        final updatedSession = state.currentSession!;
        updatedSession.events.add(event);
        _estimateStage(updatedSession, event);

        emit(state.copyWith(
          currentSession: updatedSession,
          detectedEventsCount: state.detectedEventsCount + 1,
        ));
        _updateSleepForeground();
      }
    });

    _updateSleepForeground();
  }

  Future<void> handleBackgroundAction(dynamic data) async {
    // 1. Handle notification button actions (Strings)
    if (data is String) {
      if (data == 'stop_sleep' || data.startsWith('stop_sleep')) {
        debugPrint('SleepCubit: Stop tracking requested from background notification.');
        stopTracking();
      }
      return;
    }

    // 2. Handle data updates from the background Task Isolate (Map)
    if (data is Map) {
      if (data['type'] == 'sleep_event') {
        debugPrint('SleepCubit: Received sleep event from background isolate.');
        // Refresh local state because isolate updated Isar
        final latest = await _repository.getLatestSession();
        if (latest != null && latest.endTime == null) {
          emit(state.copyWith(
            currentSession: latest,
            detectedEventsCount: latest.events.length,
          ));
        }
      }
    }
  }

  void testAlarm() async {
    // 5-second preview logic
    _previewTimer?.cancel();
    
    final soundPath = state.settings?.alarmSoundPath ?? 'assets/audio/ding.mp3';
    
    try {
      await _audioPlayer.setVolume(1.0);
      if (soundPath.startsWith('assets/')) {
        final relativePath = soundPath.replaceFirst('assets/', '');
        await _audioPlayer.setReleaseMode(ReleaseMode.loop);
        await _audioPlayer.play(AssetSource(relativePath));
      } else {
        await _audioPlayer.setReleaseMode(ReleaseMode.loop);
        await _audioPlayer.play(DeviceFileSource(soundPath));
      }
      
      _previewTimer = Timer(const Duration(seconds: 5), () {
        _audioPlayer.stop();
        _previewTimer = null;
      });
    } catch (e) {
      debugPrint("SleepCubit: Test alarm failed: $e");
    }
  }

  void _startAutoCheckTimer() {
    _autoTrackTimer?.cancel();
    _autoTrackTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkSchedule();
    });
    _checkSchedule(); // Immediate check
  }

  void _checkSchedule() {
    if (state.settings == null || !state.settings!.autoTrackEnabled) return;

    final now = DateTime.now();
    
    // Check both today's and yesterday's schedule (in case yesterday's crosses midnight)
    bool shouldBeTracking = false;

    for (int dayOffset = -1; dayOffset <= 0; dayOffset++) {
      final checkDate = now.add(Duration(days: dayOffset));
      final weekday = checkDate.weekday;
      final scheduleStr = state.settings!.daySchedules[weekday - 1];
      final parts = scheduleStr.split('-');
      if (parts.length != 2) continue;

      final startTime = _parseTimeString(parts[0], checkDate);
      final endTime = _parseTimeString(parts[1], checkDate);

      DateTime actualEnd = endTime;
      if (endTime.isBefore(startTime)) {
        actualEnd = endTime.add(const Duration(days: 1));
      }

      if (now.isAfter(startTime) && now.isBefore(actualEnd)) {
        shouldBeTracking = true;
        break;
      }
    }

    if (shouldBeTracking) {
      if (!state.isTracking) {
        // LOCKOUT: If we manually stopped within the last 4 hours, don't auto-restart
        if (_lastManualStop != null && 
            DateTime.now().difference(_lastManualStop!).inHours < 4) {
          return;
        }

        debugPrint("SleepCubit: Auto-tracking engaged based on schedule.");
        startTracking();
      }
    } else {
      if (state.isTracking) {
        // If it was auto-started (started by schedule), we can stop it.
        // For simplicity: if it's currently outside all schedules, stop it if it's tracking.
        debugPrint("SleepCubit: Outside schedule windows, stopping auto-track.");
        stopTracking();
      }
    }

    _checkSmartAlarm();
  }

  void _checkSmartAlarm() {
    if (state.currentSession == null || !state.isTracking) return;
    if (!state.isSmartAlarmEnabled) return; // Respect the toggle

    final session = state.currentSession!;
    if (session.smartAlarmStart == null || session.smartAlarmEnd == null) return;

    final now = DateTime.now();

    // 1. Mandatory wake up at the absolute end of the window
    if (now.isAfter(session.smartAlarmEnd!)) {
      _triggerAlarm();
      return;
    }

    // 2. Smart wake up: if we are in the window and detect light sleep
    // We check if we are within the user-defined window (e.g. 30 mins before end)
    final windowStart = session.smartAlarmEnd!.subtract(
      Duration(minutes: state.smartAlarmWindowMinutes),
    );

    if (now.isAfter(windowStart) && now.isBefore(session.smartAlarmEnd!)) {
      if (session.stages.isNotEmpty &&
          session.stages.last.stage == SleepStage.light) {
        debugPrint("SleepCubit: Smart Alarm triggered by Light Sleep detection.");
        _triggerAlarm();
      }
    }
  }

  void _triggerAlarm({bool fromSystem = false}) async {
    if (_alarmTriggered) return;
    
    // Check if it's already ringing to avoid redundant triggers causing flickers
    bool isActuallyRinging = false;
    if (!kIsWeb) {
      isActuallyRinging = await Alarm.isRinging(1001);
    }

    _alarmTriggered = true;
    
    // Trigger the actual system alarm ONLY if it wasn't already triggered by system schedule
    if (!fromSystem && !isActuallyRinging && !kIsWeb) {
      final alarmSettings = AlarmSettings(
        id: 1001,
        dateTime: DateTime.now().add(const Duration(milliseconds: 500)),
        assetAudioPath: state.settings?.alarmSoundPath ?? 'assets/audio/ding.mp3',
        volumeSettings: const VolumeSettings.fixed(),
        notificationSettings: const NotificationSettings(
          title: 'Wake Up!',
          body: 'Tap to open BioFit Pro',
        ),
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,
      );

      await Alarm.set(alarmSettings: alarmSettings);
    }

    emit(state.copyWith(alarmTriggered: true));
    
    // Critical: Ensure UI callback is fired to pop app to front
    // This is called regardless of where the trigger came from
    onAlarmFired?.call();
  }

  void snooze(int minutes) async {
    // Save as preferred snooze duration
    if (state.settings != null) {
      state.settings!.lastSnoozeDurationMinutes = minutes;
      await _repository.saveSettings(state.settings!);
    }

    final now = DateTime.now();
    if (!kIsWeb) {
      await Alarm.stop(1001);
    }
    
    _alarmTriggered = false;
    
    final snoozeTime = now.add(Duration(minutes: minutes));
    
    emit(state.copyWith(
      alarmTriggered: false,
      snoozeDurationMinutes: minutes,
      smartAlarmEnd: snoozeTime,
    ));

    // Reschedule alarm
    _scheduleSystemAlarm();
  }

  void stopAlarm() async {
    debugPrint("SleepCubit: stopAlarm called. Stopping tracking and alarm...");
    _alarmTriggered = false;

    // Repetition Logic: Always move for next day
    if (state.smartAlarmStart != null && state.smartAlarmEnd != null) {
      final nextStart = state.smartAlarmStart!.add(const Duration(days: 1));
      final nextEnd = state.smartAlarmEnd!.add(const Duration(days: 1));
      setSmartAlarm(nextStart, nextEnd);
    }

    emit(state.copyWith(alarmTriggered: false));
    if (!kIsWeb) {
      await Alarm.stop(1001);
    }
    // Deep stop: ensure tracking is killed
    stopTracking();
  }

  DateTime _parseTimeString(String timeStr, DateTime baseDate) {
    final parts = timeStr.split(':');
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  void toggleAutoTrack(bool val) async {
    if (state.settings == null) return;
    final updated = state.settings!;
    updated.autoTrackEnabled = val;
    await _repository.saveSettings(updated);
    emit(state.copyWith(settings: updated));
    _checkSchedule();
  }

  void updateDaySchedule(int dayIndex, String schedule) async {
    if (state.settings == null) return;
    final updated = state.settings!;
    
    // Synchronize all days to the same schedule
    for (int i = 0; i < 7; i++) {
      updated.daySchedules[i] = schedule;
    }
    
    await _repository.saveSettings(updated);
    emit(state.copyWith(settings: updated));
    _checkSchedule();
  }

  void toggleSmartAlarm(bool val) async {
    if (state.settings == null) return;
    final updated = state.settings!;
    updated.isSmartAlarmEnabled = val;
    await _repository.saveSettings(updated);
    emit(state.copyWith(
      settings: updated,
      isSmartAlarmEnabled: val,
    ));
  }

  void updateSmartAlarmWindow(int minutes) async {
    if (state.settings == null) return;
    final updated = state.settings!;
    updated.smartAlarmWindowMinutes = minutes;
    await _repository.saveSettings(updated);
    emit(state.copyWith(
      settings: updated,
      smartAlarmWindowMinutes: minutes,
    ));
  }

  void startTracking() async {
    if (state.isTracking) return;

    // Check and request microphone permission
    final hasPermission = await _analysisService.hasPermission();
    if (!hasPermission) {
      debugPrint("SleepCubit: Microphone permission denied.");
      return;
    }

    _alarmTriggered = false;
    final session = SleepSession()
      ..date = DateTime.now()
      ..startTime = DateTime.now()
      ..sensitivity = state.sensitivity
      ..smartAlarmStart = state.smartAlarmStart
      ..smartAlarmEnd = state.smartAlarmEnd;

    emit(state.copyWith(
      isTracking: true, 
      currentSession: session,
      detectedEventsCount: 0,
    ));

    await _analysisService.startMonitoring();
    _analysisService.sensitivity = state.sensitivity;

    // Delegate to Background Task if available
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      FlutterForegroundTask.sendDataToTask({
        'sleep_active': true,
        'sensitivity': state.sensitivity,
      });
    }

    _eventSub = _analysisService.eventStream.listen((event) {
      if (state.currentSession != null) {
        final updatedSession = state.currentSession!;
        updatedSession.events.add(event);

        _estimateStage(updatedSession, event);

        emit(state.copyWith(
          currentSession: updatedSession,
          detectedEventsCount: state.detectedEventsCount + 1,
        ));
        
        // Update foreground service with progress
        _updateSleepForeground();
      }
    });

    _updateSleepForeground();
  }

  void _updateSleepForeground() {
    if (!state.isTracking) return;
    
    final session = state.currentSession;
    if (session == null) return;

    final elapsed = DateTime.now().difference(session.startTime);
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    
    String status = "Monitoring... ($hours h ${minutes} m)";
    if (session.stages.isNotEmpty) {
      status += " | Last: ${session.stages.last.stage.name.toUpperCase()}";
    }

    BioFitForegroundService.startService(
      title: "Sleeping AI Active",
      notificationText: status,
      isSleepActive: true,
    );
  }

  void _estimateStage(SleepSession session, SleepEvent latestEvent) {
    final now = DateTime.now();
    final elapsed = now.difference(session.startTime);

    // Look at last 10 minutes of events for context
    final windowStart = now.subtract(const Duration(minutes: 10));
    final recentEvents = session.events
        .where((e) => e.timestamp.isAfter(windowStart))
        .toList();

    final movementCount = recentEvents
        .where((e) => e.type == SleepEventType.movement)
        .length;
    final breathingCount = recentEvents
        .where((e) => e.type == SleepEventType.breathing)
        .length;
    final snoreCount = recentEvents
        .where((e) => e.type == SleepEventType.snoring)
        .length;

    // 1. Wake: Any significant movement in the window or very frequent movement
    if (movementCount > 0 || latestEvent.type == SleepEventType.movement) {
      _addStage(session, SleepStage.awake);
      return;
    }

    // 2. Deep Sleep: Reliable breathing (at least 2 in 10 mins), zero movement, zero snoring
    if (movementCount == 0 && snoreCount == 0 && breathingCount >= 2) {
      _addStage(session, SleepStage.deep);
      return;
    }

    // 3. REM: Occurs in cycles, usually more frequent after 2-3 hours of sleep.
    // Characterized by very still body and irregular or light breathing detections.
    if (movementCount == 0 && elapsed.inHours >= 2) {
      if (snoreCount > 0 || breathingCount >= 1) {
        _addStage(session, SleepStage.rem);
        return;
      }
    }

    // 4. Light Sleep: Default state if no clear deep/rem/awake signals
    _addStage(session, SleepStage.light);
  }

  void _addStage(SleepSession session, SleepStage stage) {
    session.stages.add(
      SleepStageData()
        ..timestamp = DateTime.now()
        ..stage = stage,
    );
  }

  Future<void> loadTrendData(int days) async {
    emit(state.copyWith(isLoading: true));
    final allSessions = await _repository.getAllSessions();
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final filtered = allSessions
        .where((s) => s.startTime.isAfter(cutoff))
        .toList();
    emit(state.copyWith(isLoading: false, history: filtered));
  }

  void stopTracking() async {
    // ALWAYS try to stop services even if session object is missing (to fix "unstoppable" bugs)
    debugPrint("SleepCubit: Force-stopping all tracking services...");
    
    try {
      _analysisService.stopMonitoring();
      await _eventSub?.cancel();
      _eventSub = null;
      
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        await Alarm.stop(1001);
        FlutterForegroundTask.sendDataToTask({'sleep_active': false});
      }
      await NotificationService.cancelSleepAlarm();
      await BioFitForegroundService.stopService();
    } catch (e) {
      debugPrint("SleepCubit: Error during service shutdown: $e");
    }
    
    _lastManualStop = DateTime.now();

    final sessionToStop = state.currentSession ?? state.latestSession;
    if (sessionToStop == null || !state.isTracking) {
      debugPrint("SleepCubit: No active session to save or already stopped. Ensuring UI state is reset.");
      emit(state.copyWith(isTracking: false, currentSession: null));
      return;
    }

    final finalSession = sessionToStop;
    finalSession.endTime = DateTime.now();

    // Final quality score calculation — multi-factor, realistic scoring
    final totalEvents = finalSession.events.length;
    final badEvents = finalSession.events
        .where((e) =>
            e.type == SleepEventType.movement ||
            e.type == SleepEventType.snoring)
        .length;
    final totalStages = finalSession.stages.length;

    // Factor 1: Event quality (max 40 points)
    double eventScore = 40.0;
    if (totalEvents > 0) {
      final badRatio = badEvents / totalEvents;
      eventScore = (40.0 * (1.0 - badRatio)).clamp(0.0, 40.0);
    } else {
      // No events at all = we have no data; 
      // Give a score based on duration alone (up to 20 points)
      eventScore = 0.0;
    }

    // Factor 2: Deep + REM proportion bonus (max 40 points)
    double stageScore = 0.0;
    if (totalStages > 0) {
      final deepCount = finalSession.stages
          .where((s) => s.stage == SleepStage.deep).length;
      final remCount = finalSession.stages
          .where((s) => s.stage == SleepStage.rem).length;
      final goodRatio = (deepCount + remCount) / totalStages;
      stageScore = (40.0 * goodRatio).clamp(0.0, 40.0);
    } else {
      stageScore = 0.0; // no stages no bonus
    }

    // Factor 3: Duration bonus (max 20 points) — ideal = 7-9h
    final durationHours = finalSession.endTime!.difference(finalSession.startTime).inMinutes / 60.0;
    double durationScore = 0.0;
    if (durationHours >= 7.0 && durationHours <= 9.0) {
      durationScore = 20.0;
    } else if (durationHours >= 6.0) {
      durationScore = 15.0;
    } else if (durationHours >= 4.0) {
      durationScore = 10.0;
    } else {
      durationScore = 5.0;
    }

    // If we have ZERO data (no events, no stages), but we have duration,
    // let's give a "Blind Duration Score" (max 40).
    double finalRawScore = 0.0;
    if (totalEvents == 0 && totalStages == 0) {
      finalRawScore = (durationScore * 2.0).clamp(5.0, 40.0);
      debugPrint("SleepCubit: No event data detected. Blind duration score awarded: $finalRawScore");
    } else {
      finalRawScore = eventScore + stageScore + durationScore;
    }

    final score = (finalRawScore / 100.0).clamp(0.05, 0.99);
    debugPrint("SleepCubit: Final Quality Score: ${(score * 100).toStringAsFixed(1)}% (Events: $totalEvents, Stages: $totalStages, Duration: ${durationHours.toStringAsFixed(1)}h)");

    finalSession.qualityScore = score;

    try {
      await _repository.saveSession(finalSession);
    } catch (e) {
      debugPrint("SleepCubit: Error saving session: $e");
    }

    emit(
      state.copyWith(
        isTracking: false,
        currentSession: null,
        latestSession: finalSession,
      ),
    );

    // Refresh history if tracking was stopped
    loadTrendData(7);
  }

  void updateSensitivity(double val) {
    emit(state.copyWith(sensitivity: val));
    _analysisService.sensitivity = val;
  }

  void setSmartAlarm(DateTime start, DateTime end) async {
    final now = DateTime.now();
    DateTime finalStart = start;
    DateTime finalEnd = end;

    // Normalization: Ensure alarm is in the future
    if (finalEnd.isBefore(now)) {
      finalStart = finalStart.add(const Duration(days: 1));
      finalEnd = finalEnd.add(const Duration(days: 1));
    }

    if (state.settings == null) {
      final newSettings = SleepSettings()
        ..id = 0 // Explicitly set singleton ID
        ..smartAlarmStart = finalStart
        ..smartAlarmEnd = finalEnd;
      await _repository.saveSettings(newSettings);
      emit(state.copyWith(
        settings: newSettings,
        smartAlarmStart: finalStart,
        smartAlarmEnd: finalEnd,
      ));
    } else {
      final updated = state.settings!;
      updated.smartAlarmStart = finalStart;
      updated.smartAlarmEnd = finalEnd;
      await _repository.saveSettings(updated);
      emit(state.copyWith(
        settings: updated,
        smartAlarmStart: finalStart,
        smartAlarmEnd: finalEnd,
      ));
    }

    if (state.currentSession != null) {
      final session = state.currentSession!;
      session.smartAlarmStart = finalStart;
      session.smartAlarmEnd = finalEnd;
      emit(state.copyWith(currentSession: session));
    }

    _scheduleSystemAlarm();
  }

  void updateAlarmSound(String? soundPath) async {
    if (state.settings == null) return;
    final updated = state.settings!;
    updated.alarmSoundPath = soundPath;
    await _repository.saveSettings(updated);
    emit(state.copyWith(settings: updated));
    
    // Reschedule if we have an active alarm
    if (state.smartAlarmEnd != null) {
      _scheduleSystemAlarm();
    }
  }


  Future<void> _scheduleSystemAlarm() async {
    if (state.smartAlarmEnd == null) return;

    // Schedule for all non-web platforms (including Windows)
    if (!kIsWeb) {
      final alarmSettings = AlarmSettings(
        id: 1001, // Sleep alarm ID
        dateTime: state.smartAlarmEnd!,
        assetAudioPath: state.settings?.alarmSoundPath ?? 'assets/audio/ding.mp3',
        volumeSettings: const VolumeSettings.fixed(),
        notificationSettings: const NotificationSettings(
          title: 'Wake Up!',
          body: 'Tap to open BioFit Pro',
        ),
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,
      );

      await Alarm.set(alarmSettings: alarmSettings);
      debugPrint("SleepCubit: Scheduled system alarm at ${state.smartAlarmEnd}");
    }
  }

  Future<void> importSleepSession(
    Map<String, dynamic> data, {
    DateTime? targetDate,
  }) async {
    try {
      final date = targetDate ?? DateTime.now();
      final session = SleepSession()
        ..date = date
        ..startTime = DateTime.parse(
          data['startTime'] ?? date.toIso8601String(),
        )
        ..endTime = DateTime.parse(data['endTime'] ?? date.toIso8601String())
        ..qualityScore = (data['score'] as num?)?.toDouble() ?? 0.8
        ..sensitivity = 0.5;

      await _repository.saveSession(session);
      final latest = await _repository.getLatestSession();
      emit(state.copyWith(latestSession: latest));
      loadTrendData(7);
    } catch (e) {
      print("Error importing sleep: $e");
    }
  }

  Future<List<DateTime>> getDaysWithData() async {
    return await _repository.getDaysWithSleep();
  }

  @override
  Future<void> close() {
    _eventSub?.cancel();
    _autoTrackTimer?.cancel();
    _previewTimer?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}
