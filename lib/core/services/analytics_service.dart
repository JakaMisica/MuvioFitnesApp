import 'dart:math';
import '../../data/models/workout_day.dart';

/// Service for calculating workout analytics including 1RM and strength indices
class AnalyticsService {
  /// Calculate One-Rep Max using adaptive formulas based on strength index
  ///
  /// - [weight]: Weight lifted (kg)
  /// - [reps]: Number of repetitions
  /// - [strengthIndex]: User's strength-to-rep preference (0.5-1.5, default 1.0)
  ///   - < 1.0: Stronger at low reps (uses Brzycki)
  ///   - = 1.0: Balanced (uses Epley)
  ///   - > 1.0: Stronger at high reps (uses Mayhew)
  static double calculate1RM(
    double weight,
    int reps, {
    double strengthIndex = 1.0,
  }) {
    if (reps == 1) return weight;
    int cappedReps = reps > 30 ? 30 : reps;

    // Choose formula based on strength index
    if (strengthIndex < 0.9) {
      // Brzycki formula - better for low-rep strength
      return weight / (1.0278 - 0.0278 * cappedReps);
    } else if (strengthIndex > 1.1) {
      // Mayhew formula - better for high-rep endurance
      return (100 * weight) / (52.2 + 41.9 * exp(-0.055 * cappedReps));
    } else {
      // Epley formula - standard balanced approach (improved precision)
      return weight * (1.0 + (cappedReps.toDouble() * 0.03333));
    }
  }

  /// Calculate reps needed to reach a target 1RM at a given weight
  static int calculateRepsForTarget(
    double weight,
    double target1RM, {
    double strengthIndex = 1.0,
  }) {
    if (weight <= 0 || target1RM <= 0) return 0;
    if (weight >= target1RM) return 1;

    // For simplicity and accuracy across all formulas, we'll brute force 1-30 reps
    for (int reps = 1; reps <= 30; reps++) {
      final current1RM = calculate1RM(
        weight,
        reps,
        strengthIndex: strengthIndex,
      );
      if (current1RM >= target1RM) return reps;
    }
    return 30;
  }

  static double calculateVolume(List<WorkoutSet> sets) {
    return sets.fold(0.0, (sum, set) {
      double volume = (set.weight ?? 0) * (set.reps ?? 0);
      if (set.isDropSet && set.dropSetItems.isNotEmpty) {
        for (var drop in set.dropSetItems) {
          volume += (drop.weight ?? 0) * (drop.reps ?? 0);
        }
      }
      return sum + volume;
    });
  }

  /// Calculate user's strength index by analyzing historical performance
  static double calculateStrengthIndex(List<WorkoutSet> historicalSets) {
    if (historicalSets.length < 5) return 1.0;

    final lowRepSets = <WorkoutSet>[];
    final midRepSets = <WorkoutSet>[];
    final highRepSets = <WorkoutSet>[];

    for (final set in historicalSets) {
      final reps = set.reps ?? 0;
      if (reps >= 1 && reps <= 5) {
        lowRepSets.add(set);
      } else if (reps >= 6 && reps <= 8) {
        midRepSets.add(set);
      } else if (reps >= 9) {
        highRepSets.add(set);
      }
    }

    if ([
          lowRepSets,
          midRepSets,
          highRepSets,
        ].where((l) => l.isNotEmpty).length <
        2) {
      return 1.0;
    }

    double avg1RMForRange(List<WorkoutSet> sets) {
      if (sets.isEmpty) return 0;
      final total = sets.fold(0.0, (sum, set) {
        final weight = set.weight ?? 0;
        final reps = set.reps ?? 0;
        return sum + calculate1RM(weight, reps, strengthIndex: 1.0);
      });
      return total / sets.length;
    }

    final lowRep1RM = avg1RMForRange(lowRepSets);
    final highRep1RM = avg1RMForRange(highRepSets);

    double index = 1.0;
    if (lowRep1RM > 0 && highRep1RM > 0) {
      final ratio = highRep1RM / lowRep1RM;
      if (ratio < 0.95)
        index = 0.85;
      else if (ratio > 1.05)
        index = 1.15;
    }

    return index.clamp(0.5, 1.5);
  }

