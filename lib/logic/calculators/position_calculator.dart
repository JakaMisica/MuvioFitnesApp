import 'dart:math';
import 'package:muvio/data/models/workout_day.dart';

/// Calculates similarity between two equipment position configurations
class PositionCalculator {
  /// Represents a position configuration (cable + bench)
  static String positionKey(int? cablePos, int? benchPos) {
    return 'c${cablePos ?? 0}_b${benchPos ?? 0}';
  }

  /// Calculates similarity score between two positions (0.0 to 1.0)
  /// 1.0 = identical, 0.0 = completely different
  static double calculateSimilarity(
    WorkoutSet positionA,
    WorkoutSet positionB,
  ) {
    final cableA = positionA.cablePosition ?? 5;
    final benchA = positionA.benchPosition ?? 0;
    final cableB = positionB.cablePosition ?? 5;
    final benchB = positionB.benchPosition ?? 0;

    // Cable positions: typically 1-10 scale
    final cableDiff = (cableA - cableB).abs();
    final cableSimilarity = 1.0 - (cableDiff / 10.0).clamp(0.0, 1.0);

    // Bench positions: typically -2 to +2 scale (decline to incline)
    final benchDiff = (benchA - benchB).abs();
    final benchSimilarity = 1.0 - (benchDiff / 4.0).clamp(0.0, 1.0);

    // Weighted average (cable position often more impactful)
    final totalSimilarity = (cableSimilarity * 0.6) + (benchSimilarity * 0.4);

    return totalSimilarity.clamp(0.0, 1.0);
  }

  /// Estimates performance scaling factor based on position difference
  /// E.g., if closest position had 10 reps, how many reps for this position?
  static double estimatePerformanceScale(double similarityScore) {
    // Very similar positions (0.9-1.0): expect 90-100% of performance
    // Moderately similar (0.7-0.9): expect 70-90% of performance
    // Different positions (0.5-0.7): expect 50-70% of performance
    // Very different (<0.5): expect 40-50% of performance

    if (similarityScore >= 0.9) {
      return 0.9 + (similarityScore - 0.9) * 1.0; // 90-100%
    } else if (similarityScore >= 0.7) {
      return 0.7 + (similarityScore - 0.7) * 1.0; // 70-90%
    } else if (similarityScore >= 0.5) {
      return 0.5 + (similarityScore - 0.5) * 1.0; // 50-70%
    } else {
      return 0.4 + (similarityScore * 0.2); // 40-50%
    }
  }

  /// Predicts reps for a new position based on closest known position
  static int predictRepsForPosition({
    required int knownReps,
    required double knownWeight,
    required double targetWeight,
    required double positionSimilarity,
  }) {
    // First, account for weight difference
    final weightRatio = knownWeight / targetWeight;
    // Rough conversion: every 10% weight change = ~1 rep change
    final repsAdjustedForWeight = (knownReps * pow(weightRatio, 0.15)).round();

    // Then apply position similarity scaling
    final positionScale = estimatePerformanceScale(positionSimilarity);
    final finalPredictedReps = (repsAdjustedForWeight * positionScale).round();

    return finalPredictedReps.clamp(1, 50);
  }

  /// Creates a unique key for a position configuration
  static String createPositionKey(WorkoutSet set) {
    return positionKey(set.cablePosition, set.benchPosition);
  }
}
