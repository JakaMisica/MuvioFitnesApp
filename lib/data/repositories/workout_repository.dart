import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../datasources/isar_service.dart';
import '../models/exercise.dart';
import '../models/workout_day.dart';
import '../models/enums.dart';
import '../../../../data/models/workout_template.dart';
import '../../../../data/models/user_settings.dart';
import '../../../../data/models/auto_workout_config.dart';
import '../../../../core/services/analytics_service.dart';

import 'dart:isolate';

// DTO for UI to avoid Isar lazy loading issues in View
class TemplateViewModel {
  final int id;
  final String name;
  final String folderName;
  final List<TemplateExercise> exercises;

  TemplateViewModel({
    required this.id,
    required this.name,
    required this.folderName,
    required this.exercises,
  });
}

class LogViewModel {
  final int id;
  final String name;
  final String? subGroup;
  final bool isIsolate;
  final double weightIncrement;
  final double repsIncrement;
  final bool hasCablePosition;
  final bool hasBenchPosition;
  final bool trackWeightReps;
  final bool trackDistance;
  final String? distanceUnit;
  final bool trackSpeed;
  final String? speedUnit;
  final bool trackCalories;
  final String? caloriesUnit;
  final WeightUnit defaultUnit;
  final List<WorkoutSet> sets;
  final WorkoutExerciseLog originalLog;

  LogViewModel({
    required this.id,
    required this.name,
    required this.subGroup,
    required this.isIsolate,
    required this.weightIncrement,
    required this.repsIncrement,
    required this.hasCablePosition,
    required this.hasBenchPosition,
    required this.trackWeightReps,
    required this.trackDistance,
    this.distanceUnit,
    required this.trackSpeed,
    this.speedUnit,
    required this.trackCalories,
    this.caloriesUnit,
    required this.defaultUnit,
    required this.sets,
    required this.originalLog,
  });
}

class WorkoutRepository {
  final IsarService _isarService;

  WorkoutRepository(this._isarService);

  // --- Exercises ---

  Future<List<Exercise>> getAllExercises() async {
    final isar = await _isarService.db;
    return await isar.exercises.where().findAll();
  }

