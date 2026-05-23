import 'package:muvio/data/models/body_metric.dart';
import 'package:muvio/data/repositories/body_repository.dart';
import 'package:muvio/data/repositories/workout_repository.dart';
import 'package:muvio/data/repositories/analytics_repository.dart';
import 'package:muvio/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'evolution_state.dart';
import 'package:flutter/material.dart';

import 'dart:async';

enum RewardType { muscle, coin, sunglasses }

class RewardEvent {
  final RewardType type;
  final int amount;
  final DateTime timestamp;

  RewardEvent(this.type, this.amount) : timestamp = DateTime.now();
}

class EvolutionCubit extends Cubit<EvolutionState> {
  final BodyRepository _repository;
  final WorkoutRepository _workoutRepository = locator<WorkoutRepository>();
  final AnalyticsRepository _analyticsRepository =
      locator<AnalyticsRepository>();
  final _rewardController = StreamController<RewardEvent>.broadcast();

  Stream<RewardEvent> get rewardStream => _rewardController.stream;

  EvolutionCubit(this._repository) : super(const EvolutionState()) {
    loadData();
  }

  Future<void> loadData({bool forceLoading = false}) async {
    if (forceLoading || state.metrics.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    try {
      final metrics = await _repository.getBodyMetrics();
      final latest = await _repository.getLatestMetric();
      final settings = await _repository.getUserSettings();

      // Calculate all muscle gains for the HUD
      final muscleGains = await _repository.calculateMuscleGains(
        start: DateTime(2024), // Or start of app data
        end: DateTime.now(),
      );

      final totalVolume = await _workoutRepository
          .getTotalVolumeForCurrentWeek();

      // Calculate Fatigue Improvements for each muscle group
      final fatigueImproves = await _calculateAllFatigueImprovements();

      emit(
        state.copyWith(
          metrics: metrics,
          latestMetric: latest,
          settings: settings,
          muscleGains: muscleGains,
          fatigueImprovements: fatigueImproves,
          totalVolumeWeek: totalVolume,
          isLbs: settings.useLbsForVolume,
          isMetricMeasurements: settings.useMetricMeasurements,
          measurementChanges: _calculateMeasurementChanges(metrics),
          showBottomMetrics: settings.showExtraMetrics,
          isLoading: false,
        ),
      );
    } catch (e) {
      debugPrint("EvolutionCubit.loadData Error: $e");
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<Map<String, double>> _calculateAllFatigueImprovements() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 7));
    final end = now;

    // We compare [start, end] vs [start-7d, start-1d]
    final baselineEnd = start.subtract(const Duration(days: 1));
    final baselineStart = baselineEnd.subtract(const Duration(days: 7));

    final muscles = [
      'fatigue_chest',
      'fatigue_back',
      'fatigue_shoulders',
      'fatigue_abs',
      'fatigue_biceps',
      'fatigue_triceps',
      'fatigue_quads',
      'fatigue_hamstrings',
      'fatigue_glutes',
      'fatigue_calves',
    ];

    final Map<String, double> improvements = {};

    for (var key in muscles) {
      final baselineData = await _analyticsRepository.getDynamicMetricData(
        key,
        baselineStart,
        baselineEnd,
      );
      final experimentData = await _analyticsRepository.getDynamicMetricData(
        key,
        start,
        end,
      );

      if (baselineData.isNotEmpty && experimentData.isNotEmpty) {
        final avgBase =
            baselineData.map((e) => e.value).reduce((a, b) => a + b) /
            baselineData.length;
        final avgExp =
            experimentData.map((e) => e.value).reduce((a, b) => a + b) /
            experimentData.length;

        if (avgBase != 0) {
          // Invert because LOWER fatigue is BETTER (improvement)
          improvements[key] = ((avgBase - avgExp) / avgBase) * 100;
        } else {
          improvements[key] = 0;
        }
      } else {
        improvements[key] = 0;
      }
    }

    return improvements;
  }

