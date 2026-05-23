import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/models/task_item.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../locator.dart';
import '../../../core/services/notification_service.dart';
import 'package:alarm/alarm.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import '../evolution/evolution_cubit.dart';
import '../evolution/evolution_state.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _repository = locator<TaskRepository>();
  final Map<int, Timer> _timers = {};
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _chimePlayer = AudioPlayer();
  Timer? _alarmCheckTimer;
  final Set<int> _triggeredAlarmsToday =
      {}; // Keep track of alarms already triggered this minute

  TaskCubit() : super(TaskState.initial()) {
    _init();
  }

  Future<void> _init() async {
    await createDefaultTasks();
    await loadTasks();
    _startAlarmCheck();
  }

  void _startAlarmCheck() {
    _alarmCheckTimer?.cancel();
    _alarmCheckTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _checkAlarms();
    });
  }

  Future<void> _checkAlarms() async {
    final now = DateTime.now();
    final timeStr =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    for (var task in state.tasks) {
      if (task.timerType == 3 && task.alarmTime == timeStr) {
        if (!_triggeredAlarmsToday.contains(task.id)) {
          bool shouldTrigger = _shouldTriggerRecurring(task, now);
          if (shouldTrigger) {
            _triggeredAlarmsToday.add(task.id);
            _triggerAlarm(task);
          }
        }
      } else if (task.alarmTime != timeStr) {
        _triggeredAlarmsToday.remove(task.id);
      }

      // 2. Hourly Chime / RAS Logic
      if (task.isHourlyChimeEnabled) {
        if (now.hour >= task.chimeStartHour && now.hour <= task.chimeEndHour) {
          bool shouldChime = false;
          if (task.lastChimeTime == null) {
            shouldChime = true;
          } else {
            final diff = now.difference(task.lastChimeTime!);
            if (diff.inMinutes >= task.chimeIntervalMinutes) {
              shouldChime = true;
            }
          }

          if (shouldChime) {
            task.lastChimeTime = now;
            await _repository.updateTask(task);
            _playChimeSound();
          }
        }
      }
    }
  }

  bool _shouldTriggerRecurring(TaskItem task, DateTime now) {
    switch (task.recurrenceType) {
      case 0:
        return true;
      case 1:
        return true;
      case 2:
        return now.weekday == (task.lastReset?.weekday ?? now.weekday);
      case 3:
        final days = task.specificDays
            .split(',')
            .map((e) => int.tryParse(e))
            .toList();
        return days.contains(now.weekday);
      case 4:
        return now.day == (task.lastReset?.day ?? now.day);
      default:
        return false;
    }
  }

  void _playChimeSound() async {
    try {
      await _chimePlayer.setReleaseMode(ReleaseMode.release);
      await _chimePlayer.play(AssetSource('audio/ding.mp3'));
    } catch (e) {
      print("Error playing chime: $e");
    }
  }

  void _triggerAlarm(TaskItem task) async {
    print("ALARM TRIGGERED: ${task.name}");

    // Set state so UI can show global popup
    emit(state.copyWith(triggeredTask: task));

    // Enable looping
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);

    if (task.alarmSoundPath != null) {
      try {
        if (task.alarmSoundPath!.startsWith('assets/')) {
          if (Platform.isWindows) {
            // Brute-force fix for Windows asset playback:
            final data = await rootBundle.load(task.alarmSoundPath!);
            final bytes = data.buffer.asUint8List();
            final tempDir = await getTemporaryDirectory();
            final tempFile = File('${tempDir.path}/alarm_${task.id}.mp3');
            await tempFile.writeAsBytes(bytes);
            await _audioPlayer.setSourceDeviceFile(tempFile.path);
            await _audioPlayer.resume();
          } else {
            final relativePath = task.alarmSoundPath!.replaceFirst(
              'assets/',
              '',
            );
            await _audioPlayer.play(AssetSource(relativePath));
          }
        } else if (await File(task.alarmSoundPath!).exists()) {
          await _audioPlayer.play(DeviceFileSource(task.alarmSoundPath!));
        } else {
          await _playBeep();
        }
      } catch (e) {
        print("Error playing alarm sound: $e");
        await _playBeep();
      }
    } else {
      await _playBeep();
    }

    // Auto-complete the task when alarm goes off
    await completeTask(task.id);
  }

  void clearTriggeredTask() {
    if (state.triggeredTask != null) {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        Alarm.stop(state.triggeredTask!.id);
      }
    }
    _audioPlayer.setReleaseMode(ReleaseMode.release);
    _audioPlayer.stop();
    emit(state.copyWith(clearTriggeredTask: true));
  }

  Future<void> snoozeTask(int taskId, int minutes) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await Alarm.stop(taskId);
    }
    _audioPlayer.setReleaseMode(ReleaseMode.release);
    _audioPlayer.stop();
    final task = state.tasks.firstWhere((t) => t.id == taskId);

    // Calculate new alarm time
    final now = DateTime.now();
    final snoozedTime = now.add(Duration(minutes: minutes));
    final timeStr =
        "${snoozedTime.hour.toString().padLeft(2, '0')}:${snoozedTime.minute.toString().padLeft(2, '0')}";

    task.alarmTime = timeStr;
    _triggeredAlarmsToday.remove(taskId); // Allow it to trigger again today

    await _repository.updateTask(task);

    // Schedule the snoozed alarm in system notifications
    await NotificationService.scheduleTaskAlarm(
      id: task.id,
      title: task.name,
      timeStr: timeStr,
    );

    emit(state.copyWith(clearTriggeredTask: true));
    await loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      if (state.tasks.isEmpty) {
        emit(state.copyWith(isLoading: true));
      }
      final allTasks = await _repository.getAllTasks();
      final now = DateTime.now();

      List<TaskItem> filteredTasks = [];
      List<int> tasksToDelete = [];

      for (var task in allTasks) {
        // 1. Permanently Pinned: Notes stay forever
        if (task.isNote) {
          filteredTasks.add(task);
          continue;
        }

        // Check if it's a new day since last reset
        final lastReset = task.lastReset;
        final isNewDay =
            lastReset == null || !DateUtils.isSameDay(lastReset, now);

        // 2. One-time tasks (No Recurrence)
        if (task.recurrenceType == 0) {
          if (isNewDay && lastReset != null) {
            // Task from yesterday - DELETE it
            tasksToDelete.add(task.id);
            continue;
          } else {
            // Today's task or new task
            if (task.lastReset == null) {
              task.lastReset = now;
              await _repository.updateTask(task);
            }
            filteredTasks.add(task);
          }
          continue;
        }

        // 3. Recurring Tasks - Visibility Filtering
        bool shouldShowToday = false;

        // Always show if completed today (user might want to see history/stats)
        if (task.lastCompleted != null &&
            DateUtils.isSameDay(task.lastCompleted, now)) {
          shouldShowToday = true;
        } else {
          switch (task.recurrenceType) {
            case 1: // Daily
              shouldShowToday = true;
              break;
            case 2: // Weekly (Targeting same weekday as reset day)
              if (task.lastReset != null) {
                shouldShowToday = now.weekday == task.lastReset!.weekday;
              } else {
                shouldShowToday = true; // New task, show it
              }
              break;
            case 3: // Specific Days
              final days = task.specificDays
                  .split(',')
                  .map((e) => int.tryParse(e))
                  .toList();
              shouldShowToday = days.contains(now.weekday);
              break;
            case 4: // Monthly
              if (task.lastReset != null) {
                shouldShowToday = now.day == task.lastReset!.day;
              } else {
                shouldShowToday = true;
              }
              break;
          }
        }

        if (shouldShowToday) {
          // Auto-reset metrics/completion if it's a new day for this recurring task
          if (isNewDay) {
            task.lastCompleted = null;
            task.counterValue = 0;
            task.distanceValue = 0.0;
            task.energyValue = 0.0;
            task.ratingValue = 0; // Reset rating
            task.financialValue = 0.0; // Reset financial
            task.percentageValue = 0.0; // Reset percentage
            task.lastReset = now;
            await _repository.updateTask(task);
          }
          filteredTasks.add(task);
        }
      }

      // Bulk delete stale tasks
      for (var id in tasksToDelete) {
        await _repository.deleteTask(id);
      }

      emit(state.copyWith(isLoading: false, tasks: filteredTasks));

      // Sync system notifications with current tasks
      _refreshNotifications(filteredTasks);
    } catch (e) {
      print("Error loading tasks: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _refreshNotifications(List<TaskItem> tasks) async {
    // Cancel all existing alarms first to avoid duplicates or stale alarms
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final existingAlarms = await Alarm.getAlarms();
      for (var alarm in existingAlarms) {
        if (alarm.id < 1000) {
          // Task alarms are < 1000
          await Alarm.stop(alarm.id);
        }
      }
    }

    for (var task in tasks) {
      final alarmTime = task.alarmTime;
      if (task.timerType == 3 && alarmTime != null && alarmTime.isNotEmpty) {
        // Schedule notification (as backup/fallback)
        await NotificationService.scheduleTaskAlarm(
          id: task.id,
          title: task.name,
          timeStr: alarmTime,
        );

        // Schedule persistent system alarm
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          try {
            final now = DateTime.now();
            final parts = alarmTime.split(':');
            final hour = int.parse(parts[0]);
            final minute = int.parse(parts[1]);

            var scheduleDate = DateTime(
              now.year,
              now.month,
              now.day,
              hour,
              minute,
            );
            if (scheduleDate.isBefore(now)) {
              scheduleDate = scheduleDate.add(const Duration(days: 1));
            }

            final alarmSettings = AlarmSettings(
              id: task.id,
              dateTime: scheduleDate,
              assetAudioPath: task.alarmSoundPath ?? 'assets/audio/ding.mp3',
              volumeSettings: const VolumeSettings.fixed(),
              notificationSettings: NotificationSettings(
                title: 'ALARM: ${task.name}',
                body: 'Time to complete your task!',
                stopButton: 'Stop',
              ),
              loopAudio: true,
              vibrate: true,
              androidFullScreenIntent: true,
            );

            await Alarm.set(alarmSettings: alarmSettings);
            debugPrint(
              "TaskCubit: Scheduled system alarm for ${task.name} at $scheduleDate",
            );
          } catch (e) {
            debugPrint("TaskCubit: Error scheduling system alarm: $e");
          }
        }
      } else {
        await NotificationService.cancelTaskAlarm(task.id);
        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
          await Alarm.stop(task.id);
        }
      }
    }
  }

  Future<void> createTask(TaskItem task) async {
    task.orderIndex = state.tasks.length;
    await _repository.createTask(task);
    await loadTasks();
  }

  Future<void> importTasks(
    Map<String, dynamic> data, {
    DateTime? targetDate,
  }) async {
    final date = targetDate ?? DateTime.now();
    final tasks = data['tasks'] as List? ?? [];
    for (var t in tasks) {
      if (t is Map<String, dynamic>) {
        final task = TaskItem(
          name: t['name'] as String? ?? 'Task',
          sentiment: (t['sentiment'] as num?)?.toDouble() ?? 0.0,
          isNote: t['isNote'] as bool? ?? false,
          recurrenceType: t['recurrenceType'] as int? ?? 0,
        )..lastReset = date;
        await createTask(task);
      }
    }
    await loadTasks();
  }

  Future<void> reorderTasks(int oldIndex, int newIndex) async {
    final tasks = List<TaskItem>.from(state.tasks);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);

    // Update orderIndex for all tasks
    for (int i = 0; i < tasks.length; i++) {
      tasks[i].orderIndex = i;
      await _repository.updateTask(tasks[i]);
    }
    await loadTasks();
  }

  Future<void> updateTask(TaskItem task) async {
    await _repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    _stopTimer(id);
    await _repository.deleteTask(id);
    await loadTasks();
  }

  Future<void> completeTask(int id) async {
    await _repository.completeTask(id);
    await loadTasks();
  }

  Future<void> deleteTasksByGroup(String groupName) async {
    final allTasks = await _repository.getAllTasks();
    const protocolHeaders = [
      '--- NATURAL LOOKS MAXING ---',
      '1. Foundational Breathing Habits',
      '2. Tongue & Swallowing (Mewing)',
      '3. Chewing & Jaw Development',
      '4. Mechanical Palate & Facial Techniques',
      '5. Posture & Structural Realignment',
      '6. Movement & Walking',
      '7. Health & Daily Routine',
    ];

    for (var task in allTasks) {
      bool shouldDelete = task.group == groupName;

      // Also delete if it's a legacy protocol task without a group tag
      if (!shouldDelete && groupName == 'Natural Looks Maxing') {
        if (protocolHeaders.contains(task.name)) {
          shouldDelete = true;
        }
      }

      if (shouldDelete) {
        await _repository.deleteTask(task.id);
        _stopTimer(task.id);
      }
    }
    await loadTasks();
  }

  // Timer controls
  void startTimer(int taskId) {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    _stopTimer(taskId);

    task.isTimerRunning = true;
    if (task.timerType == 2) {
      // Stopwatch - count up
      task.currentSeconds = 0;
    }

    _timers[taskId] = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (task.timerType == 1) {
        // Countdown
        task.currentSeconds--;
        if (task.currentSeconds <= 0) {
          if (task.isDoubleTimer) {
            // Handle Study Timer transition
            _playStudyAlarm(task);
            if (task.isWorkPeriod) {
              // Switch to Break
              task.isWorkPeriod = false;
              task.currentSeconds = task.breakTargetSeconds;
            } else {
              // Switch to Work
              task.isWorkPeriod = true;
              task.currentSeconds = task.targetSeconds;
            }
          } else {
            // Standard Countdown Finish
            task.currentSeconds = 0;
            task.isTimerRunning = false;

            // Auto-complete when countdown finishes
            final now = DateTime.now();
            if (task.lastCompleted == null ||
                !DateUtils.isSameDay(task.lastCompleted, now)) {
              task.lastCompleted = now;
            }

            await _repository.updateTask(task);
            _stopTimer(taskId);
            await _playBeep();
            await loadTasks();
            return;
          }
        }
      } else if (task.timerType == 2) {
        // Stopwatch
        task.currentSeconds++;
      }
      await _repository.updateTask(task);
      await loadTasks();
    });

    _repository.updateTask(task);
    loadTasks();
  }

  void stopTimer(int taskId) {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.isTimerRunning = false;
    _stopTimer(taskId);
    _repository.updateTask(task);
    loadTasks();
  }

  void resetTimer(int taskId) {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    _stopTimer(taskId);

    if (task.isDoubleTimer) {
      task.isWorkPeriod = true;
      task.currentSeconds = task.targetSeconds;
    } else {
      task.currentSeconds = task.timerType == 1 ? task.targetSeconds : 0;
    }

    task.isTimerRunning = false;
    _repository.updateTask(task);
    loadTasks();
  }

  void _stopTimer(int taskId) {
    _timers[taskId]?.cancel();
    _timers.remove(taskId);
  }

  Future<void> _playBeep() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource('audio/ding.mp3'));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> _playStudyAlarm(TaskItem task) async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.release);
      if (task.alarmSoundPath != null) {
        if (task.alarmSoundPath!.startsWith('assets/')) {
          final relativePath = task.alarmSoundPath!.replaceFirst('assets/', '');
          await _audioPlayer.play(AssetSource(relativePath));
        } else if (await File(task.alarmSoundPath!).exists()) {
          await _audioPlayer.play(DeviceFileSource(task.alarmSoundPath!));
        } else {
          await _audioPlayer.play(AssetSource('audio/ding.mp3'));
        }
      } else {
        await _audioPlayer.play(AssetSource('audio/ding.mp3'));
      }

      // Stop after 3 seconds as requested
      Timer(const Duration(seconds: 3), () {
        _audioPlayer.stop();
      });
    } catch (e) {
      print('Error playing study alarm: $e');
    }
  }

  // Metric updates
  Future<void> incrementCounter(int taskId) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    if (task.counterMax > 0 && task.counterValue >= task.counterMax) {
      return; // Already at maximum
    }
    task.counterValue++;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'counter', task.counterValue.toDouble());
    await loadTasks();
  }

  Future<void> updateDistance(int taskId, double distance) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.distanceValue = distance;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'distance', distance);
    await loadTasks();
  }

  Future<void> updateDose(int taskId, String dose) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.doseValue = dose;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'dose', 1.0, textValue: dose);
    await loadTasks();
  }

  Future<void> updateWeight(int taskId, double weight) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.weightValue = weight;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'weight', weight);
    await loadTasks();
  }

  Future<void> updateEnergy(int taskId, double energy) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.energyValue = energy;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'energy', energy);
    await loadTasks();
  }

  Future<void> updateRating(int taskId, int rating) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.ratingValue = rating;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'rating', rating.toDouble());

    // --- REWARD SYSTEM ---
    final rewardTasks = [
      'Rate your sleep 1 to 10',
      'Rate your morning mood 1 to 10',
      'Rate your stress 1 to 10',
    ];
    if (rewardTasks.contains(task.name)) {
      locator<EvolutionCubit>().addCoins(3, taskName: task.name);
    }

    await loadTasks();
  }

  Future<void> updatePercentage(int taskId, double percentage) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.percentageValue = percentage;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(taskId, 'percentage', percentage);
    await loadTasks();
  }

  Future<void> updateFinancial(int taskId, double amount) async {
    final task = state.tasks.firstWhere((t) => t.id == taskId);
    task.financialValue = amount;

    // Auto-complete if not already done today
    final now = DateTime.now();
    if (task.lastCompleted == null ||
        !DateUtils.isSameDay(task.lastCompleted, now)) {
      task.lastCompleted = now;
    }

    await _repository.updateTask(task);
    await _recordMetricHistory(
      taskId,
      'financial',
      amount,
      textValue: task.currency,
    );
    await loadTasks();
  }

  Future<void> _recordMetricHistory(
    int taskId,
    String metricType,
    double value, {
    String textValue = '',
  }) async {
    await _repository.recordHistory(
      taskId: taskId,
      metricType: metricType,
      numericValue: value,
      textValue: textValue,
    );
  }

  Future<void> createDefaultTasks() async {
    final allTasks = await _repository.getAllTasks();
    final existingNames = allTasks.map((t) => t.name).toSet();

    final defaults = [
      TaskItem(
        name: 'Rate your sleep 1 to 10',
        sentiment: 1.0,
        hasRatingMetric: true,
        ratingValue: 0, // Starts as unrated
        recurrenceType: 1, // Daily
      ),
      TaskItem(
        name: 'Rate your morning mood 1 to 10',
        sentiment: 1.0,
        hasRatingMetric: true,
        ratingValue: 0, // Starts as unrated
        recurrenceType: 1, // Daily
      ),
      TaskItem(
        name: 'Rate your stress 1 to 10',
        sentiment: -0.5,
        hasRatingMetric: true,
        ratingValue: 0, // Starts as unrated
        recurrenceType: 1, // Daily
      ),
    ];

    bool addedAny = false;
    for (int i = 0; i < defaults.length; i++) {
      if (!existingNames.contains(defaults[i].name)) {
        // Force them to the top of the list
        defaults[i].orderIndex = -100 + i;
        await _repository.createTask(defaults[i]);
        addedAny = true;
      }
    }

    if (addedAny) {
      await loadTasks();
    }
  }

  Future<List<DateTime>> getDaysWithData() async {
    return await _repository.getDaysWithTasks();
  }

  Future<void> createNaturalLooksMaxingTasks() async {
    // Prevent duplicates by cleaning up existing ones first
    await deleteTasksByGroup('Natural Looks Maxing');

    final tasks = [
      // Main Header
      TaskItem(
        name: '--- NATURAL LOOKS MAXING ---',
        notes:
            'Protocol for fundamental habits for structural realignment and facial remodeling.',
        isNote: true,
        group: 'Natural Looks Maxing',
        sentiment: 1.0,
      ),

      // Category 1: Foundational Breathing Habits
      TaskItem(
        name: '1. Foundational Breathing Habits',
        notes: '',
        isNote: true,
        sentiment: 1.0,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Backwards Nasal Breathing',
        notes:
            'Always breathe through your nose. Instead of breathing "up" into your chest, breathe "backwards" horizontally into your face/sinuses. Ensure your breath is silent and your diaphragm lowers while your rib cage expands.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'The 4-6 Breathing Pattern',
        notes:
            'Practice a base breathing pattern of inhaling for 4 seconds and exhaling for 6 seconds. This slows down the respiratory rate and optimizes the nervous system.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),

      // Category 2: Tongue & Swallowing (Mewing)
      TaskItem(
        name: '2. Tongue & Swallowing (Mewing)',
        notes: '',
        isNote: true,
        sentiment: 1.0,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Suction Mewing',
        notes:
            'Smile wide, say the letter "T," and swallow repeatedly until your tongue is fully suctioned against the roof of your mouth. Maintain this all day.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Proper Swallowing',
        notes:
            'Swallow using only your tongue and neck muscles. Ensure your facial muscles and cheeks do not move or "compensate" during the swallow.',
        sentiment: 0.8,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Tongue Chewing',
        notes:
            'Strengthen your tongue by repeatedly pushing a piece of gum against the "T-spot" (the roof of your mouth) using the tongue only.',
        sentiment: 0.8,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Tongue Tie Stretch',
        notes:
            'Push your tongue on the T-spot and use a finger to push the tongue backward to stretch the frenulum (tongue tie).',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),

      // Category 3: Chewing & Jaw Development
      TaskItem(
        name: '3. Chewing & Jaw Development',
        notes: '',
        isNote: true,
        sentiment: 1.0,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Bilateral Forward Chewing',
        notes:
            'When eating (especially hard foods like steak), chew on both sides of the mouth. Roll your lower jaw slightly forward so your lower teeth sit just behind the upper teeth.',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Frown Biting',
        notes:
            'While chewing hard food or mastic gum, frown intentionally to deactivate lip muscles and force maximum activation of the masseter (jaw) muscles.',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Mastic Gum Training',
        notes:
            'Chew mastic gum for 1 minute intensely using the "frown biting" and "forward chewing" techniques as a daily warm-up.',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),

      // Category 4: Mechanical Palate & Facial Techniques
      TaskItem(
        name: '4. Mechanical Palate & Facial Techniques',
        notes: '',
        isNote: true,
        sentiment: 1.0,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Palatal Massage',
        notes:
            'Use your thumbs to massage the hard palate from the back to the front. Apply firm pressure (8.5/10) while tucking your chin and sticking your lower jaw forward. Do this for 1 minute, 3 times a day.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Thumb Pulling (Upward Pressure)',
        notes:
            'Stand against a wall, tuck your chin, and use your thumbs to push upwards and outwards on the edges of your palate (back, middle, and front). Hold for 5–10 seconds per rep. Perform for 3 minutes, 3 times a day.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Breath-Hold Thumb Pulling',
        notes:
            'Hold your breath for as long as possible before performing thumb pulling to help decompress the sutures of the skull.',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Zygomatic Pulling',
        notes:
            'Place thumbs inside your mouth under your cheekbones and massage upwards and outwards to release the zygomatic-maxillary suture.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),

      // Category 5: Posture & Structural Realignment
      TaskItem(
        name: '5. Posture & Structural Realignment',
        notes: '',
        isNote: true,
        sentiment: 1.0,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'The RSS Method (Pelvic Tilt)',
        notes:
            '1. Release: Use a tennis ball to roll out the fascia on your feet, hamstrings, glutes, and back.\n2. Stretch: Perform hip flexor stretches (like the Quad Wall Stretch) 2–3 times.\n3. Strengthen: Perform glute-dominant exercises like hip thrusts or back extensions.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Morning Cobra Stretch',
        notes:
            'Perform immediately after waking up. Lie on your stomach, push your upper body up while keeping your hips on the floor, and look at the ceiling. Hold for 30-60 seconds to reverse sleep posture.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Shoulder Reset (Up, Back, Down)',
        notes:
            '1. Up: Shrug shoulders as high as possible. 2. Back: Roll shoulders back, squeezing shoulder blades. 3. Down: Drop shoulders while keeping them back. Resets rounded shoulders.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Anterior Tibial Tendon Flexing',
        notes:
            'Stand on a slant board for 60 seconds twice a day, focusing on flexing the tendon at the top of your foot to build a natural arch.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Neck Extensions',
        notes:
            'Strengthen the back neck muscles by lying off the edge of a bench and performing weighted or bodyweight neck extensions.',
        sentiment: 0.8,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Weighted Chin Tucks',
        notes:
            'While lying off a bench, curl your neck and tuck your chin while keeping your tongue on the roof of your mouth and flexing your jaw.',
        sentiment: 0.8,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),

      // Category 6: Movement & Walking
      TaskItem(
        name: '6. Movement & Walking',
        notes: '',
        isNote: true,
        sentiment: 1.0,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Model Walking/Strutting',
        notes:
            'Walk with your toes pointed slightly in and heels out. Flex your foot tendons to maintain an arch with every step.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Knees-Over-Toes Alignment',
        notes:
            'Ensure your knees do not cave inward when walking or exercising; they should always track over your feet.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Barefoot Sprinting',
        notes:
            'Perform sprints barefoot while focusing on keeping your head upright, breathing through your nose, and maintaining the "foot-glute" connection.',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Towel Scrunches',
        notes:
            'Use your toes to scrunch up a towel on the floor to strengthen the connection between your feet and your glutes.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),

      // Category 7: Health & Daily Routine
      TaskItem(
        name: '7. Health & Daily Routine',
        notes: '',
        isNote: true,
        group: 'Natural Looks Maxing',
        sentiment: 1.0,
      ),
      TaskItem(
        name: 'Solar Callus Building',
        notes:
            'Expose your eyes and skin to the sun for 30 minutes during sunrise and 30 minutes during sunset to build "internal sunscreen" (red light therapy).',
        sentiment: 0.5,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Zygomatic & Mental Taping',
        notes:
            'Apply Zygomatic tape (from lips to ears) and Mental tape (on the chin) before exercise or sleep to create an upward vector for facial remodeling.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'Fetal Position Sleep',
        notes:
            'Sleep on your side in a fetal position with a pillow between your legs. Ensure you are mouth-taping or using facial tape to maintain nasal breathing.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
      ),
      TaskItem(
        name: 'RAS Alarms (Posture & Breath Check)',
        notes:
            'Set an alarm to go off once every hour. When it rings, check your tongue posture (suction mew), breathe backwards, and fix your body posture.',
        sentiment: 1.0,
        recurrenceType: 1,
        group: 'Natural Looks Maxing',
        isHourlyChimeEnabled: true,
        chimeIntervalMinutes: 60,
        chimeStartHour: 8,
        chimeEndHour: 22,
      ),
    ];

    for (var task in tasks) {
      await createTask(task);
    }
  }

  @override
  Future<void> close() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    _audioPlayer.dispose();
    _chimePlayer.dispose();
    return super.close();
  }
}
