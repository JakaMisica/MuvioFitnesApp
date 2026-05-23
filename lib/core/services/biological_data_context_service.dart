import 'package:muvio/data/models/enums.dart';
import 'package:muvio/data/models/workout_day.dart';
import 'package:muvio/data/models/diet_models.dart';
import 'package:muvio/data/repositories/body_repository.dart';
import 'package:muvio/data/repositories/workout_repository.dart';
import 'package:muvio/data/repositories/task_repository.dart';
import 'package:muvio/data/repositories/sleep_repository.dart';
import 'package:muvio/data/repositories/diet_repository.dart';
import 'package:muvio/locator.dart';
import 'package:muvio/core/services/analytics_service.dart';
import 'dart:math';

class BiologicalDataContextService {
  final BodyRepository _bodyRepo = locator<BodyRepository>();
  final WorkoutRepository _workoutRepo = locator<WorkoutRepository>();
  final TaskRepository _taskRepo = locator<TaskRepository>();
  final SleepRepository _sleepRepo = locator<SleepRepository>();
  final DietRepository _dietRepo = locator<DietRepository>();

  Future<String> getAIPromptContext() async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final tenDaysAgo = now.subtract(const Duration(days: 10));
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final latestMetric = await _bodyRepo.getLatestMetric();

    var oldMetric = await _bodyRepo.getMetricForDate(thirtyDaysAgo);
    if (oldMetric == null) {
      final allMetrics = await _bodyRepo.getBodyMetrics();
      if (allMetrics.isNotEmpty) oldMetric = allMetrics.first;
    }

    StringBuffer context = StringBuffer();
    context.writeln("BIO-DATA SNAPSHOT (Last 30 Days Progression):");

    if (latestMetric != null &&
        oldMetric != null &&
        latestMetric != oldMetric) {
      context.writeln(
        _calcChange("Weight", oldMetric.weight, latestMetric.weight, "kg"),
      );
      context.writeln(
        _calcChange(
          "Body Fat",
          oldMetric.bodyFatPercentage,
          latestMetric.bodyFatPercentage,
          "%",
        ),
      );

      final gainsMapped = await _bodyRepo.calculateMuscleGains(
        start: thirtyDaysAgo,
        end: now,
      );
      double builtLast30d = 0;
      gainsMapped.forEach(
        (mg, subs) => subs.forEach((s, g) => builtLast30d += g),
      );

      final sixtyDaysAgo = now.subtract(const Duration(days: 60));
      final oldGainsMapped = await _bodyRepo.calculateMuscleGains(
        start: sixtyDaysAgo,
        end: thirtyDaysAgo,
      );
      double builtPrev30d = 0;
      oldGainsMapped.forEach(
        (mg, subs) => subs.forEach((s, g) => builtPrev30d += g),
      );

      context.writeln(_calcChange("Gains", builtPrev30d, builtLast30d, "g"));
      context.writeln(
        _calcChange(
          "Free Testosterone",
          oldMetric.estimatedFreeTestosterone,
          latestMetric.estimatedFreeTestosterone,
          "ng/dL",
        ),
      );

      final oldGrip =
          (oldMetric.gripStrengthLeft ?? 0) +
          (oldMetric.gripStrengthRight ?? 0);
      final newGrip =
          (latestMetric.gripStrengthLeft ?? 0) +
          (latestMetric.gripStrengthRight ?? 0);
      context.writeln(
        _calcChange(
          "Grip Strength",
          oldGrip > 0 ? oldGrip / 2 : null,
          newGrip > 0 ? newGrip / 2 : null,
          "kg",
        ),
      );
    } else if (latestMetric != null) {
      context.writeln(
        "Current Stats: Weight: ${latestMetric.weight}kg, Body Fat: ${latestMetric.bodyFatPercentage}% (No historical progression yet)",
      );
    }

    // --- DIET ADHERENCE SECTION ---
    context.writeln("\nNUTRITION ADHERENCE (7-Day Analysis):");
    final diets = await _dietRepo.getDietsBetween(sevenDaysAgo, now);
    final templates = await _dietRepo.getAllTemplates();

    double totalConsistency = 0;
    int trackedDays = 0;

    for (var day in diets) {
      final weekday = day.date.weekday;
      final template = templates
          .where((t) => t.scheduledDays.contains(weekday))
          .firstOrNull;

      if (template != null) {
        double plannedCals = template.meals.fold(
          0.0,
          (s, m) => s + m.items.fold(0.0, (si, i) => si + i.calories),
        );
        if (plannedCals > 0) {
          double consumedCals = day.totalCalories;
          double diff = (consumedCals - plannedCals).abs();
          double dayAdherence = max(0.0, 100.0 - (diff / plannedCals * 100.0));
          totalConsistency += dayAdherence;
          trackedDays++;
        }
      }
    }