  Map<String, double> _calculateMeasurementChanges(List<BodyMetric> metrics) {
    if (metrics.length < 2) return {};

    // Find the latest metric that has at least one measurement
    final latest = metrics.lastWhere((m) {
      return m.waist != null || m.chest != null || m.neck != null;
    }, orElse: () => metrics.last);

    // Find the previous metric that has at least one measurement before 'latest'
    BodyMetric? previous;
    try {
      previous = metrics.reversed.firstWhere((m) {
        return m.date.isBefore(latest.date) &&
            (m.waist != null || m.chest != null || m.neck != null);
      });
    } catch (_) {
      previous = null;
    }

    if (previous == null) return {};

    final changes = <String, double>{};
    final fields = [
      'neck',
      'chest',
      'waist',
      'hips',
      'leftArm',
      'rightArm',
      'leftForearm',
      'rightForearm',
      'leftThigh',
      'rightThigh',
      'leftCalf',
      'rightCalf',
    ];

    double? getVal(BodyMetric m, String field) {
      switch (field) {
        case 'neck':
          return m.neck;
        case 'chest':
          return m.chest;
        case 'waist':
          return m.waist;
        case 'hips':
          return m.hips;
        case 'leftArm':
          return m.leftArm;
        case 'rightArm':
          return m.rightArm;
        case 'leftForearm':
          return m.leftForearm;
        case 'rightForearm':
          return m.rightForearm;
        case 'leftThigh':
          return m.leftThigh;
        case 'rightThigh':
          return m.rightThigh;
        case 'leftCalf':
          return m.leftCalf;
        case 'rightCalf':
          return m.rightCalf;
        default:
          return null;
      }
    }

    for (var f in fields) {
      final v1 = getVal(latest, f);
      final v2 = getVal(previous, f);
      if (v1 != null && v2 != null) {
        changes[f] = v1 - v2;
      }
    }

    return changes;
  }

