import 'package:muvio/data/datasources/isar_service.dart';
import 'package:muvio/data/models/fatigue_state.dart';
import 'package:muvio/data/models/exercise.dart';
import 'package:muvio/data/models/workout_day.dart';
import 'package:muvio/logic/calculators/fatigue_calculator.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'dart:math' as math;

/// Repository for tracking and managing muscle fatigue across workouts
class FatigueRepository {
  final IsarService _isarService;

  FatigueRepository(this._isarService);

  /// Get current fatigue percentage for a muscle group/subgroup
  Future<double> getCurrentFatigue({
    required DateTime workoutDate,
    required String muscleGroup,
    String? subGroup,
    String? side,
    bool usePeak = true, // By default return peak for UI consistency
  }) async {
    final isar = await _isarService.db;

    final normalizedDate = DateUtils.dateOnly(workoutDate);

    // Query by indexed workoutDate, then filter in memory
    final allStates = await isar.fatigueStates
        .where()
        .workoutDateEqualTo(normalizedDate)
        .findAll();

    // Filter for specific muscle group, subgroup, and side
    final fatigueState = allStates.firstWhere(
      (state) =>
          state.muscleGroup == muscleGroup &&
          state.subGroup == subGroup &&
          state.side == side,
      orElse: () {
        if (side != null) {
          return FatigueState()..currentFatiguePercent = 0.0;
        }

        if (muscleGroup.toLowerCase() == "arms" && subGroup != null) {
          return FatigueState()..currentFatiguePercent = 0.0;
        }

        return allStates.firstWhere(
          (state) =>
              state.muscleGroup == muscleGroup &&
              state.subGroup == null &&
              state.side == null,
          orElse: () => FatigueState()..currentFatiguePercent = 0.0,
        );
      },
    );

    if (usePeak) {
      return fatigueState.peakFatiguePercent;
    }

    if (fatigueState.currentFatiguePercent == 0.0 &&
        fatigueState.id == Isar.autoIncrement) {
      return 0.0;
    }

    // Calculate decay since last update
    final timeSinceUpdate = DateTime.now()
        .difference(fatigueState.lastUpdateTime)
        .inSeconds;
    final decayedFatigue = FatigueCalculator.calculateFatigueDecay(
      fatigueState.currentFatiguePercent,
      timeSinceUpdate,
    );

    return decayedFatigue;
  }

  /// Record set completion and update fatigue
  Future<void> recordSetCompletion({
    required DateTime workoutDate,
    required Exercise exercise,
    required WorkoutSet set,
    double? estimatedMax,
  }) async {
    if (!set.isCompleted) return;

    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(workoutDate);

    // Calculate fatigue increase from this set
    final fatigueIncrease = FatigueCalculator.calculateFatigueIncrease(
      set,
      exercise,
      estimatedMax: estimatedMax,
    );

    // Calculate cross-exercise fatigue transfer
    final fatigueTransfers = FatigueCalculator.calculateCrossExerciseFatigue(
      exercise,
      fatigueIncrease,
      side: set.side,
    );

    await isar.writeTxn(() async {
      // Update fatigue for all affected muscle groups
      for (final entry in fatigueTransfers.entries) {
        final parts = entry.key.split(':');
        String muscleGroup = parts[0];
        String? subGroup = parts.length > 1 ? parts[1] : null;
        String? sideStr = parts.length > 2 ? parts[2] : null;

        // Correct for keys like "Arms:L" where "L" is erroneously parsed as subGroup
        if (subGroup == "L" || subGroup == "R") {
          sideStr = subGroup;
          subGroup = null;
        }

        // Get all states for this date and filter in memory
        final allStates = await isar.fatigueStates
            .where()
            .workoutDateEqualTo(normalizedDate)
            .findAll();

        var fatigueState = allStates.cast<FatigueState?>().firstWhere(
          (state) =>
              state!.muscleGroup == muscleGroup &&
              state.subGroup == subGroup &&
              state.side == sideStr,
          orElse: () => null,
        );

        if (fatigueState == null) {
          fatigueState = FatigueState()
            ..workoutDate = normalizedDate
            ..muscleGroup = muscleGroup
            ..subGroup = subGroup
            ..side = sideStr
            ..currentFatiguePercent = 0.0
            ..lastUpdateTime = DateTime.now();
        }

        // Apply decay since last update
        final timeSinceUpdate = DateTime.now()
            .difference(fatigueState.lastUpdateTime)
            .inSeconds;
        fatigueState.currentFatiguePercent =
            FatigueCalculator.calculateFatigueDecay(
              fatigueState.currentFatiguePercent,
              timeSinceUpdate,
            );

        // --- Auto-Calibration Logic ---
        // Compare predicted reps vs actual reps to adjust fatigue model
        if (estimatedMax != null &&
            estimatedMax > 0 &&
            set.reps != null &&
            set.reps! > 0) {
          final weight = set.weight ?? 0.0;
          // 1. Calculate how many reps user could do if FRESH (using Epley inverse)
          // reps = (1RM/weight - 1) * 30
          final freshReps = ((estimatedMax / weight) - 1.0) * 30.0;

          if (freshReps > 0) {
            // 2. Predict reps based on CURRENT fatigue
            final performanceDrop = FatigueCalculator.calculatePerformanceDrop(
              fatigueState.currentFatiguePercent,
            );
            final predictedReps = FatigueCalculator.predictRepsWithFatigue(
              freshReps.round(),
              performanceDrop,
            );

            // 3. Compare with actual performance
            final diff = set.reps! - predictedReps;

            // If user did MORE reps than predicted, they are LESS fatigued
            // If user did FEWER reps (and it was a failure set), they are MORE fatigued
            double calibrationDelta = 0.0;
            if (diff > 0) {
              // Less fatigued: reduce fatigue by 5% per extra rep
              calibrationDelta = -diff * 5.0;
            } else if (diff < 0 && (set.isFailure || (set.rir ?? 0) == 0)) {
              // More fatigued: increase fatigue by 3% per missing rep
              calibrationDelta = -diff * 3.0;
            }

            fatigueState.currentFatiguePercent =
                (fatigueState.currentFatiguePercent + calibrationDelta).clamp(
                  0.0,
                  100.0,
                );
          }
        }

        // Add new fatigue and apply floors
        double newFatigue = FatigueCalculator.applyFatigueFloors(
          (fatigueState.currentFatiguePercent + entry.value),
          set,
          estimatedMax: estimatedMax,
        );

        fatigueState.currentFatiguePercent = newFatigue;
        if (newFatigue > fatigueState.peakFatiguePercent) {
          fatigueState.peakFatiguePercent = newFatigue;
        }

        fatigueState.lastUpdateTime = DateTime.now();

        // Record snapshot - create new list since Isar lists are fixed-length
        final snapshot = FatigueSnapshot()
          ..timestamp = DateTime.now()
          ..setNumber = fatigueState.snapshots.length + 1
          ..performanceDrop = FatigueCalculator.calculatePerformanceDrop(
            fatigueState.currentFatiguePercent,
          )
          ..restSeconds = set.restDuration ?? 0
          ..weight = set.weight ?? 0.0
          ..reps = set.reps ?? 0
          ..cablePosition = set.cablePosition
          ..benchPosition = set.benchPosition;

        fatigueState.snapshots = [...fatigueState.snapshots, snapshot];

        await isar.fatigueStates.put(fatigueState);
      }
    });
  }