  Future<List<Exercise>> getRecentlyUsedExercises({int limit = 10}) async {
    final isar = await _isarService.db;
    // Get last scans of workout days to find used exercises
    final workoutDays = await isar.workoutDays
        .where()
        .sortByDateDesc()
        .limit(20) // Scan last 20 sessions
        .findAll();

    final List<Exercise> recent = [];
    final Set<int> seenIds = {};

    for (var day in workoutDays) {
      for (var log in day.exercises) {
        await log.exercise.load();
        final ex = log.exercise.value;
        if (ex != null && !seenIds.contains(ex.id)) {
          recent.add(ex);
          seenIds.add(ex.id);
          if (recent.length >= limit) return recent;
        }
      }
    }
    return recent;
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
    final isar = await _isarService.db;
    final exercise = Exercise()
      ..name = name
      ..muscleGroup = group
      ..subGroup = subGroup
      ..defaultUnit = unit
      ..isIsolate = isIsolate
      ..hasCablePosition = hasCablePosition
      ..hasBenchPosition = hasBenchPosition
      ..trackWeightReps = trackWeightReps
      ..trackDistance = trackDistance
      ..distanceUnit = distanceUnit
      ..trackSpeed = trackSpeed
      ..speedUnit = speedUnit
      ..trackCalories = trackCalories
      ..caloriesUnit = caloriesUnit
      ..isCustom = true;

    if (secondaryMuscleEngagement != null) {
      exercise.setSecondaryMuscleEngagement(secondaryMuscleEngagement);
    }

    await isar.writeTxn(() async {
      await isar.exercises.put(exercise);
    });
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
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final ex = await isar.exercises.get(exerciseId);
      if (ex != null) {
        if (name != null) ex.name = name;
        if (unit != null) ex.defaultUnit = unit;
        if (isIsolate != null) ex.isIsolate = isIsolate;
        if (hasCablePosition != null) ex.hasCablePosition = hasCablePosition;
        if (hasBenchPosition != null) ex.hasBenchPosition = hasBenchPosition;
        if (trackWeightReps != null) ex.trackWeightReps = trackWeightReps;
        if (trackDistance != null) ex.trackDistance = trackDistance;
        if (distanceUnit != null) ex.distanceUnit = distanceUnit;
        if (trackSpeed != null) ex.trackSpeed = trackSpeed;
        if (speedUnit != null) ex.speedUnit = speedUnit;
        if (trackCalories != null) ex.trackCalories = trackCalories;
        if (caloriesUnit != null) ex.caloriesUnit = caloriesUnit;
        if (group != null) ex.muscleGroup = group;
        if (subGroup != null) ex.subGroup = subGroup;
        if (secondaryMuscleEngagement != null) {
          ex.setSecondaryMuscleEngagement(secondaryMuscleEngagement);
        }
        await isar.exercises.put(ex);
      }
    });
  }

  Future<void> deleteExercise(int exerciseId) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      // NOTE: This doesn't delete historical logs, just the library entry.
      // If we want to prevent future use or delete all records, we'd need more logic.
      // For now, let's just delete the base exercise.
      await isar.exercises.delete(exerciseId);
    });
  }

  // --- Workouts ---

  Future<WorkoutDay?> getWorkoutForDate(DateTime date) async {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(date);

    final workout = await isar.workoutDays
        .filter()
        .dateEqualTo(normalizedDate)
        .findFirst();

    if (workout != null) {
      await workout.exercises.load();
      // Load all exercise links explicitly to ensure names are available
      for (final log in workout.exercises) {
        await log.exercise.load();
      }
      // Note: IsarLinks are not easily sorted in-place permanently,
      // but we ensure consumers like loadWorkout() get a consistent viewed state via sort.
    }
    return workout;
  }

  Stream<List<LogViewModel>> watchWorkoutForDate(DateTime date) async* {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(date);

    // We need to react to changes in BOTH WorkoutDays (adding exercises)
    // AND WorkoutExerciseLogs (adding sets/completing sets).
    // Isar's watchLazy fires on any change to the collection.

    final port = ReceivePort();

    final dayStream = isar.workoutDays.watchLazy(fireImmediately: true);
    final logStream = isar.workoutExerciseLogs.watchLazy();
    final exerciseStream = isar.exercises.watchLazy();

    // Merge streams
    dayStream.listen((_) => port.sendPort.send(true));
    logStream.listen((_) => port.sendPort.send(true));
    exerciseStream.listen((_) => port.sendPort.send(true));

    // Yield specific data on any event
    await for (final _ in port) {
      final workout = await isar.workoutDays
          .filter()
          .dateEqualTo(normalizedDate)
          .findFirst();

      if (workout != null) {
        final viewModels = <LogViewModel>[];
        for (final log in workout.exercises) {
          await log.exercise.load();
          // Force fresh fetch of exercise to avoid stale cache in links
          final exercise = log.exercise.value != null
              ? await isar.exercises.get(log.exercise.value!.id)
              : null;

          viewModels.add(
            LogViewModel(
              id: log.id,
              name: exercise?.name ?? "Unknown Ex",
              subGroup: exercise?.subGroup,
              isIsolate: exercise?.isIsolate ?? false,
              weightIncrement: (exercise?.weightIncrement ?? 0) > 0
                  ? exercise!.weightIncrement
                  : 2.5,
              repsIncrement: (exercise?.repsIncrement ?? 0) > 0
                  ? exercise!.repsIncrement
                  : 1.0,
              hasCablePosition: exercise?.hasCablePosition ?? false,
              hasBenchPosition: exercise?.hasBenchPosition ?? false,
              trackWeightReps: exercise?.trackWeightReps ?? true,
              trackDistance: exercise?.trackDistance ?? false,
              distanceUnit: exercise?.distanceUnit,
              trackSpeed: exercise?.trackSpeed ?? false,
              speedUnit: exercise?.speedUnit,
              trackCalories: exercise?.trackCalories ?? false,
              caloriesUnit: exercise?.caloriesUnit,
              defaultUnit: exercise?.defaultUnit ?? WeightUnit.kg,
              sets: log.sets,
              originalLog: log,
            ),
          );
        }
        // Sort by orderIndex
        viewModels.sort(
          (a, b) =>
              a.originalLog.orderIndex.compareTo(b.originalLog.orderIndex),
        );
        yield viewModels;
      } else {
        yield [];
      }
    }
  }

  Future<WorkoutExerciseLog?> getWorkoutExerciseLog(int logId) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);
    if (log != null) {
      await log.exercise.load();
    }
    return log;
  }

  Future<void> deleteLog(int logId) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.workoutExerciseLogs.delete(logId);
    });
  }

  Future<WorkoutDay> getOrCreateWorkoutForDate(DateTime date) async {
    final existing = await getWorkoutForDate(date);
    if (existing != null) return existing;

    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(date);
    final newWorkout = WorkoutDay()..date = normalizedDate;

    await isar.writeTxn(() async {
      await isar.workoutDays.put(newWorkout);
    });

    return newWorkout;
  }

  Future<int> addExerciseToWorkout(
    DateTime date,
    Exercise exercise, {
    double? initialWeight,
    int? initialReps,
  }) async {
    final isar = await _isarService.db;

    // 1. Fetch workout day and load link state OUTSIDE any transaction
    final normalizedDate = DateUtils.dateOnly(date);
    var workout = await isar.workoutDays
        .filter()
        .dateEqualTo(normalizedDate)
        .findFirst();

    if (workout == null) {
      workout = WorkoutDay()..date = normalizedDate;
      await isar.writeTxn(() => isar.workoutDays.put(workout!));
    }

    // Explicitly load the link before determining length to avoid sync load in txn
    await workout.exercises.load();
    final currentOrderCount = workout.exercises.length;

    int newLogId = 0;

    // 2. Perform all updates in a single atomic transaction
    await isar.writeTxn(() async {
      // Re-fetch workout to ensure thread-safety inside txn
      final existingWorkout = await isar.workoutDays.get(workout!.id);
      if (existingWorkout == null) return;

      if (existingWorkout.isRestDay) {
        existingWorkout.isRestDay = false;
        await isar.workoutDays.put(existingWorkout);
      }

      // Create log
      final newLog = WorkoutExerciseLog();

      // Initial set
      final defaultRest = exercise.isIsolate ? 45 : 90;
      final initialSet = WorkoutSet()
        ..weight = initialWeight ?? 10.0
        ..reps = initialReps ?? 10
        ..restDuration = defaultRest
        ..isRestTimerEnabled = true;

      // Initialize cardio defaults if enabled
      if (exercise.trackDistance) initialSet.distance = 1.0;
      if (exercise.trackSpeed) initialSet.speed = 10.0;
      if (exercise.trackCalories) initialSet.calories = 100.0;

      newLog.sets = [initialSet];
      newLog.orderIndex = currentOrderCount;

      // Save log
      newLogId = await isar.workoutExerciseLogs.put(newLog);

      // Link exercise & workout
      newLog.exercise.value = exercise;
      await newLog.exercise.save();

      existingWorkout.exercises.add(newLog);
      await existingWorkout.exercises.save();
    });
    return newLogId;
  }

  Future<void> addSetToLog(int logId, WorkoutSet set) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);

    if (log != null) {
      await isar.writeTxn(() async {
        // We must replace the list or modify it.
        // Isar embedded objects are stored in the parent.
        // We need to re-assign the list to trigger update or just add to it.
        // For embedded lists, modifying the list in place works if we put the object again.
        final newSets = List<WorkoutSet>.from(log.sets)..add(set);
        log.sets = newSets;
        await isar.workoutExerciseLogs.put(log);
      });
    }
  }

  Future<void> updateSet(int logId, int setIndex, WorkoutSet updatedSet) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);
    if (log != null && setIndex < log.sets.length) {
      final newSets = List<WorkoutSet>.from(log.sets);
      newSets[setIndex] = updatedSet;
      log.sets = newSets;
      await isar.writeTxn(() => isar.workoutExerciseLogs.put(log));

      if (updatedSet.isCompleted) {
        final settings = await isar.userSettings.get(0);
        if (settings != null) {
          settings.lastWorkoutDate = DateTime.now();
          await isar.writeTxn(() => isar.userSettings.put(settings));
        }
      }
    }
  }

  Future<void> updateLogSets(int logId, List<WorkoutSet> sets) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);
    if (log != null) {
      log.sets = sets;
      await isar.writeTxn(() => isar.workoutExerciseLogs.put(log));

      if (sets.any((s) => s.isCompleted)) {
        final settings = await isar.userSettings.get(0);
        if (settings != null) {
          settings.lastWorkoutDate = DateTime.now();
          await isar.writeTxn(() => isar.userSettings.put(settings));
        }
      }
    }
  }

  Future<void> updateLogNotes(int logId, String notes) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);
    if (log != null) {
      log.notes = notes;
      await isar.writeTxn(() => isar.workoutExerciseLogs.put(log));
    }
  }

  Future<void> deleteSet(int logId, int setIndex) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);

    if (log != null && setIndex < log.sets.length) {
      await isar.writeTxn(() async {
        final newSets = List<WorkoutSet>.from(log.sets);
        newSets.removeAt(setIndex);
        log.sets = newSets;
        await isar.workoutExerciseLogs.put(log);
      });
    }
  }

  // --- Smart Copy ---

  Future<List<DateTime>> getDaysWithWorkouts() async {
    final isar = await _isarService.db;
    // Filter days that have at least one exercise
    final workouts = await isar.workoutDays.where().findAll();
    // Isar filters on links are tricky in pure query, simplest is to check in memory
    // or use a more complex query if supported.
    // For MVP/User-scale data (years of workouts = ~1000 items), fetching all dates is fine.
    // Optimization: Filter where exercises isNotEmpty.
    // Note: Isar async links need loading or link length check if available.
    // 'filter().exercisesLengthGreaterThan(0)' might be available if using links.
    // Actually, let's just return all dates for now, potentially filtering.
    return workouts
        .where((w) => w.exercises.isNotEmpty)
        .map((w) => w.date)
        .toList();
  }

  Future<void> copyWorkout(DateTime fromDate, DateTime toDate) async {
    final source = await getWorkoutForDate(fromDate);
    if (source == null || source.exercises.isEmpty) return;

    final target = await getOrCreateWorkoutForDate(toDate);
    final isar = await _isarService.db;

    await isar.writeTxn(() async {
      for (final log in source.exercises) {
        // Clone the log
        final newLog = WorkoutExerciseLog()
          ..exercise.value = log.exercise.value
          ..notes = log.notes
          ..sets = log.sets
              .map(
                (s) => WorkoutSet()
                  ..weight = s.weight
                  ..reps = s.reps
                  ..side = s.side
                  ..rir = s.rir
                  ..isFailure = s.isFailure
                  ..spotReps = s.spotReps
                  ..myoReps = s.myoReps
                  ..myoPauseSeconds = s.myoPauseSeconds
                  ..partialReps = s.partialReps
                  ..isDropSet = s.isDropSet
                  ..isWarmUp = s.isWarmUp
                  ..eccentricSeconds = s.eccentricSeconds
                  ..concentricSeconds = s.concentricSeconds
                  ..isometricSeconds = s.isometricSeconds
                  ..isRestTimerEnabled = s.isRestTimerEnabled
                  ..restDuration = s.restDuration
                  ..cablePosition = s.cablePosition
                  ..benchPosition = s.benchPosition
                  ..distance = s.distance
                  ..speed = s.speed
                  ..calories = s.calories
                  ..dropSetItems = List.from(s.dropSetItems)
                  ..isTutEnabled = s.isTutEnabled
                  ..tutPrepSeconds = s.tutPrepSeconds
                  ..isCompleted = false, // Reset completion and timing
              )
              .toList();

        await isar.workoutExerciseLogs.put(newLog);
        await newLog.exercise.save(); // Explicitly save link
        target.exercises.add(newLog);
      }
      await target.exercises.save();
    });
  }

  // --- Analytics ---

  /// Get all workout logs for a specific exercise within a date range
  /// Returns a map of date -> sets for that exercise
  Future<Map<DateTime, List<WorkoutSet>>> getExerciseHistory(
    int exerciseId,
    DateTime startDate, [
    DateTime? endDate,
  ]) async {
    final isar = await _isarService.db;
    final end = endDate ?? DateTime.now();
    final result = <DateTime, List<WorkoutSet>>{};

    // Optimization: Only get workout days that actually contain this exercise
    final workouts = await isar.workoutDays
        .filter()
        .dateBetween(startDate, end)
        .exercises((q) => q.exercise((e) => e.idEqualTo(exerciseId)))
        .findAll();

    for (final workout in workouts) {
      await workout.exercises.load();
      // Find the specific log for this exercise in this day
      for (final log in workout.exercises) {
        // We still need to load to confirm it's the right one (if current session data is out of sync)
        await log.exercise.load();
        if (log.exercise.value?.id == exerciseId) {
          final normalizedDate = DateUtils.dateOnly(workout.date);
          result[normalizedDate] = List.from(log.sets);
          break; // Found it for this day
        }
      }
    }

    return result;
  }

  Future<List<MapEntry<DateTime, double>>> getWorkoutPerformanceHistory(
    DateTime start,
    DateTime end,
  ) async {
    final isar = await _isarService.db;
    final workouts = await isar.workoutDays
        .filter()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();

    final history = <MapEntry<DateTime, double>>[];
    double lastKnownAvg = 0;

    DateTime current = DateUtils.dateOnly(start);
    int workoutIdx = 0;

    while (!current.isAfter(end)) {
      if (workoutIdx < workouts.length &&
          DateUtils.isSameDay(workouts[workoutIdx].date, current)) {
        double total1RM = 0;
        int setCount = 0;
        for (var log in workouts[workoutIdx].exercises) {
          for (var set in log.sets) {
            if (set.isCompleted && (set.weight ?? 0) > 0) {
              final w = set.weight!;
              final r = set.reps ?? 0;
              total1RM += AnalyticsService.calculate1RM(w, r);
              setCount++;
            }
          }
        }
        if (setCount > 0) {
          lastKnownAvg = total1RM / setCount;
        }
        workoutIdx++;
      }

      if (lastKnownAvg > 0) {
        history.add(MapEntry(current, lastKnownAvg));
      }
      current = current.add(const Duration(days: 1));
    }
    return history;
  }

  Future<List<MapEntry<DateTime, Map<String, double>>>> getVolumeAnalyticsData(
    DateTime start,
    DateTime end,
  ) async {
    final isar = await _isarService.db;
    final workouts = await isar.workoutDays
        .filter()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();

    final result = <MapEntry<DateTime, Map<String, double>>>[];

    // Smart grouping cache
    // Key: Signature (TemplateId or Exercise IDs) -> Value: Display Name
    final Map<String, String> groupNames = {};

    for (var day in workouts) {
      if (day.exercises.isEmpty) continue;

      // Generate a signature for grouping
      String signature;
      if (day.templateId != null) {
        signature = "T_${day.templateId}";
      } else {
        final exIds =
            day.exercises.map((e) => e.exercise.value?.id ?? 0).toList()
              ..sort();
        signature = "S_${exIds.join(',')}";
      }

      // Determine workout name
      String workoutName = "Custom Workout";
      if (groupNames.containsKey(signature)) {
        workoutName = groupNames[signature]!;
      } else {
        if (day.templateId != null) {
          final template = await isar.workoutTemplates.get(day.templateId!);
          if (template != null) {
            workoutName = template.name;
          }
        } else {
          // Detect muscle groups to name it somewhat smartly
          final setCounts = <MuscleGroup, int>{};
          for (var log in day.exercises) {
            final mg = log.exercise.value?.muscleGroup;
            if (mg != null) {
              setCounts[mg] = (setCounts[mg] ?? 0) + log.sets.length;
            }
          }
          if (setCounts.isNotEmpty) {
            final mainMg = setCounts.entries
                .sorted((a, b) => b.value.compareTo(a.value))
                .first
                .key;
            workoutName =
                "${mainMg.name.substring(0, 1).toUpperCase()}${mainMg.name.substring(1)} Session";
          }
        }
        groupNames[signature] = workoutName;
      }

      double dayTotalVolume = 0;
      for (var log in day.exercises) {
        for (var set in log.sets) {
          if (set.isCompleted && (set.weight ?? 0) > 0) {
            dayTotalVolume += (set.weight! * (set.reps ?? 0).toDouble());
          }
        }
      }

      if (dayTotalVolume > 0) {
        result.add(MapEntry(day.date, {workoutName: dayTotalVolume}));
      }
    }
    return result;
  }

  Future<double> getTotalVolumeForCurrentWeek() async {
    final isar = await _isarService.db;
    final now = DateTime.now();
    // Monday as start of week
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final normalizedStart = DateUtils.dateOnly(startOfWeek);

    final workouts = await isar.workoutDays
        .filter()
        .dateBetween(normalizedStart, DateUtils.dateOnly(now))
        .findAll();

    double total = 0;
    for (var day in workouts) {
      for (var log in day.exercises) {
        for (var set in log.sets) {
          if (set.isCompleted && (set.weight ?? 0) > 0) {
            total += (set.weight! * (set.reps ?? 0).toDouble());
          }
        }
      }
    }
    return total;
  }

  Future<double> getCaloriesBurnedForDate(DateTime date) async {
    final isar = await _isarService.db;
    final workout = await isar.workoutDays
        .filter()
        .dateEqualTo(DateUtils.dateOnly(date))
        .findFirst();

    if (workout == null) return 0.0;

    await workout.exercises.load();
    double totalCalories = 0;
    double totalVolume = 0;

    for (var log in workout.exercises) {
      for (var set in log.sets) {
        if (set.isCompleted) {
          // Add explicit calories from cardio/custom logs
          totalCalories += (set.calories ?? 0);

          // Heuristic for strength volume: 1kg * 1 rep = 0.1 calories
          if ((set.weight ?? 0) > 0) {
            totalVolume += (set.weight! * (set.reps ?? 0).toDouble());
          }
        }
      }
    }

    return totalCalories + (totalVolume * 0.1);
  }

  Future<void> updateExerciseIncrement({
    required int logId,
    double? weightIncrement,
    double? repsIncrement,
  }) async {
    final isar = await _isarService.db;
    final log = await isar.workoutExerciseLogs.get(logId);
    if (log != null) {
      await log.exercise.load();
      final exerciseId = log.exercise.value?.id;
      if (exerciseId != null) {
        await isar.writeTxn(() async {
          // Fetch fresh exercise to ensure we don't overwrite with stale data
          final exercise = await isar.exercises.get(exerciseId);
          if (exercise != null) {
            if (weightIncrement != null)
              exercise.weightIncrement = weightIncrement;
            if (repsIncrement != null) exercise.repsIncrement = repsIncrement;
            await isar.exercises.put(exercise);
          }
        });
      }
    }
  }

  Future<void> reorderLogs(List<int> logIdsInOrder) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      for (int i = 0; i < logIdsInOrder.length; i++) {
        final log = await isar.workoutExerciseLogs.get(logIdsInOrder[i]);
        if (log != null) {
          log.orderIndex = i;
          await isar.workoutExerciseLogs.put(log);
        }
      }
    });
  }

  Future<void> seedDefaultExercises() async {
    final isar = await _isarService.db;

    final defaults = [
      // --- CHEST ---
      Exercise()
        ..name = "Flat Bench Press (BB)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Middle"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Incline Bench Press (BB)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Upper"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Decline Bench Press (BB)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Lower"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Dumbbell Bench Press"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Middle"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Incline Dumbbell Press"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Upper"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Incline Dumbbell Fly (Stretch Focus)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Upper"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Single Arm Cable Press-Around"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Upper/Mid"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Single Arm Cable Chest Fly"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Middle"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Cable Crossover (High to Low)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Lower"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Cable Crossover (Low to High)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Upper"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Dips (Chest Focus)"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Lower",
      Exercise()
        ..name = "Machine Chest Press"
        ..muscleGroup = MuscleGroup.chest
        ..subGroup = "Middle",

      // --- BACK ---
      Exercise()
        ..name = "Lat Pulldown (Wide Grip)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lats",
      Exercise()
        ..name = "Lat Pulldown (Neutral/Close Grip)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lats",
      Exercise()
        ..name = "Single Arm Lat Pulldown (Cable)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lats"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Pull-up (Weighted)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lats",
      Exercise()
        ..name = "Barbell Shrug"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Upper Traps",
      Exercise()
        ..name = "Dumbbell Shrug"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Upper Traps",
      Exercise()
        ..name = "Seated Cable Row"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Middle Back"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Single Arm Seated Cable Row"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Middle Back"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Bent Over Barbell Row"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Middle Back",
      Exercise()
        ..name = "Dumbbell Row (One Arm)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Middle Back"
        ..isIsolate = true,
      Exercise()
        ..name = "Deadlift (Conventional)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lower Back",
      Exercise()
        ..name = "Deadlift (Sumo)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lower Back",
      Exercise()
        ..name = "Back Extension"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lower Back",
      Exercise()
        ..name = "Face Pull (Cable)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Rear Delts"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Cable Lat Prayer (Straight Arm)"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Lats"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Meadows Row"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Upper Back"
        ..isIsolate = true,
      Exercise()
        ..name = "Kelso Shrug"
        ..muscleGroup = MuscleGroup.back
        ..subGroup = "Mid/Lower Traps",

      // --- LEGS ---
      Exercise()
        ..name = "Barbell Squat (High Bar)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Quads",
      Exercise()
        ..name = "Barbell Squat (Low Bar)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Whole Leg",
      Exercise()
        ..name = "Leg Press (Plate Loaded)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Quads",
      Exercise()
        ..name = "Leg Extension (Stretch Focus)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Quads",
      Exercise()
        ..name = "Leg Curl (Lying)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Hamstrings",
      Exercise()
        ..name = "Leg Curl (Seated - Science Based)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Hamstrings",
      Exercise()
        ..name = "Romanian Deadlift (Stretch Mediated)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Hamstrings",
      Exercise()
        ..name = "Bulgarian Split Squat"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Glutes/Quads"
        ..isIsolate = true,
      Exercise()
        ..name = "Hip Thrust (BB)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Glutes"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Walking Lunges (DB)"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Glutes",
      Exercise()
        ..name = "Standing Calf Raise"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Calves",
      Exercise()
        ..name = "Seated Calf Raise"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Calves",
      Exercise()
        ..name = "Cable Adduction"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Adductors"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Abductor Machine"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Glute Medius",
      Exercise()
        ..name = "Sissy Squat"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Quads",
      Exercise()
        ..name = "Hack Squat"
        ..muscleGroup = MuscleGroup.legs
        ..subGroup = "Quads",

      // --- SHOULDERS ---
      Exercise()
        ..name = "Overhead Press (BB)"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Front Delts",
      Exercise()
        ..name = "Seated Dumbbell Press"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Front Delts"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Lateral Raise (DB - Long Length Partials)"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Side Delts",
      Exercise()
        ..name = "Lateral Raise (Cable - Behind Back)"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Side Delts"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Single Arm Cable Lateral Raise (Science Based)"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Side Delts"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Rear Delt Machine Fly"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Rear Delts",
      Exercise()
        ..name = "Cable Rear Delt Fly (Unilateral)"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Rear Delts"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Arnold Press"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Front/Side Delts",
      Exercise()
        ..name = "Upright Row (Cable)"
        ..muscleGroup = MuscleGroup.shoulders
        ..subGroup = "Traps/Side Delts"
        ..hasCablePosition = true,

      // --- ARMS ---
      Exercise()
        ..name = "Barbell Bicep Curl"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Biceps",
      Exercise()
        ..name = "Incline Dumbbell Curl (Stretch Focus)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Biceps (Long Head)"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Hammer Curl (DB)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Brachialis/Forearms",
      Exercise()
        ..name = "Preacher Curl (Ez-Bar)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Biceps (Short Head)",
      Exercise()
        ..name = "Single Arm Cable Curl"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Biceps"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Triceps Pushdown (Straight Bar)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Triceps"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Triceps Pushdown (Rope)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Triceps"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Single Arm Cable Cross-Body Extension"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Triceps (Lateral Head)"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Overhead Cable Tricep Extension"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Triceps (Long Head)"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Skull Crusher (Ez-Bar)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Triceps"
        ..hasBenchPosition = true,
      Exercise()
        ..name = "Wrist Curl (BB/DB)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Forearms",
      Exercise()
        ..name = "Reverse Wrist Curl (BB/DB)"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Forearms",
      Exercise()
        ..name = "Bayesian Cable Curl"
        ..muscleGroup = MuscleGroup.arms
        ..subGroup = "Biceps (Stretch Mediated)"
        ..isIsolate = true
        ..hasCablePosition = true,

      // --- CORE ---
      Exercise()
        ..name = "Cable Crunch"
        ..muscleGroup = MuscleGroup.core
        ..subGroup = "Front Abs"
        ..hasCablePosition = true,
      Exercise()
        ..name = "Hanging Leg Raise"
        ..muscleGroup = MuscleGroup.core
        ..subGroup = "Lower Abs",
      Exercise()
        ..name = "Plank (Weighted)"
        ..muscleGroup = MuscleGroup.core
        ..subGroup = "Stabilizers",
      Exercise()
        ..name = "Single Arm Cable Woodchopper"
        ..muscleGroup = MuscleGroup.core
        ..subGroup = "Obliques"
        ..isIsolate = true
        ..hasCablePosition = true,
      Exercise()
        ..name = "Dead Bug"
        ..muscleGroup = MuscleGroup.core
        ..subGroup = "Stabilizers",
      Exercise()
        ..name = "Ab Roller"
        ..muscleGroup = MuscleGroup.core
        ..subGroup = "Lower Abs",

      // --- CARDIO ---
      Exercise()
        ..name = "Treadmill (LISS)"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "LISS",
      Exercise()
        ..name = "Cycling (LISS)"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "LISS",
      Exercise()
        ..name = "Elliptical"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "LISS",
      Exercise()
        ..name = "Stair Climber"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "LISS",
      Exercise()
        ..name = "HIIT Sprint Intervals"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "HIIT",
      Exercise()
        ..name = "Rowing Machine"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "Full Body",
      Exercise()
        ..name = "Swimming"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "Sport",
      Exercise()
        ..name = "Basketball"
        ..muscleGroup = MuscleGroup.cardio
        ..subGroup = "Sport",
    ];

    await isar.writeTxn(() async {
      final existing = await isar.exercises.where().findAll();
      final existingMap = {for (var e in existing) e.name: e};

      // 1. Update/Add defaults
      for (var def in defaults) {
        def.isCustom = false; // Always explicitly default
        final match = existingMap[def.name];

        // Apply tracking defaults based on muscle group
        if (def.muscleGroup == MuscleGroup.cardio) {
          def.trackWeightReps = false;
          def.trackDistance = true;
          def.trackSpeed = true;
          def.trackCalories = true;
          def.caloriesUnit = "kJ";
        } else {
          def.trackWeightReps = true;
        }

        if (match != null) {
          // Update properties
          match.muscleGroup = def.muscleGroup;
          match.subGroup = def.subGroup;
          match.isIsolate = def.isIsolate;
          match.hasCablePosition = def.hasCablePosition;
          match.hasBenchPosition = def.hasBenchPosition;
          match.isCustom = false;

          // Sync tracking flags for defaults
          match.trackWeightReps = def.trackWeightReps;
          match.trackDistance = def.trackDistance;
          match.trackSpeed = def.trackSpeed;
          match.trackCalories = def.trackCalories;
          match.caloriesUnit = def.caloriesUnit;

          await isar.exercises.put(match);
        } else {
          await isar.exercises.put(def);
        }
      }

      // 2. Fix all exercises in database:
      // Force Weight & Reps on for all non-cardio exercises that lost it.
      // Force Cardio metrics for all cardio exercises.
      final currentExercises = await isar.exercises.where().findAll();
      for (final ex in currentExercises) {
        bool changed = false;
        if (ex.muscleGroup != MuscleGroup.cardio) {
          if (!ex.trackWeightReps) {
            ex.trackWeightReps = true;
            changed = true;
          }
        } else {
          // Force cardio metrics for ALL cardio exercises
          if (ex.trackWeightReps) {
            ex.trackWeightReps = false;
            changed = true;
          }
          if (!ex.trackDistance || !ex.trackSpeed || !ex.trackCalories) {
            ex.trackDistance = true;
            ex.trackSpeed = true;
            ex.trackCalories = true;
            ex.caloriesUnit = "kJ";
            changed = true;
          }
        }
        if (changed) {
          await isar.exercises.put(ex);
        }
      }
    });
  }

  Future<void> seedDefaultTemplates() async {
    final isar = await _isarService.db;

    // 1. Check if we already have folders
    final existingFolders = await isar.templateFolders.count();
    if (existingFolders > 0) return;

    await isar.writeTxn(() async {
      // Helper to find a default exercise by name
      Future<Exercise?> findEx(String name) async {
        return await isar.exercises.filter().nameEqualTo(name).findFirst();
      }

      // --- FULL BODY ---
      final fullBodyFolder = TemplateFolder()..name = "Default Workouts";
      await isar.templateFolders.put(fullBodyFolder);

      final fullBodyWorkouts = [
        (
          "Full Body A",
          [
            "Flat Bench Press",
            "Bent Over Row",
            "Barbell Squat",
            "Overhead Press (BB)",
            "Lat Pulldown",
          ],
        ),
        (
          "Full Body B",
          [
            "Incline Bench Press",
            "Deadlift",
            "Leg Press",
            "Lateral Raise (DB)",
            "Barbell Curl",
          ],
        ),
        (
          "Full Body C",
          [
            "Dips (Chest Focus)",
            "Pull-up",
            "Walking Lunges",
            "Face Pull",
            "Triceps Pushdown",
          ],
        ),
      ];

      for (var fbw in fullBodyWorkouts) {
        final tmpl = WorkoutTemplate()..name = fbw.$1;
        await isar.workoutTemplates.put(tmpl);
        tmpl.folder.value = fullBodyFolder;
        await tmpl.folder.save();

        for (var i = 0; i < fbw.$2.length; i++) {
          final ex = await findEx(fbw.$2[i]);
          if (ex != null) {
            final te = TemplateExercise()..orderIndex = i;
            await isar.templateExercises.put(te);
            te.exercise.value = ex;
            await te.exercise.save();
            te.sets = List.generate(
              3,
              (_) => WorkoutSet()
                ..weight = 10.0
                ..reps = 10
                ..isRestTimerEnabled = true
                ..restDuration = (ex.isIsolate ? 45 : 90),
            );
            await isar.templateExercises.put(te);
            tmpl.exercises.add(te);
          }
        }
        await tmpl.exercises.save();
        fullBodyFolder.templates.add(tmpl);
      }
      await fullBodyFolder.templates.save();

      // --- PPL ---
      final pplFolder = TemplateFolder()..name = "Push Pull Legs";
      await isar.templateFolders.put(pplFolder);

      final pplWorkouts = [
        (
          "Push",
          [
            "Flat Bench Press",
            "Incline Bench Press",
            "Overhead Press (BB)",
            "Lateral Raise (DB)",
            "Triceps Pushdown",
          ],
        ),
        (
          "Pull",
          [
            "Lat Pulldown",
            "Bent Over Row",
            "Seated Cable Row",
            "Face Pull",
            "Barbell Curl",
            "Hammer Curl",
          ],
        ),
        (
          "Legs",
          [
            "Barbell Squat",
            "Leg Press",
            "Leg Curl (Lying)",
            "Walking Lunges",
            "Standing Calf Raise",
          ],
        ),
      ];

      for (var ppl in pplWorkouts) {
        final tmpl = WorkoutTemplate()..name = ppl.$1;
        await isar.workoutTemplates.put(tmpl);
        tmpl.folder.value = pplFolder;
        await tmpl.folder.save();
        for (var i = 0; i < ppl.$2.length; i++) {
          final ex = await findEx(ppl.$2[i]);
          if (ex != null) {
            final te = TemplateExercise()..orderIndex = i;
            await isar.templateExercises.put(te);
            te.exercise.value = ex;
            await te.exercise.save();
            te.sets = List.generate(
              3,
              (_) => WorkoutSet()
                ..weight = 10.0
                ..reps = 10
                ..isRestTimerEnabled = true
                ..restDuration = (ex.isIsolate ? 45 : 90),
            );
            await isar.templateExercises.put(te);
            tmpl.exercises.add(te);
          }
        }
        await tmpl.exercises.save();
        pplFolder.templates.add(tmpl);
      }
      await pplFolder.templates.save();

      // --- UPPER LOWER ---
      final ulFolder = TemplateFolder()..name = "Upper Lower Split";
      await isar.templateFolders.put(ulFolder);

      final ulWorkouts = [
        (
          "Upper",
          [
            "Flat Bench Press",
            "Bent Over Row",
            "Overhead Press (BB)",
            "Lat Pulldown",
            "Barbell Curl",
            "Triceps Pushdown",
          ],
        ),
        (
          "Lower",
          [
            "Barbell Squat",
            "Deadlift",
            "Leg Press",
            "Leg Curl (Lying)",
            "Standing Calf Raise",
            "Crunch",
          ],
        ),
      ];

      for (var ul in ulWorkouts) {
        final tmpl = WorkoutTemplate()..name = ul.$1;
        await isar.workoutTemplates.put(tmpl);
        tmpl.folder.value = ulFolder;
        await tmpl.folder.save();
        for (var i = 0; i < ul.$2.length; i++) {
          final ex = await findEx(ul.$2[i]);
          if (ex != null) {
            final te = TemplateExercise()..orderIndex = i;
            await isar.templateExercises.put(te);
            te.exercise.value = ex;
            await te.exercise.save();
            te.sets = List.generate(
              3,
              (_) => WorkoutSet()
                ..weight = 10.0
                ..reps = 10
                ..isRestTimerEnabled = true
                ..restDuration = (ex.isIsolate ? 45 : 90),
            );
            await isar.templateExercises.put(te);
            tmpl.exercises.add(te);
          }
        }
        await tmpl.exercises.save();
        ulFolder.templates.add(tmpl);
      }
      await ulFolder.templates.save();

      // --- BRO SPLIT ---
      final broFolder = TemplateFolder()..name = "Bro Split";
      await isar.templateFolders.put(broFolder);

      final broWorkouts = [
        (
          "Chest Day",
          [
            "Flat Bench Press",
            "Incline Bench Press",
            "Dips (Chest Focus)",
            "Cable Crossover",
          ],
        ),
        ("Back Day", ["Pull-up", "Lat Pulldown", "Bent Over Row", "Deadlift"]),
        (
          "Shoulder Day",
          [
            "Overhead Press (BB)",
            "Lateral Raise (DB)",
            "Rear Delt Fly (DB)",
            "Dumbbell Shrug",
          ],
        ),
        (
          "Leg Day",
          [
            "Barbell Squat",
            "Leg Press",
            "Leg Curl (Lying)",
            "Standing Calf Raise",
          ],
        ),
        (
          "Arm Day",
          ["Barbell Curl", "Hammer Curl", "Skull Crusher", "Triceps Pushdown"],
        ),
      ];

      for (var bro in broWorkouts) {
        final tmpl = WorkoutTemplate()..name = bro.$1;
        await isar.workoutTemplates.put(tmpl);
        tmpl.folder.value = broFolder;
        await tmpl.folder.save();
        for (var i = 0; i < bro.$2.length; i++) {
          final ex = await findEx(bro.$2[i]);
          if (ex != null) {
            final te = TemplateExercise()..orderIndex = i;
            await isar.templateExercises.put(te);
            te.exercise.value = ex;
            await te.exercise.save();
            te.sets = List.generate(
              3,
              (_) => WorkoutSet()
                ..weight = 10.0
                ..reps = 10
                ..isRestTimerEnabled = true
                ..restDuration = (ex.isIsolate ? 45 : 90),
            );
            await isar.templateExercises.put(te);
            tmpl.exercises.add(te);
          }
        }
        await tmpl.exercises.save();
        broFolder.templates.add(tmpl);
      }
      await broFolder.templates.save();
    });
  }

  // --- Templates & Folders CRUD ---

  Future<List<TemplateFolder>> getAllFolders() async {
    final isar = await _isarService.db;
    return await isar.templateFolders.filter().parentIsNull().findAll();
  }

  Future<List<TemplateFolder>> getSubFolders(int parentId) async {
    final isar = await _isarService.db;
    final parent = await isar.templateFolders.get(parentId);
    if (parent == null) return [];
    await parent.subFolders.load();
    return parent.subFolders.toList();
  }

  Future<List<WorkoutTemplate>> getTemplatesInFolderRaw(int folderId) async {
    final isar = await _isarService.db;
    final folder = await isar.templateFolders.get(folderId);
    if (folder == null) return [];
    await folder.templates.load();
    return folder.templates.toList();
  }

  Future<List<TemplateViewModel>> getTemplatesInFolder(int folderId) async {
    final isar = await _isarService.db;
    final folder = await isar.templateFolders.get(folderId);
    if (folder == null) return [];

    await folder.templates.load();
    final viewModels = <TemplateViewModel>[];
    for (final template in folder.templates) {
      await template.exercises.load();
      viewModels.add(
        TemplateViewModel(
          id: template.id,
          name: template.name,
          folderName: folder.name,
          exercises: template.exercises.toList(),
        ),
      );
    }
    return viewModels;
  }

  Future<void> createFolder(String name, {int? parentId}) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final folder = TemplateFolder()..name = name;
      await isar.templateFolders.put(folder);
      if (parentId != null) {
        final parent = await isar.templateFolders.get(parentId);
        if (parent != null) {
          folder.parent.value = parent;
          await folder.parent.save();
        }
      }
    });
  }

  Future<void> deleteFolder(int folderId) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final folder = await isar.templateFolders.get(folderId);
      if (folder != null) {
        await folder.templates.load();
        for (final tmpl in folder.templates) {
          await tmpl.exercises.load();
          final exerciseIds = tmpl.exercises.map((e) => e.id).toList();
          await isar.templateExercises.deleteAll(exerciseIds);
          await isar.workoutTemplates.delete(tmpl.id);
        }
        await isar.templateFolders.delete(folderId);
      }
    });
  }

  // --- Auto Workout ---

  Future<AutoWorkoutConfig?> getAutoWorkoutConfig() async {
    final isar = await _isarService.db;
    return await isar.autoWorkoutConfigs.get(1); // Single config at ID 1
  }

  Future<void> saveAutoWorkoutConfig(AutoWorkoutConfig config) async {
    final isar = await _isarService.db;
    config.id = 1; // Ensure it always uses ID 1
    await isar.writeTxn(() => isar.autoWorkoutConfigs.put(config));
  }

  Future<List<TemplateFolder>> getLeafFoldersRecursive(int parentId) async {
    final isar = await _isarService.db;
    final parent = await isar.templateFolders.get(parentId);
    if (parent == null) return [];

    await parent.subFolders.load();
    if (parent.subFolders.isEmpty) {
      // It's a leaf folder
      return [parent];
    }

    final List<TemplateFolder> leaves = [];
    for (var sub in parent.subFolders) {
      leaves.addAll(await getLeafFoldersRecursive(sub.id));
    }
    return leaves;
  }

  Future<void> deleteTemplate(int templateId) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final tmpl = await isar.workoutTemplates.get(templateId);
      if (tmpl != null) {
        await tmpl.exercises.load();
        final exerciseIds = tmpl.exercises.map((e) => e.id).toList();
        await isar.templateExercises.deleteAll(exerciseIds);
        await isar.workoutTemplates.delete(templateId);
      }
    });
  }

  Future<void> saveTemplateWithData(
    String name,
    List<Map<String, dynamic>> exercisesData, {
    int? folderId,
    String? folderName,
    int? parentId,
  }) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      TemplateFolder? folder;

      if (folderId != null) {
        folder = await isar.templateFolders.get(folderId);
      } else if (folderName != null) {
        folder = await isar.templateFolders
            .filter()
            .nameEqualTo(folderName, caseSensitive: false)
            .optional(
              parentId != null,
              (q) => q.parent((pq) => pq.idEqualTo(parentId!)),
            )
            .findFirst();

        if (folder == null) {
          folder = TemplateFolder()..name = folderName;
          await isar.templateFolders.put(folder);
          if (parentId != null) {
            final parent = await isar.templateFolders.get(parentId);
            if (parent != null) {
              folder.parent.value = parent;
              await folder.parent.save();
            }
          }
        }
      }

      if (folder == null) return;

      final template = WorkoutTemplate()..name = name;
      await isar.workoutTemplates.put(template);
      template.folder.value = folder;
      await template.folder.save();

      for (int i = 0; i < exercisesData.length; i++) {
        final exData = exercisesData[i];
        final exName = exData['name'] as String;

        // Find existing exercise or skip (it should already be created by the cubit if missing)
        final exercise = await isar.exercises
            .filter()
            .nameEqualTo(exName, caseSensitive: false)
            .findFirst();

        if (exercise == null) continue;

        final setsRaw = exData['sets'];
        List<WorkoutSet> setsToSave = [];

        if (setsRaw is List) {
          setsToSave = setsRaw.map((s) {
            final sMap = s as Map<String, dynamic>;
            final rest =
                (sMap['restDuration'] as num?)?.toInt() ??
                (exercise.isIsolate ? 45 : 90);
            return WorkoutSet()
              ..weight = (sMap['weight'] as num?)?.toDouble() ?? 0.0
              ..reps = (sMap['reps'] as num?)?.toInt() ?? 0
              ..isCompleted = false
              ..restDuration = rest
              ..isRestTimerEnabled = sMap['isRestTimerEnabled'] as bool? ?? true
              ..rir = (sMap['rir'] as num?)?.toInt()
              ..isFailure = sMap['isFailure'] as bool? ?? false
              ..spotReps = (sMap['spotReps'] as num?)?.toInt()
              ..myoReps = (sMap['myoReps'] as num?)?.toInt()
              ..myoPauseSeconds = (sMap['myoPauseSeconds'] as num?)?.toInt()
              ..partialReps = (sMap['partialReps'] as num?)?.toInt()
              ..isDropSet = sMap['isDropSet'] as bool? ?? false
              ..isWarmUp = sMap['isWarmUp'] as bool? ?? false
              ..eccentricSeconds = (sMap['eccentricSeconds'] as num?)?.toInt()
              ..concentricSeconds = (sMap['concentricSeconds'] as num?)?.toInt()
              ..isometricSeconds = (sMap['isometricSeconds'] as num?)?.toInt()
              ..cablePosition = (sMap['cablePosition'] as num?)?.toInt()
              ..benchPosition = (sMap['benchPosition'] as num?)?.toInt()
              ..distance = (sMap['distance'] as num?)?.toDouble()
              ..speed = (sMap['speed'] as num?)?.toDouble()
              ..calories = (sMap['calories'] as num?)?.toDouble();
          }).toList();
        } else if (setsRaw is int) {
          // Fallback for legacy format
          final count = setsRaw;
          final weight = (exData['weight'] as num?)?.toDouble() ?? 10.0;
          final reps = (exData['reps'] as num?)?.toInt() ?? 10;
          setsToSave = List.generate(
            count,
            (_) => WorkoutSet()
              ..weight = weight
              ..reps = reps
              ..isCompleted = false
              ..restDuration = exercise.isIsolate ? 45 : 90
              ..isRestTimerEnabled = true,
          );
        }

        final templateEx = TemplateExercise()
          ..orderIndex = i
          ..sets = setsToSave;

        await isar.templateExercises.put(templateEx);
        templateEx.exercise.value = exercise;
        await templateEx.exercise.save();
        template.exercises.add(templateEx);
      }
      await template.exercises.save();

      folder.templates.add(template);
      await folder.templates.save();
    });
  }

  Future<void> saveWorkoutAsTemplate(
    DateTime date,
    String name, {
    int? folderId,
    String? folderName,
    int? parentId,
  }) async {
    final isar = await _isarService.db;
    final workout = await getWorkoutForDate(date);
    if (workout == null || workout.exercises.isEmpty) return;

    await isar.writeTxn(() async {
      TemplateFolder? folder;

      if (folderId != null) {
        folder = await isar.templateFolders.get(folderId);
      } else if (folderName != null) {
        folder = await isar.templateFolders
            .filter()
            .nameEqualTo(folderName, caseSensitive: false)
            .optional(
              parentId != null,
              (q) => q.parent((pq) => pq.idEqualTo(parentId!)),
            )
            .findFirst();

        if (folder == null) {
          folder = TemplateFolder()..name = folderName;
          await isar.templateFolders.put(folder);
          if (parentId != null) {
            final parent = await isar.templateFolders.get(parentId);
            if (parent != null) {
              folder.parent.value = parent;
              await folder.parent.save();
            }
          }
        }
      }

      if (folder == null) return;

      final template = WorkoutTemplate()..name = name;
      await isar.workoutTemplates.put(template);
      template.folder.value = folder;
      await template.folder.save();

      for (final log in workout.exercises) {
        await log.exercise.load();
        final templateEx = TemplateExercise()
          ..orderIndex = log.orderIndex
          ..sets = log.sets
              .map(
                (s) => WorkoutSet()
                  ..weight = s.weight
                  ..reps = s.reps
                  ..side = s.side
                  ..rir = s.rir
                  ..isFailure = s.isFailure
                  ..spotReps = s.spotReps
                  ..myoReps = s.myoReps
                  ..myoPauseSeconds = s.myoPauseSeconds
                  ..partialReps = s.partialReps
                  ..isDropSet = s.isDropSet
                  ..isWarmUp = s.isWarmUp
                  ..eccentricSeconds = s.eccentricSeconds
                  ..concentricSeconds = s.concentricSeconds
                  ..isometricSeconds = s.isometricSeconds
                  ..isRestTimerEnabled = s.isRestTimerEnabled
                  ..restDuration = s.restDuration
                  ..cablePosition = s.cablePosition
                  ..benchPosition = s.benchPosition
                  ..distance = s.distance
                  ..speed = s.speed
                  ..calories = s.calories
                  ..dropSetItems = List.from(s.dropSetItems)
                  ..isCompleted = false,
              )
              .toList();

        await isar.templateExercises.put(templateEx);
        templateEx.exercise.value = log.exercise.value;
        await templateEx.exercise.save();
        template.exercises.add(templateEx);
      }
      await template.exercises.save();

      folder.templates.add(template);
      await folder.templates.save();

      // NEW: Link this workout day to the newly created template
      // so next time we apply it, we can trace back to this day.
      workout.templateId = template.id;
      await isar.workoutDays.put(workout);
    });
  }

  Future<void> applyTemplate(DateTime date, int templateId) async {
    final isar = await _isarService.db;
    final template = await isar.workoutTemplates.get(templateId);
    if (template == null) return;

    await template.exercises.load();
    final target = await getOrCreateWorkoutForDate(date);

    // Find the last session that used this same template to inherit its weights/reps
    final lastSessionWithThisTemplate = await isar.workoutDays
        .filter()
        .templateIdEqualTo(templateId)
        .sortByDateDesc()
        .findFirst();

    // Map of exercise ID -> last sets used
    final lastDataMap = <int, List<WorkoutSet>>{};
    if (lastSessionWithThisTemplate != null) {
      await lastSessionWithThisTemplate.exercises.load();
      for (final log in lastSessionWithThisTemplate.exercises) {
        await log.exercise.load();
        if (log.exercise.value != null) {
          lastDataMap[log.exercise.value!.id] = log.sets;
        }
      }
    }

    // Map of exercise ID -> heritage sets
    final heritageMap = <int, List<WorkoutSet>>{};

    // 1. Heritage Discovery (Pre-fetch outside transaction)
    for (final tmplEx in template.exercises) {
      await tmplEx.exercise.load();
      final exercise = tmplEx.exercise.value;
      if (exercise == null) continue;

      // Tier 1: Exact matching from last session with THIS template
      final lastSets = lastDataMap[exercise.id];
      if (lastSets != null) {
        heritageMap[exercise.id] = lastSets;
        continue;
      }

      // Tier 2 Fallback: If no template history, fetch the absolute last session best for this exercise
      var historyFallback = await getLastSessionSetForExercise(exercise.id);
      // If still null, try all-time best
      historyFallback ??= await getBestSetForExercise(exercise.id);

      if (historyFallback != null) {
        heritageMap[exercise.id] = [historyFallback];
      }
    }

    await isar.writeTxn(() async {
      for (final tmplEx in template.exercises) {
        await tmplEx.exercise.load();
        final exercise = tmplEx.exercise.value;
        if (exercise == null) continue;

        final heritageSets = heritageMap[exercise.id];

        final log = WorkoutExerciseLog()
          ..orderIndex = tmplEx.orderIndex
          ..sets = tmplEx.sets.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;

            // Tier 1 & 2 Integration: heritageSets will contain either
            // the full session history (Tier 1) or a single best set (Tier 2).
            if (heritageSets != null) {
              // For Tier 1: exact index match if possible
              // For Tier 2: heritageSets length is 1, so indices > 0 default to template
              final refS = i < heritageSets.length
                  ? heritageSets[i]
                  : (heritageSets.length == 1 ? heritageSets[0] : null);

              if (refS != null) {
                return WorkoutSet()
                  ..weight = refS.weight
                  ..reps = refS.reps
                  ..side = refS.side
                  ..restDuration = s.restDuration
                  ..isRestTimerEnabled = s.isRestTimerEnabled
                  ..rir = refS.rir
                  ..isFailure = refS.isFailure
                  ..spotReps = refS.spotReps
                  ..myoReps = refS.myoReps
                  ..myoPauseSeconds = refS.myoPauseSeconds
                  ..partialReps = refS.partialReps
                  ..isDropSet = refS.isDropSet
                  ..isWarmUp = refS.isWarmUp
                  ..eccentricSeconds = refS.eccentricSeconds
                  ..concentricSeconds = refS.concentricSeconds
                  ..isometricSeconds = refS.isometricSeconds
                  ..cablePosition = refS.cablePosition
                  ..benchPosition = refS.benchPosition
                  ..distance = refS.distance
                  ..speed = refS.speed
                  ..calories = refS.calories
                  ..dropSetItems = List.from(refS.dropSetItems);
              }
            }

            // Tier 3: Hard defaults from template
            return WorkoutSet()
              ..weight = s.weight
              ..reps = s.reps
              ..side = s.side
              ..rir = s.rir
              ..isFailure = s.isFailure
              ..spotReps = s.spotReps
              ..myoReps = s.myoReps
              ..myoPauseSeconds = s.myoPauseSeconds
              ..partialReps = s.partialReps
              ..isDropSet = s.isDropSet
              ..isWarmUp = s.isWarmUp
              ..eccentricSeconds = s.eccentricSeconds
              ..concentricSeconds = s.concentricSeconds
              ..isometricSeconds = s.isometricSeconds
              ..isRestTimerEnabled = s.isRestTimerEnabled
              ..restDuration = s.restDuration
              ..cablePosition = s.cablePosition
              ..benchPosition = s.benchPosition
              ..distance = s.distance
              ..speed = s.speed
              ..calories = s.calories
              ..dropSetItems = List.from(s.dropSetItems);
          }).toList();

        await isar.workoutExerciseLogs.put(log);
        log.exercise.value = exercise;
        await log.exercise.save();
        target.exercises.add(log);
      }
      await target.exercises.save();

      target.templateId = templateId; // Link it
      target.isRestDay = false;
      await isar.workoutDays.put(target);
    });
  }

  Future<void> toggleRestDay(DateTime date) async {
    final isar = await _isarService.db;
    final workout = await getOrCreateWorkoutForDate(date);

    await isar.writeTxn(() async {
      workout.isRestDay = !workout.isRestDay;
      // If it's now a rest day, maybe we should clear exercises?
      // User didn't specify, but usually rest day means no exercises.
      // I'll keep them just in case they toggled by mistake.
      await isar.workoutDays.put(workout);
    });
  }

  // --- PR Detection & Plate Calculator ---

  Future<WorkoutSet?> getBestSetForExercise(int exerciseId) async {
    final isar = await _isarService.db;
    final pastLogs = await isar.workoutExerciseLogs
        .filter()
        .exercise((q) => q.idEqualTo(exerciseId))
        .findAll();

    WorkoutSet? bestSet;
    double maxE1RM = -1;

    for (final log in pastLogs) {
      for (final s in log.sets) {
        final w = s.weight ?? 0.0;
        final r = s.reps?.toDouble() ?? 0.0;
        if (w <= 0 || r <= 0 || !s.isCompleted)
          continue; // Only count completed sets

        final e1rm = AnalyticsService.calculate1RM(w, r.toInt());
        if (e1rm > maxE1RM) {
          maxE1RM = e1rm;
          bestSet = s;
        }
      }
    }
    return bestSet;
  }

  Future<WorkoutSet?> getLastSessionSetForExercise(int exerciseId) async {
    final isar = await _isarService.db;
    // Find the most recent WorkoutDay that contains this exercise
    final lastWorkout = await isar.workoutDays
        .filter()
        .exercises((q) => q.exercise((e) => e.idEqualTo(exerciseId)))
        .sortByDateDesc()
        .findFirst();

    if (lastWorkout != null) {
      // Find the specific log for this exercise in that day
      for (final log in lastWorkout.exercises) {
        await log.exercise.load();
        if (log.exercise.value?.id == exerciseId) {
          if (log.sets.isNotEmpty) {
            // Return the best set from that specific last session (by volume)
            double maxVol = -1;
            WorkoutSet? bestInSession;
            for (final s in log.sets) {
              if (!s.isCompleted) continue;
              final vol = (s.weight ?? 0) * (s.reps ?? 0);
              if (vol > maxVol) {
                maxVol = vol.toDouble();
                bestInSession = s;
              }
            }
            return bestInSession ?? log.sets.first;
          }
        }
      }
    }
    return null;
  }

  Future<bool> checkIfRecentBest(
    int exerciseId,
    WorkoutSet set, {
    int days = 30,
  }) async {
    // Calculate metrics for the new set
    final weight = set.weight ?? 0.0;
    final reps = set.reps?.toDouble() ?? 0.0;
    if (weight <= 0 || reps <= 0) return false;

    final newE1RM = AnalyticsService.calculate1RM(weight, reps.toInt());
    final newVolume = weight * reps;

    // Find logs for this exercise within the last X days
    final startDate = DateTime.now().subtract(Duration(days: days));

    // Use getExerciseHistory which already handles date filtering and link loading correctly.
    final history = await getExerciseHistory(exerciseId, startDate);

    double maxWeight = 0;
    double maxE1RM = 0;
    double maxVolume = 0;

    for (final sets in history.values) {
      for (final pastSet in sets) {
        if (!pastSet.isCompleted) continue;

        // Skip the current set if it's already in history (might happen if saved)
        // We'll compare against a small epsilon or just assume we want STRICTLY BETTER
        // than the best of the PAST 30 days.

        final pw = pastSet.weight ?? 0.0;
        final pr = pastSet.reps?.toDouble() ?? 0.0;
        final pe1rm = AnalyticsService.calculate1RM(pw, pr.toInt());
        final pvol = pw * pr;

        if (pw > maxWeight) maxWeight = pw;
        if (pe1rm > maxE1RM) maxE1RM = pe1rm;
        if (pvol > maxVolume) maxVolume = pvol;
      }
    }

    // It's a recent PR if it beats (strictly) the best of the last 30 days.
    // Or >= if we want the "matching" behavior. User said "not reset", implying standard PR behavior.
    return (weight > maxWeight) ||
        (newE1RM > maxE1RM) ||
        (newVolume > maxVolume);
  }

  Future<bool> checkIfPr(int exerciseId, WorkoutSet set) async {
    final isar = await _isarService.db;

    // Calculate metrics for the new set
    final weight = set.weight ?? 0.0;
    final reps = set.reps?.toDouble() ?? 0.0;
    if (weight <= 0 || reps <= 0) return false;

    final newE1RM = AnalyticsService.calculate1RM(weight, reps.toInt());
    final newVolume = weight * reps;

    // Find all past logs for this exercise
    final pastLogs = await isar.workoutExerciseLogs
        .filter()
        .exercise((q) => q.idEqualTo(exerciseId))
        .findAll();

    double maxWeight = 0;
    double maxE1RM = 0;
    double maxVolume = 0;

    for (final log in pastLogs) {
      for (final pastSet in log.sets) {
        if (!pastSet.isCompleted) continue;

        final pw = pastSet.weight ?? 0.0;
        final pr = pastSet.reps?.toDouble() ?? 0.0;
        final pe1rm = AnalyticsService.calculate1RM(pw, pr.toInt());
        final pvol = pw * pr;

        if (pw > maxWeight) maxWeight = pw;
        if (pe1rm > maxE1RM) maxE1RM = pe1rm;
        if (pvol > maxVolume) maxVolume = pvol;
      }
    }

    return (weight >= maxWeight && weight > 0) ||
        (newE1RM >= maxE1RM && newE1RM > 0) ||
        (newVolume >= maxVolume && newVolume > 0);
  }

  // Removed local _calculateE1RM to use AnalyticsService

  Future<UserSettings> getUserSettings() async {
    final isar = await _isarService.db;
    var settings = await isar.userSettings.get(0);
    if (settings == null) {
      settings = UserSettings();
      await isar.writeTxn(() => isar.userSettings.put(settings!));
    }
    return settings;
  }

  Future<void> updateUserSettings(UserSettings settings) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.userSettings.put(settings));
  }

  Future<void> updateBarbellWeight(int exerciseId, double weight) async {
    final isar = await _isarService.db;
    final exercise = await isar.exercises.get(exerciseId);
    if (exercise != null) {
      exercise.barbellWeight = weight;
      await isar.writeTxn(() => isar.exercises.put(exercise));
    }
  }

  Future<void> updateStepsAndDistance(
    DateTime date,
    int steps,
    double distance,
  ) async {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(date);
    await isar.writeTxn(() async {
      var workout = await isar.workoutDays
          .filter()
          .dateEqualTo(normalizedDate)
          .findFirst();
      if (workout == null) {
        workout = WorkoutDay()..date = normalizedDate;
      }
      workout.steps = steps;
      workout.distanceMeters = distance;
      await isar.workoutDays.put(workout);
    });
  }

  Future<List<MapEntry<DateTime, double>>> getStepsHistory(
    DateTime start,
    DateTime end,
  ) async {
    final isar = await _isarService.db;
    final workouts = await isar.workoutDays
        .filter()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();
    return workouts.map((w) => MapEntry(w.date, w.steps.toDouble())).toList();
  }

  Future<List<MapEntry<DateTime, double>>> getDistanceHistory(
    DateTime start,
    DateTime end,
  ) async {
    final isar = await _isarService.db;
    final workouts = await isar.workoutDays
        .filter()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();
    return workouts.map((w) => MapEntry(w.date, w.distanceMeters)).toList();
  }

  Future<bool> checkIfSetPr(
    int exerciseId,
    int setIndex,
    WorkoutSet currentSet,
  ) async {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(DateTime.now());

    // Find all past logs for this exercise ordered by date
    final pastDays = await isar.workoutDays
        .filter()
        .dateLessThan(normalizedDate)
        .sortByDateDesc()
        .findAll();

    double currentVolume = (currentSet.weight ?? 0) * (currentSet.reps ?? 0);

    // Check if current volume beats the best volume for the SAME set index in history
    for (var day in pastDays) {
      // Find the log for this exercise in this day
      final log = day.exercises
          .where((e) => e.exercise.value?.id == exerciseId)
          .firstOrNull;
      if (log != null && setIndex < log.sets.length) {
        final pastSet = log.sets[setIndex];
        if (pastSet.isCompleted) {
          double pastVolume = (pastSet.weight ?? 0) * (pastSet.reps ?? 0);
          if (pastVolume >= currentVolume) {
            return false; // Found a past set at this index that was better or equal
          }
        }
      }
    }

    return true; // No better set found at this index in history
  }
}