  /// Get the best 1RM from a list of sets
  static double getBest1RM(
    List<WorkoutSet> sets, {
    double strengthIndex = 1.0,
  }) {
    if (sets.isEmpty) return 0;
    return sets
        .map((set) {
          final weight = set.weight ?? 0;
          final reps = set.reps ?? 0;
          return calculate1RM(weight, reps, strengthIndex: strengthIndex);
        })
        .reduce(max);
  }

  /// Aggregate daily stats from exercise logs
  static Map<DateTime, DailyStats> aggregateDailyStats(
    Map<DateTime, List<WorkoutSet>> dailySets,
    double strengthIndex,
  ) {
    final result = <DateTime, DailyStats>{};

    dailySets.forEach((date, sets) {
      final volume = calculateVolume(sets);
      final totalTUT = sets.fold(0, (sum, set) {
        int tut = set.tutSeconds ?? 0;
        if (set.isDropSet) {
          tut += set.dropSetItems.fold(0, (s, ds) => s + (ds.tutSeconds ?? 0));
        }
        return sum + tut;
      });
      final totalTUTWeight = sets.fold(0.0, (sum, set) {
        double tutIntensity = (set.tutSeconds ?? 0) * (set.weight ?? 0.0);
        if (set.isDropSet) {
          for (var ds in set.dropSetItems) {
            tutIntensity += (ds.tutSeconds ?? 0) * (ds.weight ?? 0.0);
          }
        }
        return sum + tutIntensity;
      });

      WorkoutSet? bestSet;
      double max1RM = -1.0;
      for (final s in sets) {
        final current1RM = calculate1RM(
          s.weight ?? 0.0,
          s.reps ?? 0,
          strengthIndex: strengthIndex,
        );
        if (current1RM > max1RM) {
          max1RM = current1RM;
          bestSet = s;
        }
      }

      result[date] = DailyStats(
        date: date,
        best1RM: max1RM,
        volume: volume,
        totalTUT: totalTUT.toDouble(),
        totalTUTWeight: totalTUTWeight,
        bestWeight: bestSet?.weight,
        bestReps: bestSet?.reps,
      );
    });

    return result;
  }
}

/// Daily aggregated stats for an exercise
class DailyStats {
  final DateTime date;
  final double best1RM;
  final double volume;
  final double totalTUT;
  final double totalTUTWeight;
  final double? bestWeight;
  final int? bestReps;

  DailyStats({
    required this.date,
    required this.best1RM,
    required this.volume,
    this.totalTUT = 0.0,
    this.totalTUTWeight = 0.0,
    this.bestWeight,
    this.bestReps,
  });
}

/// Time range options for analytics
enum TimeRange {
  oneWeek,
  twoWeeks,
  oneMonth,
  threeMonths,
  oneYear,
  allTime;

  String get label {
    switch (this) {
      case TimeRange.oneWeek:
        return '1W';
      case TimeRange.twoWeeks:
        return '2W';
      case TimeRange.oneMonth:
        return '1M';
      case TimeRange.threeMonths:
        return '3M';
      case TimeRange.oneYear:
        return '1Y';
      case TimeRange.allTime:
        return 'All';
    }
  }

  DateTime getStartDate() {
    final now = DateTime.now();
    switch (this) {
      case TimeRange.oneWeek:
        return now.subtract(Duration(days: 7));
      case TimeRange.twoWeeks:
        return now.subtract(Duration(days: 14));
      case TimeRange.oneMonth:
        return now.subtract(Duration(days: 30));
      case TimeRange.threeMonths:
        return now.subtract(Duration(days: 90));
      case TimeRange.oneYear:
        return now.subtract(Duration(days: 365));
      case TimeRange.allTime:
        return DateTime(2020); // Arbitrary past date
    }
  }
}

/// Metric type for analytics display
enum AnalyticsMetric {
  oneRM,
  volume,
  tut,
  tutWeight;

  String get label {
    switch (this) {
      case AnalyticsMetric.oneRM:
        return '1RM';
      case AnalyticsMetric.volume:
        return 'Volume';
      case AnalyticsMetric.tut:
        return 'TUT';
      case AnalyticsMetric.tutWeight:
        return 'TUT*W';
    }
  }

  String get unit {
    switch (this) {
      case AnalyticsMetric.oneRM:
        return 'kg';
      case AnalyticsMetric.volume:
        return 'kg';
      case AnalyticsMetric.tut:
        return 's';
      case AnalyticsMetric.tutWeight:
        return 'kg*s';
    }
  }
}
