import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/analytics_experiment.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../locator.dart';
import '../../../../core/utils/string_utils.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsRepository _repository = locator<AnalyticsRepository>();

  AnalyticsCubit() : super(const AnalyticsState()) {
    refresh();
  }

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true));

    final experiments = await _repository.getAllExperiments();

    // 1. Data Window
    final start = DateTime.now().subtract(const Duration(days: 60));
    final end = DateTime.now();

    // 2. Discover and Label Metrics
    final taskMap = await _repository.discoverAvailableTasks();
    final suppMap = await _repository.discoverAvailableSupplements();
    final fatigueMap = await _repository.discoverAvailableFatigueMetrics();

    // Build Label Map
    final Map<String, String> labels = {};
    for (var type in AnalyticsMetricType.values) {
      labels[type.name] = type.name.formatMetricKey;
    }

    // Merge dynamic labels
    labels.addAll(taskMap);
    labels.addAll(suppMap);
    labels.addAll(fatigueMap);

    final Map<String, List<String>> groups = {
      'Core Performance': AnalyticsMetricType.values
          .where((e) => !e.name.startsWith('measurement') && e != AnalyticsMetricType.fatigueIndex)
          .map((e) => e.name)
          .toList(),
      'Physical Measurements': AnalyticsMetricType.values
          .where((e) => e.name.startsWith('measurement'))
          .map((e) => e.name)
          .toList(),
      'Behaviors & Habits': taskMap.keys.toList(),
      'Bio-Active Inputs': suppMap.keys.toList(),
      'Fatigue Improvements': fatigueMap.keys.toList(),
    };

    // 3. Load chart data for selected metrics
    final Map<String, List<MapEntry<DateTime, double>>> chartData = {};
    for (var key in state.selectedMetrics) {
      chartData[key] = await _repository.getMetricPoints(key, start, end);
    }

    // 4. Global Auto-Discovery Engine (Top Synced Pairs)
    final allCandidateKeys = [
      ...groups['Core Performance']!,
      ...groups['Behaviors & Habits']!,
      ...groups['Bio-Active Inputs']!,
      ...groups['Fatigue Improvements']!,
    ];

    final List<MapEntry<String, double>> scoredPairs = [];
    final coreKeys = groups['Core Performance']!;
    int scanCount = 0;
    const maxScans = 100; // Reduced for performance

    try {
      for (int i = 0; i < allCandidateKeys.length && scanCount < maxScans; i++) {
        final keyA = allCandidateKeys[i];
        bool isCoreA = coreKeys.contains(keyA);

        for (int j = i + 1; j < allCandidateKeys.length && scanCount < maxScans; j++) {
          final keyB = allCandidateKeys[j];
          bool isCoreB = coreKeys.contains(keyB);
          
          if (!isCoreA && !isCoreB) continue; 

          scanCount++;
          // Only check lag 0 for speed in auto-discovery
          final corr = await _repository.getCrossMetricCorrelation(
            keyA,
            keyB,
            days: 60,
            lagDays: 0,
          );
          if (corr.abs() > 0.40) {
            final labelA = labels[keyA] ?? keyA.formatMetricKey;
            final labelB = labels[keyB] ?? keyB.formatMetricKey;
            final title = "$labelA & $labelB";
            scoredPairs.add(MapEntry(title, corr));
          }
        }
      }
    } catch (e) {
      print("Error scanning correlations: $e");
    }

    scoredPairs.sort((a, b) => b.value.abs().compareTo(a.value.abs()));
    final topPairs = Map.fromEntries(scoredPairs.take(12));

    // 5. Analyze experiments
    final Map<int, Map<String, double>> expResults = {};
    for (var exp in experiments) {
      expResults[exp.id] = await _repository.analyzeExperiment(exp);
    }

    emit(
      state.copyWith(
        isLoading: false,
        experiments: experiments,
        chartData: chartData,
        correlations: topPairs,
        experimentResults: expResults,
        availableMetricGroups: groups,
        metricLabels: labels,
      ),
    );
  }

  Future<void> toggleMetric(String key) async {
    final newList = List<String>.from(state.selectedMetrics);
    if (newList.contains(key)) {
      newList.remove(key);
    } else {
      newList.add(key);
    }
    emit(state.copyWith(selectedMetrics: newList, isLoading: true));
    await refresh();
  }

  Future<void> addExperiment(AnalyticsExperiment exp) async {
    await _repository.saveExperiment(exp);
    await refresh();
  }

  Future<void> deleteExperiment(int id) async {
    await _repository.deleteExperiment(id);
    await refresh();
  }
}
