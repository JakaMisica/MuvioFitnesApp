import 'dart:math';
import 'package:muvio/data/models/workout_day.dart';
import 'package:muvio/data/models/exercise.dart';

/// Calculates fatigue accumulation and decay for muscle groups
class FatigueCalculator {
  /// Calculates how much fatigue has naturally decayed based on rest time
  /// Milestones: 80% drop in 90s, 92% in 2m, 94% in 5m, 100% in 4 days
  static double calculateFatigueDecay(
    double initialFatigue,
    int secondsRested,
  ) {
    if (secondsRested <= 0) return initialFatigue;
    if (initialFatigue <= 0) return 0.0;

    double multiplier;

    if (secondsRested <= 90) {
      // 0 to 90s: Drops to 20% of initial (80% drop)
      multiplier = pow(0.2, secondsRested / 90.0).toDouble();
    } else if (secondsRested <= 120) {
      // 90s to 120s: Drops from 20% to 8% (92% total drop)
      final t = (secondsRested - 90) / 30.0;
      multiplier = 0.2 * pow(0.08 / 0.2, t);
    } else if (secondsRested <= 300) {
      // 120s to 300s: Drops from 8% to 6% (94% total drop)
      final t = (secondsRested - 120) / 180.0;
      multiplier = 0.08 * pow(0.06 / 0.08, t);
    } else {
      // 5m to 4 days: Drops from 6% to 0%
      const fourDays = 345600;
      if (secondsRested >= fourDays) return 0.0;

      final t = (secondsRested - 300) / (fourDays - 300);
      multiplier = 0.06 * (1.0 - t);
    }

    return (initialFatigue * multiplier).clamp(0.0, 100.0);
  }

  /// Calculates fatigue increase from completing a set
  /// Returns only the INCREASE amount, not the final total.
  static double calculateFatigueIncrease(
    WorkoutSet set,
    Exercise exercise, {
    double? estimatedMax,
  }) {
    final weight = set.weight ?? 0.0;
    final reps = set.reps ?? 0;

    if (weight <= 0 || reps <= 0) return 0.0;

    // 1. Calculate relative intensity
    final maxWeight = estimatedMax ?? (weight / (1.0278 - 0.0278 * 10));
    final relativeWeightIntensity = (weight / maxWeight).clamp(0.0, 1.2);

    // 2. Reps intensity
    final repsIntensity = (reps / 12.0).clamp(0.0, 1.5);

    // 3. RIR adjustment (Smart Inference)
    int effectiveRir = set.rir ?? 3;
    if (set.rir == null &&
        !set.isFailure &&
        !set.isWarmUp &&
        estimatedMax != null &&
        weight > 0) {
      final freshReps = ((estimatedMax / weight) - 1.0) * 30.0;
      if (freshReps > 0) {
        final repRatio = reps / freshReps;
        if (repRatio >= 0.96) {
          effectiveRir = 0;
        } else if (repRatio >= 0.92) {
          effectiveRir = 1;
        } else if (repRatio >= 0.88) {
          effectiveRir = 2;
        }
      }
    }

    final rirMultiplier = pow(0.85, effectiveRir).toDouble();

    // 4. Technique Multipliers
    double techniqueBoost = 1.0;
    if (set.isFailure) techniqueBoost = 1.5;
    if (set.myoReps != null && set.myoReps! > 0) techniqueBoost = 1.8;
    if (set.partialReps != null && set.partialReps! > 0) techniqueBoost = 1.6;
    if (set.spotReps != null && set.spotReps! > 0) techniqueBoost = 1.4;
    if (set.isDropSet) techniqueBoost = 1.7;

    final baseIntensity =
        (relativeWeightIntensity * 0.6) + (repsIntensity * 0.4);

    // Max theoretical increase for a single set is around 40% if not floored
    double calculatedIncrease =
        baseIntensity * 25.0 * rirMultiplier * techniqueBoost;

    if (set.isWarmUp) {
      return (calculatedIncrease * 0.1).clamp(0.5, 3.0);
    }

    return calculatedIncrease.clamp(2.0, 70.0);
  }

