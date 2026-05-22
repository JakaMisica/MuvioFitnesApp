part of 'analytics_cubit.dart';

class AnalyticsState extends Equatable {
  final bool isLoading;
  final List<AnalyticsExperiment> experiments;

  // Correlations: MetricPair -> Coefficient
  final Map<String, double> correlations;

  // Experiment Results: ExpID -> { MetricTypeKey -> Delta% }
  final Map<int, Map<String, double>> experimentResults;

  // Time Series Data for Chart: MetricKey -> List<MapEntry>
  final Map<String, List<MapEntry<DateTime, double>>> chartData;

  final List<String> selectedMetrics;

  // Available groups: GroupName -> List of metric keys
  final Map<String, List<String>> availableMetricGroups;

  // Human readable labels for any key (e.g. 'task_9' -> 'Meditation')
  final Map<String, String> metricLabels;

  const AnalyticsState({
    this.isLoading = false,
    this.experiments = const [],
    this.correlations = const {},
    this.experimentResults = const {},
    this.chartData = const {},
    this.selectedMetrics = const ['gripStrength', 'muscleGains'],
    this.availableMetricGroups = const {},
    this.metricLabels = const {},
  });

  AnalyticsState copyWith({
    bool? isLoading,
    List<AnalyticsExperiment>? experiments,
    Map<String, double>? correlations,
    Map<int, Map<String, double>>? experimentResults,
    Map<String, List<MapEntry<DateTime, double>>>? chartData,
    List<String>? selectedMetrics,
    Map<String, List<String>>? availableMetricGroups,
    Map<String, String>? metricLabels,
  }) {
    return AnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      experiments: experiments ?? this.experiments,
      correlations: correlations ?? this.correlations,
      experimentResults: experimentResults ?? this.experimentResults,
      chartData: chartData ?? this.chartData,
      selectedMetrics: selectedMetrics ?? this.selectedMetrics,
      availableMetricGroups:
          availableMetricGroups ?? this.availableMetricGroups,
      metricLabels: metricLabels ?? this.metricLabels,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    experiments,
    correlations,
    experimentResults,
    chartData,
    selectedMetrics,
    availableMetricGroups,
    metricLabels,
  ];
}