    if (trackedDays > 0) {
      double avgDietConsistency = totalConsistency / trackedDays;
      context.writeln(
        "Diet Consistency: ${avgDietConsistency.toStringAsFixed(1)}%",
      );
    } else {
      context.writeln(
        "Diet Consistency: Not enough data (No active templates scheduled)",
      );
    }

    // --- SUPPLEMENT CHANGES SECTION ---
    final todayDiet = await _dietRepo.getDietForDate(now);
    final lastWeekDiet = await _dietRepo.getDietForDate(sevenDaysAgo);

    if (todayDiet != null && lastWeekDiet != null) {
      final changes = _getSupplementDiff(
        lastWeekDiet.supplements,
        todayDiet.supplements,
      );
      if (changes.isNotEmpty) {
        context.writeln("Supplement Changes: $changes");
      }
    }

    // --- REST OF DATA ---
    final sessions = await _sleepRepo.getAllSessions();
    final recentSessions = sessions
        .where((s) => s.startTime.isAfter(thirtyDaysAgo))
        .toList();
    if (recentSessions.isNotEmpty) {
      double avgQuality =
          recentSessions.fold(0.0, (sum, s) => sum + s.qualityScore) /
          recentSessions.length;
      context.writeln(
        "Avg Sleep Quality (30d): ${(avgQuality * 100).toStringAsFixed(1)}%",
      );
    }

    final allTasks = await _taskRepo.getAllTasks();
    context.writeln("\nSUBJECTIVE RATINGS (7-Day Avg):");
    for (var taskName in ["Sleep", "Stress", "Mood"]) {
      final task = allTasks
          .where((t) => t.name.toLowerCase().contains(taskName.toLowerCase()))
          .firstOrNull;
      if (task != null) {
        final history = await _taskRepo.getTaskHistory(
          task.id,
          startDate: sevenDaysAgo,
        );
        if (history.isNotEmpty) {
          double avg =
              history.fold(0.0, (sum, h) => sum + h.numericValue) /
              history.length;
          context.writeln(
            "${taskName.toUpperCase()}: ${avg.toStringAsFixed(1)}/10",
          );
        }
      }
    }

    context.writeln("\nPERFORMANCE EVOLUTION:");
    final recentWorkouts = await _getWorkoutsBetween(tenDaysAgo, now);
    final Set<int> seenExercises = {};

    for (var day in recentWorkouts) {
      for (var log in day.exercises) {
        final exercise = log.exercise.value;
        if (exercise == null || seenExercises.contains(exercise.id)) continue;
        seenExercises.add(exercise.id);

        final history = await _workoutRepo.getExerciseHistory(
          exercise.id,
          thirtyDaysAgo,
        );
        if (history.isEmpty) continue;

        double currentMax1RM = 0;
        double currentMaxTUTWeight = 0;
        for (var set in log.sets) {
          if (!set.isCompleted) continue;
          double e1rm = AnalyticsService.calculate1RM(
            set.weight ?? 0,
            set.reps ?? 0,
          );
          if (e1rm > currentMax1RM) currentMax1RM = e1rm;
          double tutW = (set.tutSeconds ?? 0) * (set.weight ?? 0);
          if (tutW > currentMaxTUTWeight) currentMaxTUTWeight = tutW;
        }

        double oldMax1RM = 0;
        double oldMaxTUTWeight = 0;
        final dates = history.keys.toList()..sort();
        final oldestDate = dates.first;
        final oldSets = history[oldestDate] ?? [];
        for (var set in oldSets) {
          double e1rm = AnalyticsService.calculate1RM(
            set.weight ?? 0,
            set.reps ?? 0,
          );
          if (e1rm > oldMax1RM) oldMax1RM = e1rm;
          double tutW = (set.tutSeconds ?? 0) * (set.weight ?? 0);
          if (tutW > oldMaxTUTWeight) oldMaxTUTWeight = tutW;
        }

        context.writeln("EX: ${exercise.name}");
        context.writeln(
          "  - 1RM: ${((currentMax1RM - oldMax1RM) / (oldMax1RM > 0 ? oldMax1RM : 1) * 100).toStringAsFixed(1)}%",
        );
        context.writeln(
          "  - Intensity: ${((currentMaxTUTWeight - oldMaxTUTWeight) / (oldMaxTUTWeight > 0 ? oldMaxTUTWeight : 1) * 100).toStringAsFixed(1)}%",
        );
      }
    }