  /// User: DropSet=95, Failure=90, RIR floors=90-(RIR*5)
  static double applyFatigueFloors(
    double resultingFatigue,
    WorkoutSet set, {
    double? estimatedMax,
  }) {
    double floor = 0.0;

    if (set.isDropSet) floor = max(floor, 95.0);
    if (set.isFailure) floor = max(floor, 90.0);

    // Smart Floor Inference
    int? effectiveRir = set.rir;
    if (effectiveRir == null &&
        !set.isFailure &&
        !set.isWarmUp &&
        estimatedMax != null &&
        (set.weight ?? 0) > 0) {
      final freshReps = ((estimatedMax / (set.weight ?? 1.0)) - 1.0) * 30.0;
      if (freshReps > 0 && (set.reps ?? 0) > 0) {
        final repRatio = (set.reps ?? 0) / freshReps;
        if (repRatio >= 0.96) {
          effectiveRir = 0;
        } else if (repRatio >= 0.92) {
          effectiveRir = 1;
        } else if (repRatio >= 0.88) {
          effectiveRir = 2;
        }
      }
    }

    if (effectiveRir != null) {
      final rirFloor = 90.0 - (effectiveRir * 5.0).toDouble();
      floor = max(floor, rirFloor);
    }

    return max(resultingFatigue, floor).clamp(0.0, 100.0);
  }

  /// Calculates fatigue transfer to other muscles
  /// Key format: muscleGroup:subGroup:side
  static Map<String, double> calculateCrossExerciseFatigue(
    Exercise sourceExercise,
    double sourceFatigue, {
    String? side,
  }) {
    final transferMap = <String, double>{};

    final primaryGroup = sourceExercise.muscleGroup.name;
    final primarySubGroup = sourceExercise.subGroup;

    String primaryKey = primaryGroup;
    if (primarySubGroup != null && primarySubGroup.isNotEmpty) {
      primaryKey += ':$primarySubGroup';
    }
    if (side != null) {
      primaryKey += ':$side';
    }

    transferMap[primaryKey] = sourceFatigue;

    // Engagement transfer
    final subGroupEngagement = sourceExercise.subGroupEngagement;
    for (final entry in subGroupEngagement.entries) {
      String subKey = '$primaryGroup:${entry.key}';
      if (side != null) subKey += ':$side';
      transferMap[subKey] = sourceFatigue * (entry.value / 100.0);
    }

    // Secondary transfer
    final secondaryEngagement = sourceExercise.secondaryMuscleEngagement;
    if (secondaryEngagement.isNotEmpty) {
      for (final entry in secondaryEngagement.entries) {
        String key = entry.key;
        if (side != null && !key.contains(':')) {
          // If secondary is just "Arms", and side is "L", make it "Arms:L"
          // If it's "Arms:Triceps", we don't necessarily know if triceps has side support yet
          // but for biceps/triceps we usually want the same side.
          key += ':$side';
        }

        // Biological isolation check
        if (primarySubGroup != null) {
          final isBp = primarySubGroup.toLowerCase().contains("bicep");
          final isTp = primarySubGroup.toLowerCase().contains("tricep");
          if ((isBp && key.toLowerCase().contains("tricep")) ||
              (isTp && key.toLowerCase().contains("bicep"))) {
            continue;
          }
        }
        transferMap[key] = sourceFatigue * (entry.value / 100.0);
      }
    } else {
      for (final groupName in sourceExercise.secondaryMuscleGroups) {
        String key = groupName;
        if (side != null) key += ':$side';
        transferMap[key] = sourceFatigue * 0.4;
      }
    }

    return transferMap;
  }

  /// Performance drop is linear: 18% fatigue = 2/10 reps drop (~20%)
  static double calculatePerformanceDrop(double currentFatigue) {
    return currentFatigue.clamp(0.0, 100.0);
  }

  /// Achievable reps considering current fatigue
  static int predictRepsWithFatigue(
    int baselineReps,
    double performanceDropPercent,
  ) {
    if (baselineReps <= 0) return 0;
    final multiplier = 1.0 - (performanceDropPercent / 100.0);
    final predictedReps = (baselineReps * multiplier).round();
    return predictedReps.clamp(1, baselineReps);
  }
}
