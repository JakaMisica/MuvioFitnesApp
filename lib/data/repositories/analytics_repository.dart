import 'package:biofit_pro/data/models/analytics_experiment.dart';
import 'package:biofit_pro/data/models/fatigue_state.dart';
import 'package:flutter/material.dart';
import 'package:biofit_pro/data/repositories/body_repository.dart';
import 'package:biofit_pro/data/repositories/diet_repository.dart';
import 'package:biofit_pro/data/repositories/task_repository.dart';
import 'package:biofit_pro/data/repositories/workout_repository.dart';
import 'package:biofit_pro/data/repositories/fatigue_repository.dart';
import 'package:biofit_pro/data/datasources/isar_service.dart';
import 'package:isar/isar.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;

class AnalyticsRepository {
  final IsarService _isarService;
  final BodyRepository _bodyRepo;
  final DietRepository _dietRepo;
  final TaskRepository _taskRepo;
  final WorkoutRepository _workoutRepo;
  final FatigueRepository _fatigueRepo;

  AnalyticsRepository(
    this._isarService,
    this._bodyRepo,
    this._dietRepo,
    this._taskRepo,
    this._workoutRepo,
    this._fatigueRepo,
  );

  // --- Experiment Management ---

  Future<List<AnalyticsExperiment>> getAllExperiments() async {
    final isar = await _isarService.db;
    return await isar.analyticsExperiments
        .where()
        .sortByStartDateDesc()
        .findAll();
  }

