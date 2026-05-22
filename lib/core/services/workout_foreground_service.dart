import 'dart:isolate';
import 'dart:ui' show IsolateNameServer, DartPluginRegistrant;
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'sleep_analysis_service.dart';
import 'notification_service.dart';
import '../../data/datasources/isar_service.dart';
import '../../data/models/sleep_models.dart';
import 'package:isar/isar.dart';

const String _kBioFitActionPort = 'biofit_notification_action';

@pragma('vm:entry-point')
void startCallback() {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.setTaskHandler(BioFitTaskHandler());
}

// Top-level helper so IsolateNameServer resolves without class scope ambiguity
SendPort? _lookupBioFitPort() =>
    IsolateNameServer.lookupPortByName(_kBioFitActionPort);

class BioFitTaskHandler extends TaskHandler {
  SleepAnalysisService? _sleepService;
  IsarService? _isarService;
  bool _isSleepActive = false;
  double _sensitivity = 0.5;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    debugPrint('Foreground Task started by: ${starter.name}');
  }

  @override
  void onReceiveData(Object data) {
    if (data is Map) {
      if (data.containsKey('sleep_active')) {
        _isSleepActive = data['sleep_active'] == true;
        _sensitivity = data['sensitivity'] ?? 0.5;
        
        if (_isSleepActive) {
          _startSleepTracking();
        } else {
          _stopSleepTracking();
        }
      }
    }
  }

  Future<void> _startSleepTracking() async {
    if (_sleepService != null) return;
    debugPrint('[FOREGROUND] Starting Background Sleep Analysis...');
    
    _sleepService = SleepAnalysisService();
    _isarService = IsarService(); // Dedicated instance for isolate
    
    await _sleepService!.init();
    _sleepService!.sensitivity = _sensitivity;
    
    _sleepService!.eventStream.listen((event) async {
      final isar = await _isarService!.db;
      // Find active session
      final session = await isar.sleepSessions.filter().endTimeIsNull().findFirst();
      if (session != null) {
        await isar.writeTxn(() async {
          session.events.add(event);
          // Simple stage estimation for background
          _estimateStageForBackground(session, event);
          await isar.sleepSessions.put(session);
        });
        
        // Notify main isolate if active
        final port = _lookupBioFitPort();
        port?.send({'type': 'sleep_event', 'event': 'detected'});
      }
    });

    await _sleepService!.startMonitoring();
  }

  void _estimateStageForBackground(SleepSession session, SleepEvent event) {
    // Simple logic inherited from SleepCubit to keep DB consistent
    if (event.type == SleepEventType.movement) {
      session.stages.add(SleepStageData()..timestamp = DateTime.now()..stage = SleepStage.awake);
    } else if (event.type == SleepEventType.breathing) {
      // If we see breathing and no movement, might be deep
      session.stages.add(SleepStageData()..timestamp = DateTime.now()..stage = SleepStage.deep);
    } else {
      session.stages.add(SleepStageData()..timestamp = DateTime.now()..stage = SleepStage.light);
    }
  }

  void _stopSleepTracking() {
    _sleepService?.stopMonitoring();
    _sleepService = null;
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // heartbeat — no-op
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    debugPrint('Foreground Task destroyed.');
  }

  @override
  void onNotificationButtonPressed(String id) {
    debugPrint('[FOREGROUND] Button Clicked: $id');

    // PRIMARY: send via our own named ReceivePort in the main isolate
    final sendPort = _lookupBioFitPort();
    if (sendPort != null) {
      sendPort.send(id);
      debugPrint('[FOREGROUND] Sent via direct port: $id');
    } else {
      debugPrint('[FOREGROUND] WARNING: direct port "$_kBioFitActionPort" not found');
    }

    // FALLBACK: plugin's own channel (may or may not work)
    FlutterForegroundTask.sendDataToMain(id);
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp();
  }
}

class BioFitForegroundService {
  static void init() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'biofit_foreground_channel',
        channelName: 'BioFit Tracking',
        channelDescription: 'Ongoing task controls and sensors',
        channelImportance: NotificationChannelImportance.MAX,
        priority: NotificationPriority.HIGH,
        onlyAlertOnce: true,
        showWhen: false,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static List<NotificationButton> _getButtons({
    bool isSleepActive = false,
    bool isTutActive = false,
    bool isRestActive = false,
    int? logId,
    int? setIdx,
  }) {
    if (isSleepActive) {
      return [
        const NotificationButton(id: 'stop_sleep', text: 'STOP TRACKING'),
      ];
    }

    final suffix = (logId != null && setIdx != null) ? ":$logId:$setIdx" : "";

    if (isTutActive) {
      return [
        NotificationButton(id: 'tut_done$suffix', text: 'FINISH TUT'),
        NotificationButton(id: 'tut_skip$suffix', text: 'SKIP TUT'),
      ];
    }
    if (isRestActive) {
      return [
        NotificationButton(id: 'add_rest$suffix', text: '+15s'),
        NotificationButton(id: 'skip_rest$suffix', text: 'SKIP REST'),
      ];
    }
    
    // Default workout button — we'll only show this if the user wants it
    return [
      NotificationButton(id: 'toggle_set$suffix', text: 'DONE'),
    ];
  }

  static Future<void> startService({
    required String title,
    required String notificationText,
    bool isSleepActive = false,
    bool isTutActive = false,
    bool isRestActive = false,
    int? logId,
    int? setIdx,
  }) async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService(
        notificationTitle: title,
        notificationText: notificationText,
        notificationButtons: _getButtons(
          isSleepActive: isSleepActive,
          isTutActive: isTutActive,
          isRestActive: isRestActive,
          logId: logId,
          setIdx: setIdx,
        ),
      );
      return;
    }

    await FlutterForegroundTask.startService(
      serviceId: 101,
      notificationTitle: title,
      notificationText: notificationText,
      notificationButtons: _getButtons(
        isSleepActive: isSleepActive,
        isTutActive: isTutActive,
        isRestActive: isRestActive,
        logId: logId,
        setIdx: setIdx,
      ),
      callback: startCallback,
    );
  }

  static Future<void> updateService({
    required String title,
    required String notificationText,
    bool isSleepActive = false,
    bool isTutActive = false,
    bool isRestActive = false,
    int? logId,
    int? setIdx,
    bool updateButtons = true,
  }) async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;

    if (await FlutterForegroundTask.isRunningService) {
      if (updateButtons) {
        await FlutterForegroundTask.updateService(
          notificationTitle: title,
          notificationText: notificationText,
          notificationButtons: _getButtons(
            isSleepActive: isSleepActive,
            isTutActive: isTutActive,
            isRestActive: isRestActive,
            logId: logId,
            setIdx: setIdx,
          ),
        );
      } else {
        await FlutterForegroundTask.updateService(
          notificationTitle: title,
          notificationText: notificationText,
        );
      }
    }
  }

  static Future<void> stopService() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;

    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
  }
}