  Future<void> updateTimeframe(DateTime start, DateTime end) async {
    emit(state.copyWith(isLoading: true));
    try {
      final gains = await _repository.calculateMuscleGains(
        start: start,
        end: end,
      );
      emit(state.copyWith(muscleGains: gains, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadChartHistory({
    required DateTime start,
    required DateTime end,
    required String muscleGroup,
    String? subGroup,
  }) async {
    if (state.chartHistory.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    try {
      final history = await _repository.getMuscleGainsHistory(
        start: start,
        end: end,
        muscleGroup: muscleGroup,
        subGroup: subGroup,
      );

      final availableSubs = await _repository.getAllSubGroups(muscleGroup);

      emit(
        state.copyWith(
          chartHistory: history,
          availableSubGroups: availableSubs,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadVolumeHistory({
    required DateTime start,
    required DateTime end,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final history = await _workoutRepository.getVolumeAnalyticsData(
        start,
        end,
      );

      emit(state.copyWith(volumeChartHistory: history, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> saveWeight(double weight) async {
    final now = DateUtils.dateOnly(DateTime.now());
    var metric = await _repository.getMetricForDate(now);

    if (metric == null) {
      metric = BodyMetric()..date = now;
    }

    metric.weight = weight;

    // Auto-calculate Body Fat if we have previous data and some muscle gains
    if (metric.bodyFatPercentage == null) {
      _autoAdjustBodyFat(metric);
    }

    await _repository.saveMetric(metric);
    loadData();
  }

  Future<void> saveBodyFat({
    required double percentage,
    required int method,
    double? chest,
    double? abdominal,
    double? thigh,
    double? tricep,
    double? bicep,
    double? subscapular,
    double? suprailiac,
    double? midaxillary,
    double? lowerBack,
    double? calf,
  }) async {
    final now = DateUtils.dateOnly(DateTime.now());
    var metric = await _repository.getMetricForDate(now);

    if (metric == null) {
      metric = BodyMetric()..date = now;
    }

    metric.bodyFatPercentage = percentage;
    metric.bodyFatMethod = method;
    metric.chestSkinfold = chest;
    metric.abdominalSkinfold = abdominal;
    metric.thighSkinfold = thigh;
    metric.tricepSkinfold = tricep;
    metric.bicepSkinfold = bicep;
    metric.subscapularSkinfold = subscapular;
    metric.suprailiacSkinfold = suprailiac;
    metric.midaxillarySkinfold = midaxillary;
    metric.lowerBackSkinfold = lowerBack;
    metric.calfSkinfold = calf;

    // Trigger recalculation of Testosterone
    await _calculateEstimatedFreeTesto(metric);

    await _repository.saveMetric(metric);
    loadData();
  }

  Future<void> saveMeasurements(Map<String, double> values) async {
    final now = DateUtils.dateOnly(DateTime.now());
    var metric = await _repository.getMetricForDate(now);

    if (metric == null) {
      metric = BodyMetric()..date = now;
    }

    metric.neck = values['neck'];
    metric.chest = values['chest'];
    metric.waist = values['waist'];
    metric.hips = values['hips'];
    metric.leftArm = values['leftArm'];
    metric.rightArm = values['rightArm'];
    metric.leftForearm = values['leftForearm'];
    metric.rightForearm = values['rightForearm'];
    metric.leftThigh = values['leftThigh'];
    metric.rightThigh = values['rightThigh'];
    metric.leftCalf = values['leftCalf'];
    metric.rightCalf = values['rightCalf'];

    await _repository.saveMetric(metric);
    loadData();
  }

  Future<void> saveGripStrength({
    required double left,
    required double right,
    required bool useKg,
  }) async {
    final now = DateUtils.dateOnly(DateTime.now());
    var metric = await _repository.getMetricForDate(now);

    if (metric == null) {
      metric = BodyMetric()..date = now;
    }

    double finalLeft = left;
    double finalRight = right;
    if (!useKg) {
      finalLeft = left * 0.453592;
      finalRight = right * 0.453592;
    }

    metric.gripStrengthLeft = finalLeft;
    metric.gripStrengthRight = finalRight;

    // Save unit preference
    final settings = await _repository.getUserSettings();
    settings.useKgForGrip = useKg;
    await _repository.saveUserSettings(settings);

    await _repository.saveMetric(metric);
    await _recalculateTestoChain();
    await loadData();
  }

  Future<void> saveLabTesto(double value) async {
    final now = DateUtils.dateOnly(DateTime.now());
    var metric = await _repository.getMetricForDate(now);

    if (metric == null) {
      metric = BodyMetric()..date = now;
    }

    metric.labFreeTestosterone = value;
    metric.estimatedFreeTestosterone = value;

    await _repository.saveMetric(metric);
    await _recalculateTestoChain();
    await loadData();
  }

  /// Recalculates all estimated Free T for all metrics to ensure
  /// they are based on the latest available lab baseline.
  Future<void> _recalculateTestoChain() async {
    final metrics = await _repository.getBodyMetrics();
    // Sort by date to process chronologically
    metrics.sort((a, b) => a.date.compareTo(b.date));

    for (var m in metrics) {
      await _calculateEstimatedFreeTesto(m, externalHistory: metrics);
      await _repository.saveMetric(m);
    }
  }

  Future<void> saveProfile({
    required String gender,
    required int age,
    required double heightCm,
    required bool isMetricHeight,
  }) async {
    final settings = await _repository.getUserSettings();
    settings.gender = gender;
    settings.age = age;
    settings.heightCm = heightCm;
    settings.useMetricHeight = isMetricHeight;
    settings.isProfileComplete = true;

    await _repository.saveUserSettings(settings);

    // Recalculate Free T for latest metric if exists
    final latest = await _repository.getLatestMetric();
    if (latest != null) {
      await _calculateEstimatedFreeTesto(latest);
      await _repository.saveMetric(latest);
    }

    loadData();
  }

  Future<void> _calculateEstimatedFreeTesto(
    BodyMetric metric, {
    List<BodyMetric>? externalHistory,
  }) async {
    final settings = await _repository.getUserSettings();
    final now = metric.date;
    final age = settings.age;
    final bf = metric.bodyFatPercentage ?? 15.0;

    // Average grip strength (already normalized to kg in DB)
    double avgGrip =
        ((metric.gripStrengthLeft ?? 40.0) +
            (metric.gripStrengthRight ?? 40.0)) /
        2;

    // --- SEARCH FOR BASELINE ---
    BodyMetric? labMetric;
    if (metric.labFreeTestosterone != null) {
      labMetric = metric;
    } else if (externalHistory != null) {
      // Search in memory for latest lab test strictly before or on this date
      try {
        labMetric = externalHistory
            .where((m) => m.labFreeTestosterone != null && !m.date.isAfter(now))
            .last;
      } catch (_) {
        labMetric = null;
      }
    } else {
      labMetric = await _repository.getLatestLabMetric(now);
    }

    double freeT;
    if (labMetric != null && labMetric.labFreeTestosterone != null) {
      // 1. USE LAB TEST AS BASELINE
      double baselineT = labMetric.labFreeTestosterone!;

      // Reference values at the time of the lab test
      double refGrip =
          ((labMetric.gripStrengthLeft ?? 40.0) +
              (labMetric.gripStrengthRight ?? 40.0)) /
          2;
      double refBf = labMetric.bodyFatPercentage ?? 15.0;

      // Calculate relative change from baseline
      double gripDiff = avgGrip - refGrip;
      double bfDiff = bf - refBf;

      // Base value from lab
      freeT = baselineT;

      // Adjust based on change in grip strength (approx 0.12ng per kg)
      freeT += (gripDiff * 0.12);

      // Adjust based on change in body fat (approx -0.3ng per 1% change)
      freeT -= (bfDiff * 0.3);

      print(
        "EvolutionCubit: Calculation using Lab Baseline for ${metric.date}: ${freeT.toStringAsFixed(2)}ng",
      );
    } else {
      // 2. FALLBACK TO STANDARD FORMULA
      freeT = 15.0;
      if (age > 25) freeT -= (age - 25) * 0.12;
      if (bf > 15) {
        freeT -= (bf - 15) * 0.35;
      } else if (bf < 10) {
        freeT -= (10 - bf) * 0.2;
      }
      freeT += (avgGrip - 45).clamp(-10, 20) * 0.15;

      print(
        "EvolutionCubit: Calculation using Standard Formula for ${metric.date}: ${freeT.toStringAsFixed(2)}ng",
      );
    }

    // 3. COMMON FACTORS
    final muscleGainsKg = (metric.muscleMassGains ?? 0) / 1000.0;
    freeT += (muscleGainsKg.clamp(0.0, 15.0) * 0.4);

    if (settings.gender.toLowerCase() == "female") freeT *= 0.1;

    metric.estimatedFreeTestosterone = freeT.clamp(1.5, 45.0);
  }

  Future<void> loadTestoHistory({
    required DateTime start,
    required DateTime end,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final history = await _repository.getMetricHistory(
        start: start,
        end: end,
        metricField: 'estimatedFreeTestosterone',
      );
      emit(state.copyWith(testoChartHistory: history, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadGripHistory({
    required DateTime start,
    required DateTime end,
    required String mode,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final history = await _repository.getGripHistory(
        start: start,
        end: end,
        mode: mode,
      );
      emit(state.copyWith(gripChartHistory: history, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _autoAdjustBodyFat(BodyMetric current) {
    // Logic: If user gained 1kg of weight and we estimate they gained 500g of muscle,
    // then 500g is fat. Adjust body fat % accordingly.
    // BF_new = (Fat_old + Weight_gain - Muscle_gain) / Weight_new

    // Find most recent metric with Body Fat
    final prevWithFat = state.metrics.reversed.firstWhere(
      (m) => m.bodyFatPercentage != null && m.date.isBefore(current.date),
      orElse: () => BodyMetric(),
    );

    if (prevWithFat.bodyFatPercentage != null &&
        prevWithFat.weight != null &&
        current.weight != null) {
      final oldFatMass =
          prevWithFat.weight! * (prevWithFat.bodyFatPercentage! / 100.0);
      final weightGain = current.weight! - prevWithFat.weight!;

      // Get muscle gains between these two dates
      // Simplified: use a heuristic or query repository
      // For now, let's assume muscleMassGains on the metric stores it
      final muscleGain = current.muscleMassGains ?? 0;

      final newFatMass = (oldFatMass + weightGain - muscleGain).clamp(
        0.0,
        current.weight!,
      );
      current.bodyFatPercentage = (newFatMass / current.weight!) * 100.0;
      current.bodyFatMethod = 3; // Auto-calculated
    }
  }

  Future<void> toggleUnit() async {
    final newIsLbs = !state.isLbs;
    emit(state.copyWith(isLbs: newIsLbs));
    final settings = await _repository.getUserSettings();
    settings.useLbsForVolume = newIsLbs;
    await _repository.saveUserSettings(settings);
  }

  Future<void> toggleMeasurementsUnit() async {
    final newIsMetric = !state.isMetricMeasurements;
    emit(state.copyWith(isMetricMeasurements: newIsMetric));
    final settings = await _repository.getUserSettings();
    settings.useMetricMeasurements = newIsMetric;
    await _repository.saveUserSettings(settings);
  }

  Future<void> loadMeasurementHistory({
    required DateTime start,
    required DateTime end,
    required String field,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final history = await _repository.getMetricHistory(
        start: start,
        end: end,
        metricField: field,
      );
      emit(state.copyWith(measurementChartHistory: history, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> toggleBottomMetrics() async {
    final newShow = !state.showBottomMetrics;
    emit(state.copyWith(showBottomMetrics: newShow));
    final settings = await _repository.getUserSettings();
    settings.showExtraMetrics = newShow;
    await _repository.saveUserSettings(settings);
  }

  Future<void> toggleGuidedBreathing() async {
    final settings = await _repository.getUserSettings();
    settings.isGuidedBreathingEnabled = !settings.isGuidedBreathingEnabled;
    await _repository.saveUserSettings(settings);
    emit(state.copyWith(settings: settings));
  }

  Future<void> addMusclePoints(int amount) async {
    final settings = await _repository.getUserSettings();
    settings.musclePoints += amount;
    settings.lastMusclePointTime = DateTime.now();
    await _repository.saveUserSettings(settings);
    emit(state.copyWith(settings: settings));
    _rewardController.add(RewardEvent(RewardType.muscle, amount));
  }

  Future<void> addCoins(
    int amount, {
    String? taskName,
    bool isDiet = false,
  }) async {
    final settings = await _repository.getUserSettings();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Reset daily trackers if it's a new day
    if (settings.lastRewardResetDate == null ||
        !DateUtils.isSameDay(settings.lastRewardResetDate, today)) {
      settings.lastRewardResetDate = today;
      settings.todayDietCoinsCount = 0;
      settings.rewardedTaskNamesToday = [];
    }

    bool rewarded = false;
    if (isDiet) {
      if (settings.todayDietCoinsCount < 5) {
        settings.todayDietCoinsCount++;
        settings.coins += amount;
        rewarded = true;
      }
    } else if (taskName != null) {
      if (!settings.rewardedTaskNamesToday.contains(taskName)) {
        settings.rewardedTaskNamesToday.add(taskName);
        settings.coins += amount;
        rewarded = true;
      }
    }

    if (rewarded) {
      await _repository.saveUserSettings(settings);
      emit(state.copyWith(settings: settings));
      _rewardController.add(RewardEvent(RewardType.coin, amount));
    }
  }

  Future<void> addSocialPoints(int amount) async {
    final settings = await _repository.getUserSettings();
    settings.socialPoints += amount;
    await _repository.saveUserSettings(settings);

    _rewardController.add(RewardEvent(RewardType.sunglasses, amount));
    emit(state.copyWith(settings: settings));
  }

  @override
  Future<void> close() {
    _rewardController.close();
    return super.close();
  }
}
