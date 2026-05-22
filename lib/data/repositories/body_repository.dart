import 'package:biofit_pro/data/datasources/isar_service.dart';
import 'package:biofit_pro/data/models/body_metric.dart';
import 'package:biofit_pro/data/models/workout_day.dart';
import 'package:biofit_pro/data/models/exercise.dart';
import 'package:biofit_pro/data/models/enums.dart';
import 'package:biofit_pro/data/models/user_settings.dart';
import 'package:biofit_pro/core/services/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class BodyRepository {
  final IsarService _isarService;

  BodyRepository(this._isarService);

  Future<List<BodyMetric>> getBodyMetrics() async {
    final isar = await _isarService.db;
    return await isar.bodyMetrics.where().sortByDate().findAll();
  }

  Future<BodyMetric?> getLatestMetric() async {
    final isar = await _isarService.db;
    return await isar.bodyMetrics.where().sortByDateDesc().findFirst();
  }

  Future<BodyMetric?> getLatestLabMetric(DateTime beforeDate) async {
    final isar = await _isarService.db;
    return await isar.bodyMetrics
        .filter()
        .labFreeTestosteroneIsNotNull()
        .dateLessThan(beforeDate, include: true)
        .sortByDateDesc()
        .findFirst();
  }

  Future<BodyMetric?> getMetricForDate(DateTime date) async {
    final isar = await _isarService.db;
    final normalizedDate = DateUtils.dateOnly(date);
    return await isar.bodyMetrics
        .where()
        .dateEqualTo(normalizedDate)
        .findFirst();
  }

  Future<void> saveMetric(BodyMetric metric) async {
    final isar = await _isarService.db;
    metric.date = DateUtils.dateOnly(metric.date);
    await isar.writeTxn(() => isar.bodyMetrics.put(metric));
  }

  Future<UserSettings> getUserSettings() async {
    final isar = await _isarService.db;
    var settings = await isar.userSettings.get(0);
    if (settings == null) {
      settings = UserSettings();
      await isar.writeTxn(() => isar.userSettings.put(settings!));
    } else {
      // Sanitize newly added fields that might have Isar.minId (-) value
      bool needFix = false;
      if (settings.musclePoints < 0) {
        settings.musclePoints = 0;
        needFix = true;
      }
      if (settings.coins < 0) {
        settings.coins = 0;
        needFix = true;
      }
      if (needFix) {
        await isar.writeTxn(() => isar.userSettings.put(settings!));
      }
    }
    return settings;
  }

  Future<void> saveUserSettings(UserSettings settings) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() => isar.userSettings.put(settings));
  }

  Stream<UserSettings?> watchUserSettings() async* {
    final isar = await _isarService.db;
    yield* isar.userSettings.watchObject(0, fireImmediately: true);
  }

  Future<void> persistRestTimer({
    required DateTime endTime,
    required int logId,
    required int setIdx,
    required int totalDuration,
  }) async {
    final settings = await getUserSettings();
    settings.restTimerEndTime = endTime;
    settings.restTimerExerciseLogId = logId;
    settings.restTimerNextSetIndex = setIdx;
    settings.restTimerTotalDuration = totalDuration;
    await saveUserSettings(settings);
  }

  Future<void> clearPersistedRestTimer() async {
    final settings = await getUserSettings();
    settings.restTimerEndTime = null;
    settings.restTimerExerciseLogId = null;
    settings.restTimerNextSetIndex = null;
    settings.restTimerTotalDuration = null;
    await saveUserSettings(settings);
  }

  Future<void> persistExpandedExerciseIds(List<int> ids) async {
    final settings = await getUserSettings();
    settings.expandedExerciseIds = ids;
    await saveUserSettings(settings);
  }

  Future<List<int>> getExpandedExerciseIds() async {
    final isar = await _isarService.db;
    final settings = await isar.userSettings.get(0);
    return settings?.expandedExerciseIds ?? [];
  }

  /// Calculates estimated muscle gains in grams for a given timeframe,
  /// broken down by muscle group and sub-muscle group.
  Future<Map<String, Map<String, double>>> calculateMuscleGains({
    required DateTime start,
    required DateTime end,
  }) async {
    final isar = await _isarService.db;

    // 1. Get all workout logs in the period
    final workoutDays = await isar.workoutDays
        .where()
        .dateBetween(start, end)
        .findAll();

    // Mapping: MuscleGroup -> { SubGroup -> Grams }
    // use "General" for subGroup == null
    final results = <String, Map<String, double>>{};

    for (var day in workoutDays) {
      for (var log in day.exercises) {
        final exercise = log.exercise.value;
        if (exercise == null) continue;

        final primaryGroupName = exercise.muscleGroup.name;
        final subGroupEngagements = exercise.subGroupEngagement;
        final secondaryEngagements = exercise.secondaryMuscleEngagement;

        // Calculate work done in this exercise
        double totalEffectiveWork = 0;
        for (var set in log.sets) {
          if (!set.isCompleted) continue;

          final volume = (set.weight ?? 0) * (set.reps ?? 0);

          // Intensity factor: Sets closer to failure yield more hypertrophy
          // RIR 0 (Failure) = 1.2x, RIR 1 = 1.1x, RIR 2 = 1.0x, RIR > 2 = 0.5x
          double intensityFactor = 0.5;
          final rir = set.rir ?? 3;
          if (rir == 0 || set.isFailure)
            intensityFactor = 1.2;
          else if (rir == 1)
            intensityFactor = 1.1;
          else if (rir == 2)
            intensityFactor = 1.0;

          // TUT Bonus: Time under tension (if tracked)
          double tutBonus = 1.0;
          if (set.tutSeconds != null && set.tutSeconds! > 0) {
            // Ideally 30-50s for hypertrophy
            if (set.tutSeconds! >= 30 && set.tutSeconds! <= 50) tutBonus = 1.1;
          }

          totalEffectiveWork += volume * intensityFactor * tutBonus;
        }

        // Distribute growth to muscle groups
        // Grams per unit of "work" is tiny, e.g. 0.0001g per kg*rep unit
        const workToGramsFactor = 0.0005;

        // 1. Primary Muscle Group
        results.putIfAbsent(primaryGroupName, () => {});

        if (subGroupEngagements.isEmpty) {
          // Use the exercise's subGroup field for more precise tracking,
          // fall back to 'General' only if not set.
          final key = (exercise.subGroup != null && exercise.subGroup!.isNotEmpty)
              ? exercise.subGroup!
              : 'General';
          final current = results[primaryGroupName]![key] ?? 0;
          results[primaryGroupName]![key] =
              current + (totalEffectiveWork * workToGramsFactor);
        } else {
          for (var entry in subGroupEngagements.entries) {
            final subName = entry.key;
            final engagement = entry.value / 100.0;
            final current = results[primaryGroupName]![subName] ?? 0;
            results[primaryGroupName]![subName] =
                current + (totalEffectiveWork * workToGramsFactor * engagement);
          }
        }

        // 2. Secondary Muscle Groups
        for (var entry in secondaryEngagements.entries) {
          final secGroupName = entry.key;
          final engagement = entry.value / 100.0;

          results.putIfAbsent(secGroupName, () => {});
          final current = results[secGroupName]!['General'] ?? 0;
          results[secGroupName]!['General'] =
              current + (totalEffectiveWork * workToGramsFactor * engagement);
        }
      }
    }

    // --- SMART PHYSICS ADJUSTMENT ---
    // If we have biometric data (Weight, BF, Measurements), we adjust the volume-based estimates
    // to match physical reality (Lean Body Mass change + Size change).
    final metrics = await isar.bodyMetrics
        .filter()
        .dateBetween(start, end)
        .sortByDate()
        .findAll();

    if (metrics.length >= 2) {
      final first = metrics.first;
      final last = metrics.last;

      // 1. Calculate Lean Body Mass Change
      double lbmStart =
          (first.weight ?? 0) * (1 - (first.bodyFatPercentage ?? 15) / 100);
      double lbmEnd =
          (last.weight ?? 0) * (1 - (last.bodyFatPercentage ?? 15) / 100);
      double lbmGainsKg = (lbmEnd - lbmStart).clamp(-5.0, 5.0);
      double lbmGainsGrams = lbmGainsKg * 1000;

      // 2. Calculate Circumference Changes (proxy for hypertrophy)
      double totalSizeChange = 0;
      int measuredPoints = 0;

      void addChange(double? s, double? e, double weight) {
        if (s != null && e != null) {
          totalSizeChange += (e - s) * weight;
          measuredPoints++;
        }
      }

      addChange(first.chest, last.chest, 1.5); // Chest is large
      addChange(first.leftArm, last.leftArm, 0.5);
      addChange(first.rightArm, last.rightArm, 0.5);
      addChange(first.leftThigh, last.leftThigh, 1.0);
      addChange(first.rightThigh, last.rightThigh, 1.0);

      // 3. Blend Volume-based Gains with Physics-based Gains
      // If we have physics data, we trust it 40% vs Volume's 60%
      if (measuredPoints > 0 || lbmGainsGrams.abs() > 0.1) {
        // Average of LBM and Size proxy (1cm arm/thigh ~ 200g muscle for this logic)
        double physicsEstimate = (lbmGainsGrams + (totalSizeChange * 200)) / 2;

        // Sum of all volume gains
        double volumeTotal = 0;
        results.forEach(
          (_, subs) => subs.forEach((_, val) => volumeTotal += val),
        );

        if (volumeTotal > 0) {
          // Scaling factor: how much does physical reality differ from the volume model?
          // We don't want to wildly swing, so we damp it.
          double ratio = 1.0;
          if (physicsEstimate > 0) {
            ratio = (physicsEstimate / volumeTotal).clamp(0.5, 2.0);
          } else if (physicsEstimate < 0) {
            ratio =
                0.5; // Drastic performance vs size mismatch reduces trust in volume
          }

          // Apply correction to all muscle groups
          results.forEach((group, subs) {
            subs.forEach((sub, val) {
              results[group]![sub] = val * ratio;
            });
          });
        }
      }
    }

    return results;
  }

  /// Returns historical muscle gains progression
  Future<List<MapEntry<DateTime, double>>> getMuscleGainsHistory({
    required DateTime start,
    required DateTime end,
    required String muscleGroup,
    String? subGroup,
  }) async {
    final isar = await _isarService.db;

    // Get ALL workout days up to 'end' to calculate accumulation correctly
    final workoutDays = await isar.workoutDays
        .where()
        .dateBetween(DateTime(2020), end)
        .findAll();

    final resultHistory = <MapEntry<DateTime, double>>[];

    double accumulatedGains = 0;
    DateTime? lastWorkoutDate;

    // Store best 1RM for each unique exercise to track performance drops
    // Map: ExerciseID -> Best1RM
    final exerciseBest1RM = <int, double>{};

    if (workoutDays.isEmpty) return [];

    final firstDate = workoutDays.first.date;
    final lastDate = end;

    int workoutIndex = 0;
    DateTime currentIter = DateUtils.dateOnly(firstDate);

    while (!currentIter.isAfter(lastDate)) {
      bool workedOutThisMuscle = false;
      double dayGains = 0;
      double performanceScaling = 1.0;

      // 1. Check if workout happened today
      if (workoutIndex < workoutDays.length &&
          DateUtils.isSameDay(workoutDays[workoutIndex].date, currentIter)) {
        final day = workoutDays[workoutIndex];
        double totalSessionPerformanceRatio = 0;
        int performanceCount = 0;

        for (var log in day.exercises) {
          final exercise = log.exercise.value;
          if (exercise == null) continue;

          final isPrimary =
              muscleGroup == 'All' || exercise.muscleGroup.name == muscleGroup;
          final secEngagements = exercise.secondaryMuscleEngagement;
          final isSecondary =
              muscleGroup == 'All' ? false : secEngagements.containsKey(muscleGroup);

          if (!isPrimary && !isSecondary) continue;

          // Check subgroup filter
          if (muscleGroup != 'All' &&
              subGroup != null &&
              subGroup != 'All' &&
              subGroup != 'General') {
            if (!isPrimary) continue;
            final inEngagementMap = exercise.subGroupEngagement.containsKey(
              subGroup,
            );
            final isMainTag = exercise.subGroup == subGroup;
            if (!inEngagementMap && !isMainTag) continue;
          }

          workedOutThisMuscle = true;

          double todaysBest1RM = 0;
          double volume = 0;
          int completedSets = 0;

          for (var set in log.sets) {
            if (!set.isCompleted) continue;
            completedSets++;
            final w = set.weight ?? 0;
            final r = set.reps ?? 0;
            final rir = set.rir ?? 3;
            final est1RM = AnalyticsService.calculate1RM(w, r);
            if (est1RM > todaysBest1RM) todaysBest1RM = est1RM;

            double intensityFactor = (rir == 0 || set.isFailure)
                ? 1.2
                : (rir == 1 ? 1.1 : (rir == 2 ? 1.0 : 0.5));
            volume += (w * r) * intensityFactor;
          }

          if (completedSets > 0) {
            final best1RM = exerciseBest1RM[exercise.id] ?? todaysBest1RM;
            if (todaysBest1RM > best1RM) {
              exerciseBest1RM[exercise.id] = todaysBest1RM;
            }

            totalSessionPerformanceRatio +=
                (todaysBest1RM / (best1RM > 0 ? best1RM : 1.0));
            performanceCount++;

            double engagement = 1.0;
            if (isSecondary) {
              engagement = (secEngagements[muscleGroup] ?? 0) / 100.0;
            } else if (subGroup != null &&
                subGroup != 'All' &&
                subGroup != 'General') {
              // Try detailed map first, then check if it's the main tag
              engagement =
                  (exercise.subGroupEngagement[subGroup] ??
                      (exercise.subGroup == subGroup ? 100.0 : 0.0)) /
                  100.0;
            }

            dayGains += volume * 0.0005 * engagement;
          }
        }

        if (performanceCount > 0) {
          performanceScaling = totalSessionPerformanceRatio / performanceCount;
        }
        workoutIndex++;
      }

      // 2. Apply Decay (Atrophy) Logic
      if (workedOutThisMuscle) {
        lastWorkoutDate = currentIter;
      } else if (lastWorkoutDate != null) {
        final daysInactive = currentIter.difference(lastWorkoutDate).inDays;
        
        // As requested: first 7 days = no loss, day 8+ = 1% loss per day
        if (daysInactive >= 8) {
          accumulatedGains *= 0.99; // 1% drop per day starting from day 8
        }
      }

      // 3. Update accumulation with todays gains
      accumulatedGains += dayGains;
      if (accumulatedGains < 0) accumulatedGains = 0;

      // 4. Save to history if within requested range
      if (!currentIter.isBefore(start)) {
        // We no longer multiply by a daily performanceScaling to prevent the "zero spikes" 
        // reported by the user when a single session has bad performance data.
        resultHistory.add(MapEntry(currentIter, accumulatedGains));
      }

      currentIter = currentIter.add(const Duration(days: 1));
    }

    return resultHistory;
  }

  Future<List<String>> getAllSubGroups(String muscleGroup) async {
    if (muscleGroup == 'All') return [];
    final isar = await _isarService.db;
    final exercises = await isar.exercises
        .filter()
        .muscleGroupEqualTo(
          MuscleGroup.values.firstWhere((e) => e.name == muscleGroup),
        )
        .findAll();

    final subGroups = <String>{};
    for (var exercise in exercises) {
      if (exercise.subGroup != null && exercise.subGroup!.isNotEmpty) {
        subGroups.add(exercise.subGroup!);
      }
      subGroups.addAll(exercise.subGroupEngagement.keys);
    }
    return subGroups.toList()..sort();
  }

  Future<List<MapEntry<DateTime, double>>> getMetricHistory({
    required DateTime start,
    required DateTime end,
    required String
    metricField, // 'weight', 'bodyFatPercentage', 'estimatedFreeTestosterone'
  }) async {
    final isar = await _isarService.db;
    final normalizedStart = DateUtils.dateOnly(start);
    final normalizedEnd = DateUtils.dateOnly(end);

    final metrics = await isar.bodyMetrics
        .filter()
        .dateBetween(normalizedStart, normalizedEnd)
        .sortByDate()
        .findAll();

    return metrics
        .map((m) {
          double val = 0;
          if (metricField == 'weight')
            val = m.weight ?? 0;
          else if (metricField == 'bodyFatPercentage')
            val = m.bodyFatPercentage ?? 0;
          else if (metricField == 'estimatedFreeTestosterone')
            val = m.estimatedFreeTestosterone ?? 0;
          else if (metricField == 'neck')
            val = m.neck ?? 0;
          else if (metricField == 'chest')
            val = m.chest ?? 0;
          else if (metricField == 'waist')
            val = m.waist ?? 0;
          else if (metricField == 'hips')
            val = m.hips ?? 0;
          else if (metricField == 'leftArm')
            val = m.leftArm ?? 0;
          else if (metricField == 'rightArm')
            val = m.rightArm ?? 0;
          else if (metricField == 'leftForearm')
            val = m.leftForearm ?? 0;
          else if (metricField == 'rightForearm')
            val = m.rightForearm ?? 0;
          else if (metricField == 'leftThigh')
            val = m.leftThigh ?? 0;
          else if (metricField == 'rightThigh')
            val = m.rightThigh ?? 0;
          else if (metricField == 'leftCalf')
            val = m.leftCalf ?? 0;
          else if (metricField == 'rightCalf')
            val = m.rightCalf ?? 0;
          return MapEntry(m.date, val);
        })
        .where((element) => element.value > 0)
        .toList();
  }

  Future<List<MapEntry<DateTime, double>>> getGripHistory({
    required DateTime start,
    required DateTime end,
    required String mode, // 'Left', 'Right', 'Average'
  }) async {
    final isar = await _isarService.db;
    final metrics = await isar.bodyMetrics
        .filter()
        .dateBetween(DateUtils.dateOnly(start), DateUtils.dateOnly(end))
        .sortByDate()
        .findAll();

    return metrics
        .map((m) {
          double val = 0;
          final l = m.gripStrengthLeft ?? 0;
          final r = m.gripStrengthRight ?? 0;
          if (mode == 'Left')
            val = l;
          else if (mode == 'Right')
            val = r;
          else
            val = (l + r) / 2;
          return MapEntry(m.date, val);
        })
        .where((element) => element.value > 0)
        .toList();
  }
}
