import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:biofit_pro/logic/cubit/workout/workout_cubit.dart';
import 'package:biofit_pro/logic/cubit/diet/diet_cubit.dart';
import 'package:biofit_pro/logic/cubit/tasks/task_cubit.dart';
import 'package:biofit_pro/data/repositories/body_repository.dart';
import 'package:biofit_pro/core/services/ai_service.dart';
import 'package:biofit_pro/logic/cubit/evolution/evolution_state.dart';
import 'package:biofit_pro/data/repositories/coach_repository.dart';
import 'package:biofit_pro/locator.dart';
import 'package:alarm/alarm.dart';

class CallEvent {
  final bool visible;
  final bool isOutbound;
  CallEvent({required this.visible, this.isOutbound = false});
}

class CoachCallService {
  final BodyRepository _bodyRepo = locator<BodyRepository>();
  final AiService _aiService = AiService();
  bool _isOverlayVisible = false;

  static final CoachCallService _instance = CoachCallService._internal();
  factory CoachCallService() => _instance;
  CoachCallService._internal();

  // Notification stream for the UI to listen for calls
  final _callStreamController = StreamController<CallEvent>.broadcast();
  Stream<CallEvent> get callStream => _callStreamController.stream;

  void _cancelPendingCall() {
    // Timer removed as it was unused
  }

  void onWorkoutUpdate(WorkoutState state) {
    if (state.workoutDay == null) return;
    
    // Check if the last set of the last exercise is completed
    final exercises = state.workoutDay!.exercises.toList();
    exercises.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    
    if (exercises.isEmpty) return;
    
    final lastExercise = exercises.last;
    final allSetsDone = lastExercise.sets.isNotEmpty && 
                       lastExercise.sets.every((s) => s.isCompleted);

    if (allSetsDone) {
      // Automatic post-workout call disabled for now per user request
      debugPrint("CoachCallService: All sets done, but automatic post-workout call is disabled.");
      // _scheduleCall();
    } else {
      _cancelPendingCall();
    }
  }

  void onSetCompleted() async {
    final settings = await _bodyRepo.getUserSettings();
    settings.lastSetCompletedDate = DateTime.now();
    await _bodyRepo.saveUserSettings(settings);
    debugPrint("CoachCallService: Last set completed date updated.");
  }

  void checkInactivity() async {
    final settings = await _bodyRepo.getUserSettings();
    if (!settings.isAiCallEnabled || settings.isInjured || _isOverlayVisible) return;
    
    final lastSet = settings.lastSetCompletedDate ?? DateTime.now().subtract(const Duration(days: 1));
    final diff = DateTime.now().difference(lastSet).inDays;
    
    // Smart Inactivity Check (based on their program or default 3 days)
    final triggerThreshold = settings.isSick ? 7 : settings.workoutFrequencyDays;
    
    if (diff >= triggerThreshold) {
      if (settings.nextAiCallAllowedDate != null && settings.nextAiCallAllowedDate!.isAfter(DateTime.now())) return;
      
      debugPrint("CoachCallService: User lazy for $diff days. (Automatic intervention disabled per user request).");
      // _triggerCall(isOutbound: false); // AI call disabled for now
    }
  }

  void checkLaziness() async {
    final settings = await _bodyRepo.getUserSettings();
    if (!settings.isAiCallEnabled || settings.isInjured || _isOverlayVisible) return;
    
    // Check if any sets were completed today
    final lastSet = settings.lastSetCompletedDate;
    final isToday = lastSet != null && DateUtils.isSameDay(lastSet, DateTime.now());
    
    if (!isToday) {
      final diff = DateTime.now().difference(lastSet ?? DateTime.now().subtract(const Duration(days: 4))).inDays;
      if (diff >= 3) {
        debugPrint("CoachCallService: it has been $diff days since last set. (Trigger logic exists but automatic call is disabled per user request).");
        // _triggerCall(isOutbound: false); // AI call disabled for now - manual only
      }
    }
  }

  void _scheduleCall() async {
    final settings = await _bodyRepo.getUserSettings();
    if (!settings.isAiCallEnabled || settings.isInjured) return;
    
    // ... logic remains
    _triggerCall(isOutbound: false);
  }