  Future<void> saveExperiment(AnalyticsExperiment experiment) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.analyticsExperiments.put(experiment));
  }

  Future<void> deleteExperiment(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.analyticsExperiments.delete(id));
  }

  Future<Map<String, String>> discoverAvailableTasks() async {
    final tasks = await _taskRepo.getAllTasks();
    return {for (var t in tasks) 'task_${t.id}': t.name};
  }

  Future<Map<String, String>> discoverAvailableSupplements() async {
    final diets = await _dietRepo.getDietsBetween(
      DateTime.now().subtract(const Duration(days: 30)),
      DateTime.now(),
    );
    final names = diets
        .expand((d) => d.supplements.map((s) => s.name))
        .whereType<String>()
        .toSet();
    return {for (var name in names) 'supp_$name': name};
  }

  Future<Map<String, String>> discoverAvailableFatigueMetrics() async {
    return {
      'fatigue_all': 'All muscles',
      'fatigue_chest': 'Chest Fatigue',
      'fatigue_back': 'Back Fatigue',
      'fatigue_shoulders': 'Shoulders Fatigue',
      'fatigue_abs': 'Abs Fatigue',
      'fatigue_biceps': 'Biceps Fatigue',
      'fatigue_triceps': 'Triceps Fatigue',
      'fatigue_quads': 'Quads Fatigue',
      'fatigue_hamstrings': 'Hamstrings Fatigue',
      'fatigue_glutes': 'Glutes Fatigue',
      'fatigue_calves': 'Calves Fatigue',
    };
  }

  // --- Data Pooling ---

  Future<List<MapEntry<DateTime, double>>> getMetricData(
    AnalyticsMetricType type,
    DateTime start,
    DateTime end,
  ) async {
    switch (type) {
      case AnalyticsMetricType.gripStrength:
        return await _bodyRepo.getGripHistory(
          start: start,
          end: end,
          mode: 'Average',
        );
      case AnalyticsMetricType.muscleGains:
        return await _bodyRepo.getMuscleGainsHistory(
          start: start,
          end: end,
          muscleGroup: 'All',
        );
      case AnalyticsMetricType.fatigueIndex:
        // Average fatigue across all measured muscle groups
        return await _fatigueRepo.getMuscleFatigueHistory(
          start: start,
          end: end,
          muscleGroup: 'Chest', // Generic fallback
        );
      case AnalyticsMetricType.bodyWeight:
        return await _bodyRepo.getMetricHistory(
          start: start,
          end: end,
          metricField: 'weight',
        );
      case AnalyticsMetricType.bodyFat:
        return await _bodyRepo.getMetricHistory(
          start: start,
          end: end,
          metricField: 'bodyFatPercentage',
        );
      case AnalyticsMetricType.proteinIntake:
        final diets = await _dietRepo.getDietsBetween(start, end);
        return diets.map((d) => MapEntry(d.date, d.totalProtein)).toList();
      case AnalyticsMetricType.fatIntake:
        final diets = await _dietRepo.getDietsBetween(start, end);
        return diets.map((d) => MapEntry(d.date, d.totalFat)).toList();
      case AnalyticsMetricType.carbsIntake:
        final diets = await _dietRepo.getDietsBetween(start, end);
        return diets.map((d) => MapEntry(d.date, d.totalCarbs)).toList();
      case AnalyticsMetricType.calorieIntake:
        final diets = await _dietRepo.getDietsBetween(start, end);
        return diets
            .map((d) => MapEntry(d.date, d.totalCalories.toDouble()))
            .toList();
      case AnalyticsMetricType.workoutPerformance:
        return await _workoutRepo.getWorkoutPerformanceHistory(start, end);
      case AnalyticsMetricType.sleepQuality:
        return await _getTaskNumericValue('sleep', start, end);
      case AnalyticsMetricType.stressLevel:
        return await _getTaskNumericValue('stress', start, end);
      case AnalyticsMetricType.measurementNeck:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'neck');
      case AnalyticsMetricType.measurementChest:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'chest');
      case AnalyticsMetricType.measurementWaist:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'waist');
      case AnalyticsMetricType.measurementHips:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'hips');
      case AnalyticsMetricType.measurementLeftArm:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'leftArm');
      case AnalyticsMetricType.measurementRightArm:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'rightArm');
      case AnalyticsMetricType.measurementLeftForearm:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'leftForearm');
      case AnalyticsMetricType.measurementRightForearm:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'rightForearm');
      case AnalyticsMetricType.measurementLeftThigh:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'leftThigh');
      case AnalyticsMetricType.measurementRightThigh:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'rightThigh');
      case AnalyticsMetricType.measurementLeftCalf:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'leftCalf');
      case AnalyticsMetricType.measurementRightCalf:
        return await _bodyRepo.getMetricHistory(start: start, end: end, metricField: 'rightCalf');
      case AnalyticsMetricType.steps:
        return await _workoutRepo.getStepsHistory(start, end);
      case AnalyticsMetricType.distance:
        return await _workoutRepo.getDistanceHistory(start, end);
    }
  }

  Future<List<MapEntry<DateTime, double>>> getDynamicMetricData(
    String key,
    DateTime start,
    DateTime end,
  ) async {
    if (key.startsWith('task_')) {
      final taskId = int.tryParse(key.split('_')[1]);
      if (taskId != null) {
        final history = await _taskRepo.getTaskHistory(
          taskId,
          startDate: start,
          endDate: end,
        );
        return history
            .map((h) => MapEntry(h.recordedDate, h.numericValue))
            .toList();
      }
    } else if (key.startsWith('supp_')) {
      final suppName = key.split('_')[1].toLowerCase();
      final diets = await _dietRepo.getDietsBetween(start, end);
      return diets.map((d) {
        final amount = d.supplements
            .where((s) => s.name?.toLowerCase() == suppName)
            .fold(0.0, (sum, s) => sum + s.amount);
        return MapEntry(d.date, amount);
      }).toList();
    } else if (key.startsWith('fatigue_')) {
      final part = key.split('_')[1].toLowerCase();
      String muscleGroup = '';
      String? subGroup;

      switch (part) {
        case 'chest':
          muscleGroup = 'Chest';
          break;
        case 'back':
          muscleGroup = 'Back';
          break;
        case 'shoulders':
          muscleGroup = 'Shoulders';
          break;
        case 'abs':
          muscleGroup = 'Core';
          break;
        case 'biceps':
          muscleGroup = 'Arms';
          subGroup = 'Biceps';
          break;
        case 'triceps':
          muscleGroup = 'Arms';
          subGroup = 'Triceps';
          break;
        case 'quads':
          muscleGroup = 'Legs';
          subGroup = 'Quads';
          break;
        case 'hamstrings':
          muscleGroup = 'Legs';
          subGroup = 'Hamstrings';
          break;
        case 'glutes':
          muscleGroup = 'Legs';
          subGroup = 'Glutes';
          break;
        case 'calves':
          muscleGroup = 'Legs';
          subGroup = 'Calves';
          break;
        case 'all':
          return await _getOverallFatigueHistory(start, end);
      }
      if (muscleGroup.isNotEmpty) {
        return await _fatigueRepo.getMuscleFatigueHistory(
          start: start,
          end: end,
          muscleGroup: muscleGroup,
          subGroup: subGroup,
        );
      }
    }
    return [];
  }

  Future<List<MapEntry<DateTime, double>>> _getOverallFatigueHistory(
    DateTime start,
    DateTime end,
  ) async {
    final isar = await _isarService.db;
    final normalizedStart = DateUtils.dateOnly(start);
    final normalizedEnd = DateUtils.dateOnly(end);

    final states = await isar.fatigueStates
        .filter()
        .workoutDateBetween(normalizedStart, normalizedEnd)
        .findAll();

    final Map<DateTime, double> aggregated = {};
    for (var s in states) {
      final date = s.workoutDate;
      // We take the MAX fatigue observed across any muscle group as the "overall fatigue" for that day
      aggregated[date] = math.max(
        aggregated[date] ?? 0.0,
        s.currentFatiguePercent,
      );
    }

    return aggregated.entries
        .map((e) => MapEntry(e.key, e.value))
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));
  }

  Future<List<MapEntry<DateTime, double>>> _getTaskNumericValue(
    String keyword,
    DateTime start,
    DateTime end,
  ) async {
    final tasks = await _taskRepo.getAllTasks();
    final task = tasks.firstWhereOrNull(
      (t) => t.name.toLowerCase().contains(keyword),
    );
    if (task != null) {
      final history = await _taskRepo.getTaskHistory(
        task.id,
        startDate: start,
        endDate: end,
      );
      return history
          .map((h) => MapEntry(h.recordedDate, h.numericValue))
          .toList();
    }
    return [];
  }

  Future<List<MapEntry<DateTime, double>>> getMetricPoints(
    String key,
    DateTime start,
    DateTime end,
  ) async {
    final enumType = AnalyticsMetricType.values.firstWhereOrNull(
      (e) => e.name == key,
    );
    if (enumType != null) {
      return await getMetricData(enumType, start, end);
    } else {
      return await getDynamicMetricData(key, start, end);
    }
  }

  /// Calculates Pearson Correlation Coefficient -1.0 to 1.0
  double calculateCorrelation(List<double> x, List<double> y) {
    if (x.length != y.length || x.isEmpty) return 0;

    int n = x.length;
    double sumX = x.reduce((a, b) => a + b);
    double sumY = y.reduce((a, b) => a + b);
    double sumXY = 0;
    double sumX2 = 0;
    double sumY2 = 0;

    for (int i = 0; i < n; i++) {
      sumXY += x[i] * y[i];
      sumX2 += x[i] * x[i];
      sumY2 += y[i] * y[i];
    }

    double numerator = (n * sumXY) - (sumX * sumY);
    double denominator = math.sqrt(
      (n * sumX2 - sumX * sumX) * (n * sumY2 - sumY * sumY),
    );

    if (denominator == 0) return 0;
    return numerator / denominator;
  }

  /// Finds correlation between two metrics over a window, potentially with a lag (days)
  Future<double> getCrossMetricCorrelation(
    String keyA,
    String keyB, {
    int days = 30,
    int lagDays = 0,
  }) async {
    final end = DateTime.now();
    final start = end.subtract(Duration(days: days + lagDays + 5));

    final dataA = await getMetricPoints(keyA, start, end);
    final dataB = await getMetricPoints(keyB, start, end);

    if (dataA.isEmpty || dataB.isEmpty) return 0;

    // Align maps by date
    final mapA = Map.fromEntries(dataA);
    final mapB = Map.fromEntries(dataB);

    final List<double> alignedX = [];
    final List<double> alignedY = [];

    for (var date in mapA.keys) {
      final shiftedDate = date.add(Duration(days: lagDays));
      final normalizedShifted = DateTime(
        shiftedDate.year,
        shiftedDate.month,
        shiftedDate.day,
      );

      if (mapB.containsKey(normalizedShifted)) {
        alignedX.add(mapA[date]!);
        alignedY.add(mapB[normalizedShifted]!);
      }
    }

    return calculateCorrelation(alignedX, alignedY);
  }

  // --- Experiment Analysis ---

  Future<Map<String, double>> analyzeExperiment(AnalyticsExperiment exp) async {
    final startDate = exp.startDate;
    final endDate = exp.endDate ?? DateTime.now();

    // Compare performance in experiment period vs previous period of same duration
    final duration = endDate.difference(startDate);
    final baselineEnd = startDate.subtract(const Duration(days: 1));
    final baselineStart = baselineEnd.subtract(duration);

    final Map<String, double> improvements = {};

    for (var key in exp.trackedMetricKeys) {
      List<MapEntry<DateTime, double>> baselineData = [];
      List<MapEntry<DateTime, double>> experimentData = [];

      final enumType = AnalyticsMetricType.values.firstWhereOrNull(
        (e) => e.name == key,
      );
      if (enumType != null) {
        baselineData = await getMetricData(
          enumType,
          baselineStart,
          baselineEnd,
        );
        experimentData = await getMetricData(enumType, startDate, endDate);
      } else {
        baselineData = await getDynamicMetricData(
          key,
          baselineStart,
          baselineEnd,
        );
        experimentData = await getDynamicMetricData(key, startDate, endDate);
      }

      if (baselineData.isNotEmpty && experimentData.isNotEmpty) {
        final avgBase =
            baselineData.map((e) => e.value).reduce((a, b) => a + b) /
            baselineData.length;
        final avgExp =
            experimentData.map((e) => e.value).reduce((a, b) => a + b) /
            experimentData.length;

        if (avgBase != 0) {
          improvements[key] = ((avgExp - avgBase) / avgBase) * 100;
        } else {
          improvements[key] = 0;
        }
      }
    }

    return improvements;
  }
}
