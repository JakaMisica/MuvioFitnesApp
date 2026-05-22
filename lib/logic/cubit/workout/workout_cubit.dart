import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import '../../../../data/models/workout_day.dart';
import '../../../../data/models/exercise.dart';
import '../../../../data/models/enums.dart';
import '../../../../data/repositories/workout_repository.dart';
import '../../../../data/repositories/fatigue_repository.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../data/models/workout_template.dart';
import '../../../../data/models/auto_workout_config.dart';
import '../../../../data/models/user_settings.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/workout_foreground_service.dart';
import '../evolution/evolution_cubit.dart';

import '../../../../data/repositories/body_repository.dart';
import '../../../../locator.dart';
import '../../../../core/services/coach_call_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository _repository = locator<WorkoutRepository>();
  final BodyRepository _bodyRepository = locator<BodyRepository>();
  late final FatigueRepository _fatigueRepository = FatigueRepository(
    locator(),
  );
  Timer? _restTimerTicker;
  Timer? _tutTicker;
  final AudioPlayer _audioPlayer = AudioPlayer();

  WorkoutCubit() : super(WorkoutState.initial()) {
    _init();
  }

  Future<void> _init() async {
    await _repository.seedDefaultExercises();
    await _repository.seedDefaultTemplates();
    await loadAutoConfig();
    await loadWorkout(state.selectedDate);
    final expanded = await _bodyRepository.getExpandedExerciseIds();
    emit(state.copyWith(expandedExerciseIds: expanded.toSet()));
    await _recoverRestTimer();
  }

  Future<void> handleBackgroundAction(dynamic data) async {
    String? rawAction;
    if (data is String) rawAction = data;
    if (data is Map && data.containsKey('action')) rawAction = data['action'];
    if (rawAction == null) return;

    debugPrint('WorkoutCubit received foreground action: $rawAction');
    
    // Ensure data is loaded if this is a fresh resume
    if (state.workoutDay == null || state.workoutDay!.exercises.isEmpty) {
      debugPrint('WorkoutCubit: Loading workout for background action...');
      await loadWorkout(state.selectedDate);
    }
    
    // Re-check after loading
    if (state.workoutDay == null) {
      debugPrint('WorkoutCubit: Failed to load workout for background action.');
      return;
    }

    final parts = rawAction.split(':');
    final action = parts[0].trim();
    final logId = parts.length > 1 ? int.tryParse(parts[1]) : null;
    final setIdx = parts.length > 2 ? int.tryParse(parts[2]) : null;

    switch (action) {
      case 'toggle_set':
        if (logId != null && setIdx != null) {
          final log = state.workoutDay?.exercises.firstWhereOrNull((l) => l.id == logId);
          if (log != null && setIdx < log.sets.length) {
            toggleSetCompletion(logId, setIdx, log.sets[setIdx]);
          }
        } else {
          _handleFinishCurrentSet();
        }
        break;
      case 'add_rest':
        debugPrint('Notification: Adding 15s rest');
        addRestTime(15);
        break;
      case 'skip_rest':
        debugPrint('Notification: Skipping rest timer');
        _completeRestTimerDirectly();
        break;
      case 'tut_done':
        debugPrint('Notification: Finishing TUT');
        if (logId != null && setIdx != null) {
          final log = state.workoutDay?.exercises.firstWhereOrNull((l) => l.id == logId);
          if (log != null && setIdx < log.sets.length) {
            finishTutSet(logId, setIdx, log.sets[setIdx]);
          }
        } else if (state.tutTimer != null) {
          final log = state.workoutDay?.exercises.firstWhereOrNull((l) => l.id == state.tutTimer!.exerciseLogId);
          if (log != null && state.tutTimer!.setIndex < log.sets.length) {
            finishTutSet(state.tutTimer!.exerciseLogId, state.tutTimer!.setIndex, log.sets[state.tutTimer!.setIndex]);
          }
        }
        break;
      case 'tut_skip':
        debugPrint('Notification: Skipping TUT');
        if (logId != null && setIdx != null) {
          final log = state.workoutDay?.exercises.firstWhereOrNull((l) => l.id == logId);
          if (log != null && setIdx < log.sets.length) {
            skipTutAndFinishSet(logId, setIdx, log.sets[setIdx]);
          }
        } else if (state.tutTimer != null) {
          final log = state.workoutDay?.exercises.firstWhereOrNull((l) => l.id == state.tutTimer!.exerciseLogId);
          if (log != null && state.tutTimer!.setIndex < log.sets.length) {
            skipTutAndFinishSet(state.tutTimer!.exerciseLogId, state.tutTimer!.setIndex, log.sets[state.tutTimer!.setIndex]);
          }
        }
        break;
    }
  }

  void _handleFinishCurrentSet() {
    // Find first uncompleted set of the first non-completed exercise
    if (state.workoutDay == null) return;
    
    final log = state.workoutDay!.exercises
        .firstWhereOrNull((l) => l.sets.any((s) => !s.isCompleted));
    if (log != null) {
      final setIdx = log.sets.indexWhere((s) => !s.isCompleted);
      if (setIdx != -1) {
        toggleSetCompletion(log.id, setIdx, log.sets[setIdx]);
      }
    }
  }

  Future<void> selectDate(DateTime date) async {
    emit(state.copyWith(selectedDate: date, isLoading: true));
    await loadWorkout(date);
  }

  void jumpToToday() {
    selectDate(DateTime.now());
  }

  Future<void> loadWorkout(DateTime date) async {
    try {
      final workout = await _repository.getWorkoutForDate(date);
      final progress = _calculateProgress(workout);
      emit(
        state.copyWith(
          isLoading: false,
          workoutDay: workout,
          completionProgress: progress,
        ),
      );
      _updateForegroundService();
      CoachCallService().onWorkoutUpdate(state);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  double _calculateProgress(WorkoutDay? workout) {
    if (workout == null || workout.exercises.isEmpty) return 0.0;

    int totalSets = 0;
    int completedSets = 0;

    for (final log in workout.exercises) {
      totalSets += log.sets.length;
      completedSets += log.sets.where((s) => s.isCompleted).length;
    }

    if (totalSets == 0) return 0.0;
    return completedSets / totalSets;
  }

  Future<void> createExercise(
    String name,
    MuscleGroup group,
    String? subGroup,
    WeightUnit unit,
    bool isIsolate, {
    bool hasCablePosition = false,
    bool hasBenchPosition = false,
    bool trackWeightReps = true,
    bool trackDistance = false,
    String? distanceUnit,
    bool trackSpeed = false,
    String? speedUnit,
    bool trackCalories = false,
    String? caloriesUnit,
    Map<String, double>? secondaryMuscleEngagement,
  }) async {
    await _repository.createExercise(
      name,
      group,
      subGroup,
      unit,
      isIsolate,
      hasCablePosition: hasCablePosition,
      hasBenchPosition: hasBenchPosition,
      trackWeightReps: trackWeightReps,
      trackDistance: trackDistance,
      distanceUnit: distanceUnit,
      trackSpeed: trackSpeed,
      speedUnit: speedUnit,
      trackCalories: trackCalories,
      caloriesUnit: caloriesUnit,
      secondaryMuscleEngagement: secondaryMuscleEngagement,
    );
  }

  Future<void> updateExercise(
    int exerciseId, {
    String? name,
    WeightUnit? unit,
    bool? isIsolate,
    bool? hasCablePosition,
    bool? hasBenchPosition,
    bool? trackWeightReps,
    bool? trackDistance,
    String? distanceUnit,
    bool? trackSpeed,
    String? speedUnit,
    bool? trackCalories,
    String? caloriesUnit,
    MuscleGroup? group,
    String? subGroup,
    Map<String, double>? secondaryMuscleEngagement,
  }) async {
    await _repository.updateExercise(
      exerciseId,
      name: name,
      unit: unit,
      isIsolate: isIsolate,
      hasCablePosition: hasCablePosition,
      hasBenchPosition: hasBenchPosition,
      trackWeightReps: trackWeightReps,
      trackDistance: trackDistance,
      distanceUnit: distanceUnit,
      trackSpeed: trackSpeed,
      speedUnit: speedUnit,
      trackCalories: trackCalories,
      caloriesUnit: caloriesUnit,
      group: group,
      subGroup: subGroup,
      secondaryMuscleEngagement: secondaryMuscleEngagement,
    );
    loadWorkout(state.selectedDate);
  }

  Future<void> deleteExercise(int exerciseId) async {
    await _repository.deleteExercise(exerciseId);
    loadWorkout(state.selectedDate);
  }

  Future<List<Exercise>> getAllExercises() => _repository.getAllExercises();

  Future<List<Exercise>> getRecentlyUsedExercises() =>
      _repository.getRecentlyUsedExercises();

  Future<void> addExerciseToCurrentDay(Exercise exercise) async {
    // Priority: 1. Last session performance, 2. All-time Best, 3. Defaults
    final lastSet = await _repository.getLastSessionSetForExercise(exercise.id);
    final bestSet =
        lastSet ?? await _repository.getBestSetForExercise(exercise.id);

    final createdLogId = await _repository.addExerciseToWorkout(
      state.selectedDate,
      exercise,
      initialWeight: bestSet?.weight,
      initialReps: bestSet?.reps,
    );
    await loadWorkout(state.selectedDate);
    final ids = Set<int>.from(state.expandedExerciseIds)..add(createdLogId);
    emit(state.copyWith(expandedExerciseIds: ids, lastExpandedLogId: createdLogId));
    _syncExpandedIdsToSettings(ids);
  }

  Future<void> addRecommendedExercise(
    Map<String, dynamic> data, {
    DateTime? targetDate,
  }) async {
    final date = targetDate ?? state.selectedDate;
    final name = data['name'] as String;
    final mgStr = data['muscleGroup'] as String;
    final sets = data['sets'] as int? ?? 3;
    final reps = data['reps'] as int? ?? 10;
    final weight = (data['weight'] as num?)?.toDouble() ?? 0.0;
    final notes = data['notes'] as String?;

    // Find muscle group enum
    final mg = MuscleGroup.values.firstWhere(
      (e) => e.name == mgStr.toLowerCase(),
      orElse: () => MuscleGroup.chest,
    );

    // Check if exercise exists
    final all = await _repository.getAllExercises();
    var exercise = all.firstWhereOrNull(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );

    if (exercise == null) {
      // Create it
      await createExercise(
        name,
        mg,
        data['subGroup'],
        WeightUnit.kg,
        data['isIsolate'] as bool? ?? false,
        hasCablePosition: data['hasCablePosition'] as bool? ?? false,
        hasBenchPosition: data['hasBenchPosition'] as bool? ?? false,
      );
      final newAll = await _repository.getAllExercises();
      exercise = newAll.firstWhere(
        (e) => e.name.toLowerCase() == name.toLowerCase(),
      );
    }

    // Add to workout
    final recommendedLogId = await _repository.addExerciseToWorkout(
      date,
      exercise,
      initialWeight: weight,
      initialReps: reps,
    );

    // Add extra sets if requested
    final workout = await _repository.getWorkoutForDate(date);
    if (workout != null) {
      final log = workout.exercises.toList().firstWhere((l) => l.id == recommendedLogId);
      // addExerciseToWorkout adds 1 set by default, so add sets-1 more
      for (int i = 0; i < sets - 1; i++) {
        final s = WorkoutSet()
          ..weight = weight
          ..reps = reps
          ..restDuration = exercise.isIsolate ? 45 : 90
          ..isRestTimerEnabled = true;
        await _repository.addSetToLog(log.id, s);
      }

      if (notes != null) {
        log.notes = notes;
        await _repository.updateLogNotes(log.id, notes);
      }
    }

    await loadWorkout(state.selectedDate);
    final ids = Set<int>.from(state.expandedExerciseIds)..add(recommendedLogId);
    emit(state.copyWith(expandedExerciseIds: ids, lastExpandedLogId: recommendedLogId));
    _syncExpandedIdsToSettings(ids);
  }

  Future<void> importWorkoutDay(
    Map<String, dynamic> data, {
    DateTime? targetDate,
  }) async {
    final date = targetDate ?? state.selectedDate;
    final exercises = data['exercises'] as List? ?? [];
    for (var ex in exercises) {
      if (ex is Map<String, dynamic>) {
        await addRecommendedExercise(ex, targetDate: date);
      }
    }
    await loadWorkout(state.selectedDate);
  }

  Future<List<DateTime>> getDaysWithData() async {
    return await _repository.getDaysWithWorkouts();
  }

  Future<void> addSet(int logId, double weight, int reps) async {
    // Determine exercise type for default rest duration
    final log = await _repository.getWorkoutExerciseLog(logId);
    final isIsolate = log?.exercise.value?.isIsolate ?? false;
    final defaultRest = isIsolate ? 45 : 90;

    // Inherit from last set if exists
    final lastSet = log?.sets.isNotEmpty == true ? log!.sets.last : null;
    final restEnabled = lastSet?.isRestTimerEnabled ?? true;
    final restDur = lastSet?.restDuration ?? defaultRest;

    final set = WorkoutSet()
      ..weight = weight
      ..reps = reps
      ..restDuration = restDur
      ..isRestTimerEnabled = restEnabled;

    // Handle equipment/cardio settings
    final exercise = log?.exercise.value;
    if (exercise != null) {
      if (exercise.hasCablePosition) {
        set.cablePosition = lastSet?.cablePosition ?? 10;
      }
      if (exercise.hasBenchPosition) {
        set.benchPosition = lastSet?.benchPosition ?? 1;
      }
      if (exercise.trackDistance) {
        set.distance = lastSet?.distance ?? 1.0;
      }
      if (exercise.trackSpeed) {
        set.speed = lastSet?.speed ?? 10.0;
      }
      if (exercise.trackCalories) {
        set.calories = lastSet?.calories ?? 100.0;
      }
    }

    await _repository.addSetToLog(logId, set);
    // Reload to refresh UI
    loadWorkout(state.selectedDate);
  }

  Future<void> toggleSetCompletion(
    int logId,
    int setIndex,
    WorkoutSet set,
  ) async {
    // --- ADVANCED TUT LOGIC ---
    if (set.isTutEnabled && !set.isCompleted) {
      final isCurrentlyInTut = state.tutTimer != null &&
          state.tutTimer!.exerciseLogId == logId &&
          state.tutTimer!.setIndex == setIndex;

      if (!isCurrentlyInTut) {
        // First click: Start TUT timer (with 5s prep as requested)
        startTutTimer(logId, setIndex, withPrep: true);
        return;
      } else {
        // Second click: Finish TUT
        await finishTutSet(logId, setIndex, set);
        return;
      }
    }

    final isNowCompleted = !set.isCompleted;
    await _finalizeSetCompletion(logId, setIndex, set, isNowCompleted);
  }

  Future<void> finishTutSet(int logId, int setIndex, WorkoutSet set) async {
    if (state.tutTimer != null &&
        state.tutTimer!.exerciseLogId == logId &&
        state.tutTimer!.setIndex == setIndex) {
      // Subtract 2s for transition delay if TUT was active
      int finalTut = (state.tutTimer!.elapsedSeconds - 2).clamp(1, 300);
      set.tutSeconds = finalTut;
      stopTutTimer();
    }

    await _finalizeSetCompletion(logId, setIndex, set, true);
  }

  Future<void> skipTutAndFinishSet(
    int logId,
    int setIndex,
    WorkoutSet set,
  ) async {
    final reps = set.reps ?? 0;
    // Default fallback: 1s concentric + 1s eccentric = 2s total
    set.tutSeconds = reps * 2;
    stopTutTimer();
    await _finalizeSetCompletion(logId, setIndex, set, true);
  }

  Future<void> _finalizeSetCompletion(
    int logId,
    int setIndex,
    WorkoutSet set,
    bool isNowCompleted,
  ) async {
    set.isCompleted = isNowCompleted;

    // Reset PR flags on uncomplete
    if (!isNowCompleted) {
      set.isPr = false;
      set.isTodayPr = false;
      set.timeCompleted = null;
      set.tutSeconds = null;
      // Also reset drop sets if any
      for (var drop in set.dropSetItems) {
        drop.tutSeconds = null;
      }
    } else {
      final now = DateTime.now();
      set.timeCompleted = now;

      // Ensure we have a baseline TUT
      if (set.tutSeconds == null || (set.tutSeconds ?? 0) < 0) {
        int tutPerRep = (set.eccentricSeconds ?? 1) + (set.concentricSeconds ?? 1) + (set.isometricSeconds ?? 0);
        if (tutPerRep < 2) tutPerRep = 2;
        int calculated = (set.reps ?? 0) * tutPerRep;
        // Final fallback for 'weird' values reported by user
        set.tutSeconds = calculated > 0 ? calculated : 5;
      }

      // --- ADVANCED DROP SET TUT DISTRIBUTION ---
      if (set.isDropSet && set.dropSetItems.isNotEmpty) {
        _distributeDropSetTut(set);
      }
    }

    await _repository.updateSet(logId, setIndex, set);

    // Sync only when COMPLETING a set
    if (isNowCompleted) {
      try {
        final exerciseLog =
            state.workoutDay?.exercises.firstWhere((e) => e.id == logId);
        final exercise = exerciseLog?.exercise.value;

        if (exercise != null) {
          // --- REWARD SYSTEM ---
          final settings = await _bodyRepository.getUserSettings();
          if (!set.pointsEarned) {
            final isSetPr = await _repository.checkIfSetPr(exercise.id, setIndex, set);
            final points = isSetPr ? 3 : 2;
            
            // Mark earned BEFORE granting to prevent race condition spams
            set.pointsEarned = true;
            await _repository.updateSet(logId, setIndex, set);
            
            // Trigger global reward
            locator<EvolutionCubit>().addMusclePoints(points);
          }

          final history =
              await _repository.getExerciseHistory(exercise.id, DateTime(2020));
          final allSets = history.values.expand((sets) => sets).toList();
          final strengthIndex =
              AnalyticsService.calculateStrengthIndex(allSets);
          final estimatedMax = AnalyticsService.calculate1RM(
            set.weight ?? 0.0,
            set.reps ?? 0,
            strengthIndex: strengthIndex,
          );

          await _fatigueRepository.recordSetCompletion(
            workoutDate: state.selectedDate,
            exercise: exercise,
            set: set,
            estimatedMax: estimatedMax,
          );

          // Logic for set transition and automatic exercise expansion/collapse
          final nextSetIndex = setIndex + 1;
          if (nextSetIndex < (exerciseLog?.sets.length ?? 0)) {
            if (set.isRestTimerEnabled) {
              startRestTimer(logId, nextSetIndex, set.restDuration ?? 90);
            }
          } else {
            // Last set of exercise finished
            final sortedLogs = state.workoutDay?.exercises.toList() ?? [];
            sortedLogs.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
            final currentIdx = sortedLogs.indexWhere((l) => l.id == logId);
            
            if (currentIdx != -1 && currentIdx < sortedLogs.length - 1) {
              final nextLog = sortedLogs[currentIdx + 1];

              // Expand next and collapse current
              final currentIds = Set<int>.from(state.expandedExerciseIds);
              currentIds.remove(logId);
              currentIds.add(nextLog.id);
              emit(state.copyWith(expandedExerciseIds: currentIds));
              
              if (set.isRestTimerEnabled) {
                startRestTimer(nextLog.id, 0, set.restDuration ?? 90);
              }
            }
          }
        }
      } catch (e) {
        print('Error recording fatigue/rest timer: $e');
      }
    } else {
      // If uncompleting, we need a full recalculation to remove the fatigue snapshot
      unawaited(_triggerFatigueRecalculation());
    }

    await _calculatePrsForLog(logId);
    loadWorkout(state.selectedDate);
    _updateForegroundService();
    CoachCallService().onWorkoutUpdate(state);
  }

  // --- TUT TIMER METHODS ---

  void _distributeDropSetTut(WorkoutSet set) {
    if (!set.isDropSet || set.dropSetItems.isEmpty) return;

    // pool sum must use unrounded values if possible? No, we just sum what's in repo
    int totalPool = (set.tutSeconds ?? 0) +
        set.dropSetItems.fold(0, (int s, ds) => s + (ds.tutSeconds ?? 0));

    // Fallback for weird data
    if (totalPool < 2) {
      // Maybe it was just added and nothing is completed yet
      return; 
    }

    final totalSubSets = 1 + set.dropSetItems.length;
    final overhead = totalSubSets * 2; // 2s transition between sets
    final usableSeconds = (totalPool - overhead).clamp(1, 10000);

    final mainReps = set.reps ?? 0;
    final dropReps = set.dropSetItems.fold(0, (int s, ds) => s + (ds.reps ?? 0));
    final totalReps = (mainReps + dropReps).clamp(1, 1000);

    final double secondsPerRep = usableSeconds / totalReps;

    // Distribute
    set.tutSeconds = (mainReps * secondsPerRep).round();
    for (var i = 0; i < set.dropSetItems.length; i++) {
        set.dropSetItems[i].tutSeconds = ((set.dropSetItems[i].reps ?? 0) * secondsPerRep).round();
    }

    // Rounding correction to preserve total pool
    int currentSum = (set.tutSeconds ?? 0) +
        set.dropSetItems.fold(0, (int s, ds) => s + (ds.tutSeconds ?? 0));
    int diff = totalPool - currentSum;
    if (diff != 0) {
      set.tutSeconds = (set.tutSeconds ?? 0) + diff;
    }
  }

  void startTutTimer(int logId, int setIndex, {bool withPrep = false}) {
    final activeLog = state.workoutDay?.exercises.firstWhere((e) => e.id == logId);
    final currentSet = activeLog != null && setIndex < activeLog.sets.length ? activeLog.sets[setIndex] : null;
    final prepTime = currentSet?.tutPrepSeconds ?? 5;

    _tutTicker?.cancel();
    emit(state.copyWith(
      tutTimer: TutTimerState(
        exerciseLogId: logId,
        setIndex: setIndex,
        isPreparing: withPrep,
        prepRemainingSeconds: withPrep ? prepTime : 0,
        totalPrepSeconds: prepTime, // ← carry the total so UI progress bar is correct
        elapsedSeconds: 0,
      ),
    ));
    _updateForegroundService();

    _tutTicker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.tutTimer == null) {
        timer.cancel();
        return;
      }

      if (state.tutTimer!.isPreparing) {
        if (state.tutTimer!.prepRemainingSeconds > 0) {
          emit(state.copyWith(
            tutTimer: state.tutTimer!.copyWith(
              prepRemainingSeconds: state.tutTimer!.prepRemainingSeconds - 1,
            ),
          ));
        } else {
          emit(state.copyWith(
            tutTimer: state.tutTimer!.copyWith(
              isPreparing: false,
              elapsedSeconds: 0,
            ),
          ));
        }
      } else {
        emit(state.copyWith(
          tutTimer: state.tutTimer!.copyWith(
            elapsedSeconds: state.tutTimer!.elapsedSeconds + 1,
          ),
        ));
      }
      _updateForegroundService(); // Added for TUT timer ticker
    });
  }

  void stopTutTimer() {
    _tutTicker?.cancel();
    emit(state.copyWith(clearTutTimer: true));
    _updateForegroundService();
  }

  void skipTutTimer() {
    if (state.tutTimer != null && state.tutTimer!.isPreparing) {
      emit(state.copyWith(
        tutTimer: state.tutTimer!.copyWith(isPreparing: false, elapsedSeconds: 0),
      ));
    }
  }

  void restartTutTimer() {
    if (state.tutTimer != null) {
      startTutTimer(state.tutTimer!.exerciseLogId, state.tutTimer!.setIndex, withPrep: true);
    }
  }

  Future<void> enableTutForSet(int logId, int setIdx) async {
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log != null && setIdx < log.sets.length) {
      final updatedSet = log.sets[setIdx].copyWith(isTutEnabled: true);
      await updateSet(logId, setIdx, updatedSet);
    }
  }

  Future<void> disableTutForSet(int logId, int setIdx) async {
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log != null && setIdx < log.sets.length) {
      final updatedSet = log.sets[setIdx].copyWith(isTutEnabled: false);
      await updateSet(logId, setIdx, updatedSet);
    }
  }



  Future<void> _calculatePrsForLog(int logId) async {
    // Fetch fresh data from repo to avoid stale cubit state issues
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log == null || log.exercise.value == null) return;

    final exerciseId = log.exercise.value!.id;
    final updatedSets = List<WorkoutSet>.from(log.sets);

    // 1. Calculate All-time PRs
    for (int i = 0; i < updatedSets.length; i++) {
      final s = updatedSets[i];
      if (s.isCompleted) {
        s.isPr = await _repository.checkIfPr(exerciseId, s);
      }
    }

    // 2. Calculate Recent Best (Medal) - 30 day rolling window
    for (int i = 0; i < updatedSets.length; i++) {
      final s = updatedSets[i];
      s.isTodayPr = false; // Reset
      if (s.isCompleted) {
        // It's a "Recent Best" if it beats the best of the last 30 days
        s.isTodayPr = await _repository.checkIfRecentBest(exerciseId, s);
      }
    }

    // Batch update all sets at once to trigger exactly ONE UI refresh with correct flags
    await _repository.updateLogSets(logId, updatedSets);
  }

  Future<void> copyWorkoutFromDate(DateTime fromDate) async {
    await _repository.copyWorkout(fromDate, state.selectedDate);
    loadWorkout(state.selectedDate);
  }

  Future<void> deleteLog(int logId) async {
    await _repository.deleteLog(logId);
    // Stream updates automatically
  }

  Future<void> updateSet(int logId, int setIndex, WorkoutSet updatedSet) async {
    // Force reset PR flags if uncompleted
    if (!updatedSet.isCompleted) {
      updatedSet.isPr = false;
      updatedSet.isTodayPr = false;
    }

    await _repository.updateSet(logId, setIndex, updatedSet);

    // --- FRESH LOG SYNC ---
    // When editing the FIRST set of a freshly-added exercise (all sets
    // uncompleted and their weight is still uniform/unchanged), propagate
    // the new weight and rest timer to every other set automatically.
    if (setIndex == 0) {
      final log = await _repository.getWorkoutExerciseLog(logId);
      if (log != null && log.sets.length > 1) {
        final allUncompleted = log.sets.every((s) => !s.isCompleted);
        // "Fresh" = every other set still has the same weight as BEFORE this edit
        // We detect this by checking all sibling sets (index 1+) still have the
        // same weight value as each other (they were set identically by addSet).
        final siblingWeights = log.sets.skip(1).map((s) => s.weight).toSet();
        final siblingsUniform = siblingWeights.length <= 1;

        if (allUncompleted && siblingsUniform) {
          // All sibling sets are still in their default state — sync them
          for (int i = 1; i < log.sets.length; i++) {
            final sibling = log.sets[i].copyWith(
              weight: updatedSet.weight,
              restDuration: updatedSet.restDuration,
              isRestTimerEnabled: updatedSet.isRestTimerEnabled,
              tutPrepSeconds: updatedSet.tutPrepSeconds,
              isTutEnabled: updatedSet.isTutEnabled,
            );
            await _repository.updateSet(logId, i, sibling);
          }
        }
      }
    }

    // If weight/reps changed and is completed, recalculate PRs
    // (We also recalculate on uncomplete to see if another set becomes "Today's Best")
    await _calculatePrsForLog(logId);

    // If it's completed, we must recalculate fatigue for the day because
    // changing reps/weight of a completed set affects all subsequent snapshots.
    if (updatedSet.isCompleted) {
      unawaited(_triggerFatigueRecalculation());
    }

    loadWorkout(state.selectedDate);
  }

  Future<void> _triggerFatigueRecalculation() async {
    final workout = await _repository.getWorkoutForDate(state.selectedDate);
    if (workout == null) return;

    // Build a map of exerciseId -> estimatedMax for proper inference
    final Map<int, double> maxes = {};
    for (final log in workout.exercises) {
      final exercise = log.exercise.value;
      if (exercise != null) {
        final history =
            await _repository.getExerciseHistory(exercise.id, DateTime(2020));
        final allSets = history.values.expand((sets) => sets).toList();
        final strengthIndex = AnalyticsService.calculateStrengthIndex(allSets);
        maxes[exercise.id] =
            AnalyticsService.getBest1RM(allSets, strengthIndex: strengthIndex);
      }
    }

    await _fatigueRepository.recalculateDayFatigue(
      workoutDate: workout.date,
      workoutDay: workout,
      exerciseMaxes: maxes,
    );
  }

  Future<void> deleteSet(int logId, int setIndex) async {
    await _repository.deleteSet(logId, setIndex);
    loadWorkout(state.selectedDate);
  }

  // --- Drop Sets (Nested) ---

  Future<void> addDropSetItem(int logId, int setIndex) async {
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log != null && setIndex < log.sets.length) {
      final set = log.sets[setIndex];
      final lastDrop = set.dropSetItems.isNotEmpty
          ? set.dropSetItems.last
          : null;

      // Initial drop set values (e.g. 20% drop from main weight or last drop)
      final baseWeight = lastDrop?.weight ?? set.weight ?? 0.0;
      final newWeight =
          (baseWeight * 0.8 / 2.5).round() * 2.5; // Round to nearest 2.5

      final newItem = DropSetItem()
        ..weight = newWeight
        ..reps = lastDrop?.reps ?? set.reps ?? 10
        ..isCompleted = false;

      final updatedSet = set.copyWith(
        dropSetItems: [...set.dropSetItems, newItem],
        isDropSet: true, // Mark parent as having drop sets
      );
      
      // USER REQUEST: Redistribute TUT even after completion
      if (updatedSet.isCompleted) {
        _distributeDropSetTut(updatedSet);
      }

      await updateSet(logId, setIndex, updatedSet);
      
      // Auto-expand on adding drop set if not already
      if (!state.expandedExerciseIds.contains(logId)) {
        toggleExerciseExpansion(logId);
      }
    }
  }

  Future<void> updateDropSetItem(
    int logId,
    int setIndex,
    int dropSetIndex,
    DropSetItem updatedItem,
  ) async {
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log != null && setIndex < log.sets.length) {
      final set = log.sets[setIndex];
      if (dropSetIndex < set.dropSetItems.length) {
        final newDropSets = List<DropSetItem>.from(set.dropSetItems);
        newDropSets[dropSetIndex] = updatedItem;

        final updatedSet = set.copyWith(dropSetItems: newDropSets);
        
        // USER REQUEST: Redistribute TUT even after completion (e.g. if reps changed)
        if (updatedSet.isCompleted) {
          _distributeDropSetTut(updatedSet);
        }

        await updateSet(logId, setIndex, updatedSet);
      }
    }
  }

  Future<void> toggleDropSetCompletion(
    int logId,
    int setIndex,
    int dropSetIndex,
  ) async {
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log != null && setIndex < log.sets.length) {
      final set = log.sets[setIndex];
      if (dropSetIndex < set.dropSetItems.length) {
        final newDropSets = List<DropSetItem>.from(set.dropSetItems);
        final item = newDropSets[dropSetIndex];

        // Simple toggle for now, similar to main set but without the complex TUT logic
        // for each individual drop set (keep it focused on the main set's timing for simplicity)
        newDropSets[dropSetIndex] = DropSetItem()
          ..weight = item.weight
          ..reps = item.reps
          ..isCompleted = !item.isCompleted;

        final updatedSet = set.copyWith(dropSetItems: newDropSets);
        await updateSet(logId, setIndex, updatedSet);
      }
    }
  }

  Future<void> deleteDropSetItem(
    int logId,
    int setIndex,
    int dropSetIndex,
  ) async {
    final log = await _repository.getWorkoutExerciseLog(logId);
    if (log != null && setIndex < log.sets.length) {
      final set = log.sets[setIndex];
      if (dropSetIndex < set.dropSetItems.length) {
        final newDropSets = List<DropSetItem>.from(set.dropSetItems);
        newDropSets.removeAt(dropSetIndex);

        final updatedSet = set.copyWith(
          dropSetItems: newDropSets,
          isDropSet:
              newDropSets.isNotEmpty, // Only true if there are still drop sets
        );

        // Redistribute pool after deletion
        if (updatedSet.isCompleted) {
           _distributeDropSetTut(updatedSet);
        }

        await updateSet(logId, setIndex, updatedSet);
      }
    }
  }

  Future<void> updateExerciseIncrement({
    required int logId,
    double? weightIncrement,
    double? repsIncrement,
  }) async {
    await _repository.updateExerciseIncrement(
      logId: logId,
      weightIncrement: weightIncrement,
      repsIncrement: repsIncrement,
    );
    loadWorkout(state.selectedDate);
  }

  Future<void> reorderExercises(List<int> logIdsInOrder) async {
    // Capture current timer state before reordering
    int? activeTimerLogId = state.restTimer?.exerciseLogId;
    int? activeTimerSetIdx = state.restTimer?.setIndex;

    await _repository.reorderLogs(logIdsInOrder);
    await loadWorkout(state.selectedDate);

    // Sync timer if it was pointing to a 'next exercise' (set 0)
    if (activeTimerLogId != null && activeTimerSetIdx == 0) {
      // Use state after loadWorkout to get up-to-date order
      final logs = state.workoutDay?.exercises.toList() ?? [];
      // Explicitly sort to be 100% sure we're in the right order
      logs.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      // 1. Find the exercise that was COMPLETED just before the timer started.
      WorkoutExerciseLog? lastCompletedLog;
      DateTime? latestTime;

      for (final log in logs) {
        for (final s in log.sets) {
          if (s.isCompleted && s.timeCompleted != null) {
            if (latestTime == null || s.timeCompleted!.isAfter(latestTime)) {
              latestTime = s.timeCompleted;
              lastCompletedLog = log;
            }
          }
        }
      }

      // 2. Based on NEW order, find what follows that completed log.
      if (lastCompletedLog != null) {
        final currentIdx = logs.indexWhere((l) => l.id == lastCompletedLog!.id);
        if (currentIdx != -1 && currentIdx < logs.length - 1) {
          final newNextLog = logs[currentIdx + 1];

          // 3. Update timer target if it shifted
          if (newNextLog.id != activeTimerLogId) {
            final updatedTimer = state.restTimer!.copyWith(
              exerciseLogId: newNextLog.id,
            );
            emit(state.copyWith(restTimer: updatedTimer));
            _updateNotification(updatedTimer);
          }
        }
      }
    }
  }

  // --- Templates & Rest Day ---

  Future<void> toggleRestDay() async {
    await _repository.toggleRestDay(state.selectedDate);
    loadWorkout(state.selectedDate);
  }

  Future<void> saveCurrentDayAsTemplate(
    String name,
    String folderName, {
    int? folderId,
  }) async {
    await _repository.saveWorkoutAsTemplate(
      state.selectedDate,
      name,
      folderId: folderId,
      folderName: folderName,
    );
  }

  Future<void> saveSharedWorkoutAsTemplate(
    Map<String, dynamic> data,
    String templateName, {
    int? folderId,
    String? folderName,
  }) async {
    final exercises = data['exercises'] as List? ?? [];
    List<Map<String, dynamic>> resolvedExercises = [];

    for (var ex in exercises) {
      if (ex is Map<String, dynamic>) {
        final name = ex['name'] as String;
        final mgStr = ex['muscleGroup'] as String;

        // Ensure exercise exists in library
        final all = await _repository.getAllExercises();
        var exercise = all.firstWhereOrNull(
          (e) => e.name.toLowerCase() == name.toLowerCase(),
        );

        if (exercise == null) {
          final mg = MuscleGroup.values.firstWhere(
            (e) => e.name == mgStr.toLowerCase(),
            orElse: () => MuscleGroup.chest,
          );

          await createExercise(
            name,
            mg,
            ex['subGroup'],
            WeightUnit.kg,
            ex['isIsolate'] as bool? ?? false,
            hasCablePosition: ex['hasCablePosition'] as bool? ?? false,
            hasBenchPosition: ex['hasBenchPosition'] as bool? ?? false,
          );
        }
        resolvedExercises.add(ex);
      }
    }

    await _repository.saveTemplateWithData(
      templateName,
      resolvedExercises,
      folderId: folderId,
      folderName: folderName,
    );
  }
  // No need to reload workout day, but might need to refresh template list if open

  Future<void> applyTemplate(int templateId) async {
    await _repository.applyTemplate(state.selectedDate, templateId);
    loadWorkout(state.selectedDate);
  }

  Future<List<TemplateFolder>> getAllFolders() => _repository.getAllFolders();

  Future<List<TemplateFolder>> getSubFolders(int parentId) =>
      _repository.getSubFolders(parentId);

  Future<List<TemplateViewModel>> getTemplatesInFolder(int folderId) =>
      _repository.getTemplatesInFolder(folderId);

  Future<void> createFolder(String name, {int? parentId}) async {
    await _repository.createFolder(name, parentId: parentId);
  }

  Future<void> deleteFolder(int folderId) async {
    await _repository.deleteFolder(folderId);
  }

  // --- Settings & PR ---

  Future<UserSettings> getUserSettings() => _repository.getUserSettings();

  Future<void> updateUserSettings(UserSettings settings) async {
    await _repository.updateUserSettings(settings);
  }

  Future<void> updateBarbellWeight(int exerciseId, double weight) async {
    await _repository.updateBarbellWeight(exerciseId, weight);
    loadWorkout(state.selectedDate);
  }

  Future<void> deleteTemplate(int templateId) async {
    await _repository.deleteTemplate(templateId);
  }

  // --- Rest Timer ---

  void startRestTimer(int logId, int nextSetIndex, int durationSeconds) {
    _restTimerTicker?.cancel();

    final now = DateTime.now();
    final endTime = now.add(Duration(seconds: durationSeconds));

    final restTimer = RestTimerState(
      exerciseLogId: logId,
      setIndex: nextSetIndex,
      startTime: now,
      endTime: endTime,
      durationSeconds: durationSeconds,
      remainingSeconds: durationSeconds,
    );

    emit(state.copyWith(restTimer: restTimer));
    _updateNotification(restTimer);

    // Schedule system-level alarm for background
    NotificationService.scheduleRestTimer(
      durationSeconds: durationSeconds,
      exerciseName: _getExerciseName(logId),
    );

    _startTimerTicker();
    
    _bodyRepository.persistRestTimer(
      endTime: endTime,
      logId: logId,
      setIdx: nextSetIndex,
      totalDuration: durationSeconds,
    );
  }

  void cancelRestTimer() {
    _restTimerTicker?.cancel();
    _restTimerTicker = null;
    NotificationService.cancelNotification(); // Ongoing
    NotificationService.cancelRestTimer(); // Scheduled alarm
    emit(state.copyWith(clearRestTimer: true));
    _bodyRepository.clearPersistedRestTimer();
  }

  void addRestTime(int seconds) {
    final current = state.restTimer;
    if (current == null) return;

    final newEndTime = current.endTime.add(Duration(seconds: seconds));
    final updated = RestTimerState(
      exerciseLogId: current.exerciseLogId,
      setIndex: current.setIndex,
      startTime: current.startTime,
      endTime: newEndTime,
      durationSeconds: current.durationSeconds + seconds,
      remainingSeconds: current.remainingSeconds + seconds,
    );

    emit(state.copyWith(restTimer: updated));
    _updateNotification(updated);

    // Reschedule system-level alarm
    NotificationService.scheduleRestTimer(
      durationSeconds: updated.remainingSeconds,
      exerciseName: _getExerciseName(current.exerciseLogId),
    );

    _bodyRepository.persistRestTimer(
      endTime: updated.endTime,
      logId: updated.exerciseLogId,
      setIdx: updated.setIndex,
      totalDuration: updated.durationSeconds,
    );
  }

  Future<void> _recoverRestTimer() async {
    final settings = await _bodyRepository.getUserSettings();
    final endTime = settings.restTimerEndTime;
    if (endTime != null &&
        endTime.isAfter(DateTime.now()) &&
        settings.restTimerExerciseLogId != null) {
      final now = DateTime.now();
      final remaining = endTime.difference(now).inSeconds;

      final restTimer = RestTimerState(
        exerciseLogId: settings.restTimerExerciseLogId!,
        setIndex: settings.restTimerNextSetIndex ?? 0,
        startTime: now.subtract(
          Duration(
            seconds: (settings.restTimerTotalDuration ?? 90) - remaining,
          ),
        ),
        endTime: endTime,
        durationSeconds: settings.restTimerTotalDuration ?? 90,
        remainingSeconds: remaining,
      );

      emit(state.copyWith(restTimer: restTimer));
      _startTimerTicker();
    }
  }

  void _startTimerTicker() {
    _restTimerTicker = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state.restTimer;
      if (current == null) {
        timer.cancel();
        return;
      }

      final newRemaining = current.endTime.difference(DateTime.now()).inSeconds;

      if (newRemaining <= 0) {
        _completeRestTimerDirectly();
        return;
      }

      // Create a NEW instance with the updated countdown to trigger UI rebuild
      final updated = current.copyWith(remainingSeconds: newRemaining);
      emit(state.copyWith(restTimer: updated));
      _updateNotification(updated);
    });
  }

  void _completeRestTimerDirectly() {
    if (state.restTimer == null) return;

    _updateNotification(state.restTimer!.copyWith(remainingSeconds: 0));
    _playTimerSound();

    final finishedTimer = state.restTimer;
    cancelRestTimer();

    // AUTO-START TUT for the next set as requested
    if (finishedTimer != null) {
      final log = state.workoutDay?.exercises.firstWhereOrNull((l) => l.id == finishedTimer.exerciseLogId);
      if (log != null && finishedTimer.setIndex < log.sets.length) {
        final nextSet = log.sets[finishedTimer.setIndex];
        if (nextSet.isTutEnabled && !nextSet.isCompleted) {
          // Trigger the 5s prep as requested by user ("go to the tut calculations in 5s")
          startTutTimer(finishedTimer.exerciseLogId, finishedTimer.setIndex, withPrep: true);
        }
      }
    }
  }

  String _getExerciseName(int logId) {
    final workoutDay = state.workoutDay;
    if (workoutDay != null) {
      final log = workoutDay.exercises.toList().firstWhereOrNull(
        (e) => e.id == logId,
      );
      if (log != null) {
        return log.exercise.value?.name ?? "Next Exercise";
      }
    }
    return "Next Exercise";
  }

  void _updateNotification(RestTimerState timer) {
    _updateForegroundService();
  }

  Future<void> _playTimerSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/ding.mp3'));
    } catch (e) {
      print('Error playing timer sound: $e');
    }
  }

  // --- Auto Workout ---

  Future<void> loadAutoConfig() async {
    final config = await _repository.getAutoWorkoutConfig();
    emit(state.copyWith(autoConfig: config));
  }

  Future<void> saveAutoConfig(AutoWorkoutConfig config) async {
    final expandedIds = <int>[];
    for (var f in config.folders) {
      if (f.folderId != null) {
        final leaves = await _repository.getLeafFoldersRecursive(f.folderId!);
        final leafIds = leaves.map((l) => l.id).toList();

        // Repeat the split sequence N times if multiple folders enabled
        // otherwise just once (the repeats field is used if multipleFoldersEnabled is true)
        final effectiveRepeats = config.multipleFoldersEnabled ? f.repeats : 1;
        for (int i = 0; i < effectiveRepeats; i++) {
          expandedIds.addAll(leafIds);
        }
      }
    }

    final newConfig = AutoWorkoutConfig()
      ..folders = config.folders
      ..multipleFoldersEnabled = config.multipleFoldersEnabled
      ..currentFolderIndex = config.currentFolderIndex
      ..currentWorkoutIndex = config.currentWorkoutIndex
      ..currentRepeatCount = config.currentRepeatCount
      ..expandedFolderIds = expandedIds;

    await _repository.saveAutoWorkoutConfig(newConfig);
    emit(state.copyWith(autoConfig: newConfig));
  }

  Future<WorkoutTemplate?> getTemplateAtOffset(int offset) async {
    final config = state.autoConfig;
    if (config == null || config.expandedFolderIds.isEmpty) return null;

    final info = await _resolveInfoAtOffset(offset);
    return info?.template;
  }

  Future<void> applyAutoWorkout(int offset) async {
    final config = state.autoConfig;
    if (config == null || config.expandedFolderIds.isEmpty) return;

    final info = await _resolveInfoAtOffset(offset);
    if (info == null) return;

    await applyTemplate(info.template.id);

    // Update config to point to the NEXT one after THIS applied one
    final nextInfo = await _resolveInfoAtOffset(offset + 1);
    if (nextInfo != null) {
      final updated = AutoWorkoutConfig()
        ..folders = config.folders
        ..multipleFoldersEnabled = config.multipleFoldersEnabled
        ..expandedFolderIds = config.expandedFolderIds
        ..currentFolderIndex = nextInfo.folderIndex
        ..currentWorkoutIndex = nextInfo.workoutIndex
        ..currentRepeatCount = nextInfo.repeatCount;

      await _repository.saveAutoWorkoutConfig(updated);
      emit(state.copyWith(autoConfig: updated));
    }
  }

  Future<AutoNextWorkoutInfo?> _resolveInfoAtOffset(int offset) async {
    final config = state.autoConfig;
    if (config == null || config.expandedFolderIds.isEmpty) return null;

    int folderIdx = config.currentFolderIndex;
    int workoutIdx = config.currentWorkoutIndex;

    // Advance by offset
    for (int i = 0; i < offset.abs(); i++) {
      final isForward = offset > 0;
      if (isForward) {
        final templates = await _repository.getTemplatesInFolderRaw(
          config.expandedFolderIds[folderIdx % config.expandedFolderIds.length],
        );
        workoutIdx++;
        if (workoutIdx >= templates.length) {
          workoutIdx = 0;
          folderIdx = (folderIdx + 1) % config.expandedFolderIds.length;
        }
      } else {
        workoutIdx--;
        if (workoutIdx < 0) {
          folderIdx =
              (folderIdx - 1 + config.expandedFolderIds.length) %
              config.expandedFolderIds.length;
          final prevTemplates = await _repository.getTemplatesInFolderRaw(
            config.expandedFolderIds[folderIdx],
          );
          workoutIdx = prevTemplates.length - 1;
        }
      }
    }

    final actualFolderIdx = folderIdx % config.expandedFolderIds.length;
    final folderId = config.expandedFolderIds[actualFolderIdx];
    final templates = await _repository.getTemplatesInFolderRaw(folderId);
    if (templates.isEmpty) return null;

    final template = templates[workoutIdx % templates.length];
    return AutoNextWorkoutInfo(
      template: template,
      folderIndex: actualFolderIdx,
      workoutIndex: workoutIdx,
      repeatCount: 0, // No longer used as it's baked into expandedFolderIds
    );
  }

  @override
  Future<void> close() {
    _restTimerTicker?.cancel();
    _tutTicker?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }

  String? _lastNotificationButtonsId;

  void _updateForegroundService() {
    if (state.workoutDay == null || state.workoutDay!.exercises.isEmpty) {
      BioFitForegroundService.stopService();
      _lastNotificationButtonsId = null;
      return;
    }

    final activeLog = state.workoutDay!.exercises
        .firstWhereOrNull((l) => l.sets.any((s) => !s.isCompleted));
    
    if (activeLog == null) {
      BioFitForegroundService.stopService();
      _lastNotificationButtonsId = null;
      return;
    }

    final exerciseName = activeLog.exercise.value?.name ?? "Workout";
    final setIdx = activeLog.sets.indexWhere((s) => !s.isCompleted);
    final currentSet = activeLog.sets[setIdx];
    final totalSets = activeLog.sets.length;

    String tags = "";
    if (currentSet.isWarmUp) tags += " [WARM-UP]";
    if (currentSet.isFailure) tags += " [FAILURE]";
    if (currentSet.rir != null) tags += " RIR: ${currentSet.rir}";
    if (currentSet.side != null) tags += " (${currentSet.side})";
    if (currentSet.partialReps != null) tags += " +${currentSet.partialReps}P";

    String body = "Set ${setIdx + 1}/$totalSets: ${currentSet.weight ?? 0}kg x ${currentSet.reps ?? 0}$tags";
    
    if (state.restTimer != null) {
      body += "\nRest: ${state.restTimer!.remainingSeconds ~/ 60}:${(state.restTimer!.remainingSeconds % 60).toString().padLeft(2, '0')}";
    }
    if (state.tutTimer != null) {
      if (state.tutTimer!.isPreparing) {
        body += "\nPrep: ${state.tutTimer!.prepRemainingSeconds}s";
      } else {
        body += "\nTUT: ${state.tutTimer!.elapsedSeconds}s";
      }
    }

    // --- USER REQUEST: ONLY NOTIFY IF TIMER ACTIVE ---
    // AND USER REQUEST: NO NOTIFICATION DURING PREP
    final currentButtonsId = state.tutTimer != null ? (state.tutTimer!.isPreparing ? "prep" : "tut") : (state.restTimer != null ? "rest" : "done");
    
    if (currentButtonsId == "done" || currentButtonsId == "prep") {
      BioFitForegroundService.stopService();
      _lastNotificationButtonsId = null;
      return;
    }

    bool shouldUpdateButtons = currentButtonsId != _lastNotificationButtonsId;
    
    if (shouldUpdateButtons) {
      _lastNotificationButtonsId = currentButtonsId;
      BioFitForegroundService.startService(
        title: exerciseName,
        notificationText: body,
        isTutActive: state.tutTimer != null,
        isRestActive: state.restTimer != null,
        logId: activeLog.id,
        setIdx: setIdx,
      );
    } else {
      // Only update text, keep buttons stable
      BioFitForegroundService.updateService(
        title: exerciseName,
        notificationText: body,
        isTutActive: state.tutTimer != null,
        isRestActive: state.restTimer != null,
        logId: activeLog.id,
        setIdx: setIdx,
        updateButtons: false,
      );
    }
  }

  void toggleExerciseExpansion(int logId) {
    final ids = Set<int>.from(state.expandedExerciseIds);
    int? justExpanded;
    if (ids.contains(logId)) {
      ids.remove(logId);
    } else {
      ids.add(logId);
      justExpanded = logId;
    }
    emit(state.copyWith(expandedExerciseIds: ids, lastExpandedLogId: justExpanded, clearLastExpanded: justExpanded == null));
    _syncExpandedIdsToSettings(ids);
  }

  void _syncExpandedIdsToSettings(Set<int> ids) {
    _bodyRepository.persistExpandedExerciseIds(ids.toList());
  }

  void collapseAllExercises() {
    emit(state.copyWith(expandedExerciseIds: {}, clearLastExpanded: true));
    _syncExpandedIdsToSettings({});
  }
}

class AutoNextWorkoutInfo {
  final WorkoutTemplate template;
  final int folderIndex;
  final int workoutIndex;
  final int repeatCount;

  AutoNextWorkoutInfo({
    required this.template,
    required this.folderIndex,
    required this.workoutIndex,
    required this.repeatCount,
  });
}