  void _triggerCall({bool isOutbound = false}) async {
    if (_isOverlayVisible) return;
    _isOverlayVisible = true;
    
    // Use the 'alarm' package to ensure it wakes the phone and plays at alarm volume
    if (!isOutbound) {
      try {
        final settings = await _bodyRepo.getUserSettings();
        String coachName = "AI Coach";
        if (settings.activeCoachId != null) {
          final coach = await locator<CoachRepository>().getCoach(settings.activeCoachId!);
          if (coach != null) coachName = coach.name;
        }

        final alarmSettings = AlarmSettings(
          id: 42,
          dateTime: DateTime.now(),
          assetAudioPath: 'assets/audio/alarms/coach_ringtone.mp3',
          loopAudio: true,
          vibrate: true,
          notificationSettings: NotificationSettings(
            title: 'Coach $coachName',
            body: 'Incoming Neural Link request...',
            icon: 'notification_icon',
          ),
          volumeSettings: const VolumeSettings.fixed(),
          androidFullScreenIntent: true,
        );
        await Alarm.set(alarmSettings: alarmSettings);
      } catch (e) {
        debugPrint("CoachCallService: Alarm trigger failed: $e");
      }
    }

    _callStreamController.add(CallEvent(visible: true, isOutbound: isOutbound)); 
  }

  void triggerManualCall() {
    debugPrint("CoachCallService: Manual user call initiated (Outbound).");
    _triggerCall(isOutbound: true);
  }

  Future<void> handleHangUp(String option) async {
    _isOverlayVisible = false;
    _callStreamController.add(CallEvent(visible: false));
    await Alarm.stop(42); // Stop any active ringing
    
    final settings = await _bodyRepo.getUserSettings();
    final now = DateTime.now();

    switch (option) {
      case 'end':
        break;
      case 'get_lost':
        settings.consecutiveGetLostCount++;
        int days = 7; // Escalate 7 -> 21 -> 90
        if (settings.consecutiveGetLostCount == 2) days = 21;
        if (settings.consecutiveGetLostCount >= 3) days = 90;
        
        settings.nextAiCallAllowedDate = now.add(Duration(days: days));
        await _bodyRepo.saveUserSettings(settings);
        break;
      default:
        // Other delays...
        break;
    }
  }

  Future<void> handlePickUp() async {
    // Reset consecutive "get lost" if they pick up
    final settings = await _bodyRepo.getUserSettings();
    if (settings.consecutiveGetLostCount > 0) {
      settings.consecutiveGetLostCount = 0;
      await _bodyRepo.saveUserSettings(settings);
    }
    await Alarm.stop(42); // CRITICAL: Stop any active ringing when answered
  }

  void triggerTestCall() {
    _triggerCall();
  }

  Future<String> getCoachResponse({
    required List<Map<String, String>> messages,
    required WorkoutState workout,
    required DietState diet,
    required TaskState tasks,
    required EvolutionState evolution,
    String? audioPath,
  }) async {
    final weightHistory = evolution.chartHistory.map((e) => e.value).toList();
    final systemPrompt = await buildSystemPrompt(
      workout: workout,
      diet: diet,
      weightHistory: weightHistory,
      tasks: tasks,
    );

    // Build the full context
    final fullMessages = [
      {'role': 'system', 'content': systemPrompt},
      ...messages,
    ];

    // If it's the very first message, add a greeting trigger if empty
    if (messages.isEmpty && audioPath == null) {
      fullMessages.add({'role': 'user', 'content': 'Hello coach, I just finished my workout.'});
    }

    final response = await _aiService.getResponse(fullMessages, audioPath: audioPath);
    return response;
  }

  Future<String> buildSystemPrompt({
    required WorkoutState workout,
    required DietState diet,
    required List<double> weightHistory,
    required TaskState tasks,
  }) async {
    // This will be used to pass to Gemini
    return """
    You are the Muvio AI Coach, an advanced neural-linked fitness assistant.
    
    SPECIAL GOALS:
    - POST-WORKOUT: You must get feedback on: 1. Workout satisfaction, 2. Diet status, 3. Task progress. Give the user the option to end the call (using [END_CALL]) once you have gathered at least 3 messages of info.
    - INACTIVITY: If user is lazy (completed 0 sets for 3+ days), tell them: "I noticed you haven't worked out for the last 3 days. Why is that? and how can I help you?". Ask when they will train next.
    - HEALTH: If user says they are SICK, tell them to rest for 7 days and output [END_CALL]. If they say they are INJURED, show deep empathy and output [END_CALL].
    - FREQUENCY: If user mentions a "low frequency" or "special" program, acknowledge it and say you will adjust your check-ins.
    
    CRITICAL INSTRUCTIONS:
    - Keep responses VERY CONCISE (1-2 sentences).
    - To hang up the call, you MUST include the token [END_CALL] at the very end of your response.
    
    CONTEXT:
    - Todays Workout: ${workout.workoutDay?.exercises.map((e) => e.exercise.value?.name).join(", ")}
    - Weight Trend: ${weightHistory.join(", ")}
    - Todays Diet: ${diet.currentDiet?.meals.map((m) => m.name).join(", ")}
    """;
  }
}