    context.writeln("\nSTRICT BIOLOGICAL VOLUME (Weekly Sets per Muscle):");
    final weeklySets = await _calculateWeeklySetsPerMuscle();
    weeklySets.forEach((mg, sets) {
      context.writeln(
        "  - ${mg.name.toUpperCase()}: ${sets.toStringAsFixed(1)} sets/week",
      );
    });

    return context.toString();
  }

  String _getSupplementDiff(
    List<ConsumedFood> oldList,
    List<ConsumedFood> newList,
  ) {
    final Map<String, double> oldMap = {};
    for (var s in oldList)
      oldMap[s.name ?? ""] = (oldMap[s.name ?? ""] ?? 0) + s.amount;

    final Map<String, double> newMap = {};
    for (var s in newList)
      newMap[s.name ?? ""] = (newMap[s.name ?? ""] ?? 0) + s.amount;

    final List<String> changes = [];
    final allNames = {...oldMap.keys, ...newMap.keys};

    for (var name in allNames) {
      final oldVal = oldMap[name] ?? 0;
      final newVal = newMap[name] ?? 0;
      if (oldVal != newVal) {
        final diff = newVal - oldVal;
        final sign = diff > 0 ? "+" : "";
        final unit = newList
            .firstWhere(
              (s) => s.name == name,
              orElse: () => oldList.firstWhere((s) => s.name == name),
            )
            .unit;
        changes.add("$sign${diff.toStringAsFixed(1)}$unit $name");
      }
    }
    return changes.join(", ");
  }

  String _calcChange(
    String label,
    double? oldVal,
    double? newVal,
    String unit,
  ) {
    if (oldVal == null || newVal == null || oldVal == 0)
      return "$label: no historical data";
    double pct = ((newVal - oldVal) / oldVal) * 100;
    String sign = pct >= 0 ? "+" : "";
    return "$label: ${newVal.toStringAsFixed(1)}$unit ($sign${pct.toStringAsFixed(1)}%)";
  }

  Future<List<WorkoutDay>> _getWorkoutsBetween(
    DateTime start,
    DateTime end,
  ) async {
    final workouts = <WorkoutDay>[];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      final d = DateTime(
        start.year,
        start.month,
        start.day,
      ).add(Duration(days: i));
      final w = await _workoutRepo.getWorkoutForDate(d);
      if (w != null && w.exercises.isNotEmpty) workouts.add(w);
    }
    return workouts;
  }

  Future<Map<MuscleGroup, double>> _calculateWeeklySetsPerMuscle() async {
    final results = <MuscleGroup, double>{};
    final now = DateTime.now();
    final recentSessions = <WorkoutDay>[];
    for (int i = 0; i < 30; i++) {
      final d = now.subtract(Duration(days: i));
      final w = await _workoutRepo.getWorkoutForDate(d);
      if (w != null && w.exercises.isNotEmpty) recentSessions.add(w);
    }
    if (recentSessions.isEmpty) return {};

    final Map<int, Map<MuscleGroup, int>> templateMuscleSets = {};
    final Set<int> uniqueTemplateIds = {};

    for (var day in recentSessions) {
      if (day.templateId == null) continue;
      if (uniqueTemplateIds.contains(day.templateId)) continue;
      uniqueTemplateIds.add(day.templateId!);
      templateMuscleSets[day.templateId!] = {};
      for (var log in day.exercises) {
        final exercise = log.exercise.value;
        if (exercise == null) continue;
        int sets = log.sets.where((s) => s.isCompleted).length;
        templateMuscleSets[day.templateId!]![exercise.muscleGroup] =
            (templateMuscleSets[day.templateId!]![exercise.muscleGroup] ?? 0) +
            sets;
      }
    }
    if (uniqueTemplateIds.isEmpty) return {};
    double sessionsPerWeek = recentSessions.length / 4.28;
    Map<MuscleGroup, double> avgSetsPerWorkout = {};
    for (var mg in MuscleGroup.values) {
      double total = 0;
      for (var tid in uniqueTemplateIds)
        total += (templateMuscleSets[tid]![mg] ?? 0);
      avgSetsPerWorkout[mg] = total / uniqueTemplateIds.length;
    }
    for (var mg in MuscleGroup.values) {
      double weekly = (avgSetsPerWorkout[mg] ?? 0) * sessionsPerWeek;
      if (weekly > 0) results[mg] = weekly;
    }
    return results;
  }
}