  /// Get fatigue history for analysis
  Future<List<FatigueSnapshot>> getFatigueHistory({
    required DateTime workoutDate,
    required String muscleGroup,
    String? subGroup,
    String? side,
  }) async {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(workoutDate);

    // Query by date and filter in memory
    final allStates = await isar.fatigueStates
        .where()
        .workoutDateEqualTo(normalizedDate)
        .findAll();

    final fatigueState = allStates.cast<FatigueState?>().firstWhere(
      (state) =>
          state!.muscleGroup == muscleGroup &&
          state.subGroup == subGroup &&
          state.side == side,
      orElse: () => null,
    );

    return fatigueState?.snapshots ?? [];
  }

  /// Clear fatigue data for a specific date (e.g., start of new workout day)
  Future<void> clearDayFatigue(DateTime workoutDate) async {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(workoutDate);

    final states = await isar.fatigueStates
        .where()
        .workoutDateEqualTo(normalizedDate)
        .findAll();

    await isar.writeTxn(() async {
      await isar.fatigueStates.deleteAll(states.map((s) => s.id).toList());
    });
  }

  /// Recalculates all fatigue for a given day by re-playing completed sets
  Future<void> recalculateDayFatigue({
    required DateTime workoutDate,
    required WorkoutDay workoutDay,
    required Map<int, double> exerciseMaxes, // exerciseId -> estimatedMax
  }) async {
    // 1. Wipe existing fatigue for this day
    await clearDayFatigue(workoutDate);

    // 2. Re-play all completed sets in chronological order
    // Note: We assume the order in logs/sets is the performance order.
    for (final log in workoutDay.exercises) {
      final exercise = log.exercise.value;
      if (exercise == null) continue;

      final estimatedMax = exerciseMaxes[exercise.id];

      for (final set in log.sets) {
        if (set.isCompleted) {
          await recordSetCompletion(
            workoutDate: workoutDate,
            exercise: exercise,
            set: set,
            estimatedMax: estimatedMax,
          );
        }
      }
    }
  }

  /// Get fatigue history for a specific muscle group across multiple days
  Future<List<MapEntry<DateTime, double>>> getMuscleFatigueHistory({
    required DateTime start,
    required DateTime end,
    required String muscleGroup,
    String? subGroup,
  }) async {
    final isar = await _isarService.db;
    final normalizedStart = DateUtils.dateOnly(start);
    final normalizedEnd = DateUtils.dateOnly(end);

    final states = await isar.fatigueStates
        .filter()
        .workoutDateBetween(normalizedStart, normalizedEnd)
        .muscleGroupEqualTo(muscleGroup, caseSensitive: false)
        .findAll();

    final filtered = states.where((s) {
      if (subGroup == null) return true; // Take all for aggregation
      return s.subGroup?.toLowerCase() == subGroup.toLowerCase();
    }).toList();

    if (subGroup != null) {
      return filtered.map((s) {
        final val =
            s.currentFatiguePercent /
            math.sqrt(math.max(1, s.snapshots.length));
        return MapEntry(s.workoutDate, val);
      }).toList();
    }

    // Aggregate by date (Peak fatigue observed across any subgroup that day)
    // CORE IMPROVEMENT: We normalize fatigue by taking set-volume into account.
    // If we only look at peak fatigue, doing MORE work (improving) looks like "higher fatigue" (worsening).
    // Instead, we return (PeakFatigue / sqrt(Sets)) as a "Work-Adjusted Fatigue Index".
    final Map<DateTime, double> aggregated = {};
    for (var s in filtered) {
      final date = s.workoutDate;
      if (s.snapshots.isEmpty) continue; // Noise/Partial data

      // We use sqrt(length) because fatigue doesn't scale perfectly linear with sets
      final workAdjustedFatigue =
          s.currentFatiguePercent / math.sqrt(math.max(1, s.snapshots.length));

      aggregated[date] = math.max(aggregated[date] ?? 0, workAdjustedFatigue);
    }

    return aggregated.entries.map((e) => MapEntry(e.key, e.value)).toList();
  }
}
