import 'package:biofit_pro/data/models/body_metric.dart';
import 'package:biofit_pro/data/models/user_settings.dart';
import 'package:equatable/equatable.dart';

class EvolutionState extends Equatable {
  final List<BodyMetric> metrics;
  final BodyMetric? latestMetric;
  final UserSettings? settings;
  final bool isLoading;
  final Map<String, Map<String, double>> muscleGains;
  final List<MapEntry<DateTime, double>> chartHistory;
  final List<MapEntry<DateTime, double>> testoChartHistory;
  final List<MapEntry<DateTime, double>> gripChartHistory;
  final List<MapEntry<DateTime, double>> measurementChartHistory;
  final List<MapEntry<DateTime, Map<String, double>>> volumeChartHistory;
  final double totalVolumeWeek;
  final List<String> availableSubGroups;
  final bool isLbs;
  final bool isMetricMeasurements;
  final Map<String, double> measurementChanges;
  final Map<String, double> fatigueImprovements;
  final bool showBottomMetrics;
  final String? error;

  const EvolutionState({
    this.metrics = const [],
    this.latestMetric,
    this.settings,
    this.isLoading = false,
    this.muscleGains = const {},
    this.fatigueImprovements = const {},
    this.chartHistory = const [],
    this.testoChartHistory = const [],
    this.gripChartHistory = const [],
    this.measurementChartHistory = const [],
    this.volumeChartHistory = const [],
    this.totalVolumeWeek = 0,
    this.availableSubGroups = const [],
    this.isLbs = false,
    this.isMetricMeasurements = true,
    this.measurementChanges = const {},
    this.showBottomMetrics = false,
    this.error,
  });

  EvolutionState copyWith({
    List<BodyMetric>? metrics,
    BodyMetric? latestMetric,
    UserSettings? settings,
    bool? isLoading,
    Map<String, Map<String, double>>? muscleGains,
    List<MapEntry<DateTime, double>>? chartHistory,
    List<MapEntry<DateTime, double>>? testoChartHistory,
    List<MapEntry<DateTime, double>>? gripChartHistory,
    List<MapEntry<DateTime, double>>? measurementChartHistory,
    List<MapEntry<DateTime, Map<String, double>>>? volumeChartHistory,
    double? totalVolumeWeek,
    List<String>? availableSubGroups,
    bool? isLbs,
    bool? isMetricMeasurements,
    Map<String, double>? fatigueImprovements,
    Map<String, double>? measurementChanges,
    bool? showBottomMetrics,
    String? error,
  }) {
    return EvolutionState(
      metrics: metrics ?? this.metrics,
      latestMetric: latestMetric ?? this.latestMetric,
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      muscleGains: muscleGains ?? this.muscleGains,
      fatigueImprovements: fatigueImprovements ?? this.fatigueImprovements,
      chartHistory: chartHistory ?? this.chartHistory,
      testoChartHistory: testoChartHistory ?? this.testoChartHistory,
      gripChartHistory: gripChartHistory ?? this.gripChartHistory,
      measurementChartHistory: measurementChartHistory ?? this.measurementChartHistory,
      volumeChartHistory: volumeChartHistory ?? this.volumeChartHistory,
      totalVolumeWeek: totalVolumeWeek ?? this.totalVolumeWeek,
      availableSubGroups: availableSubGroups ?? this.availableSubGroups,
      isLbs: isLbs ?? this.isLbs,
      isMetricMeasurements: isMetricMeasurements ?? this.isMetricMeasurements,
      measurementChanges: measurementChanges ?? this.measurementChanges,
      showBottomMetrics: showBottomMetrics ?? this.showBottomMetrics,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    metrics,
    latestMetric,
    settings,
    isLoading,
    muscleGains,
    fatigueImprovements,
    chartHistory,
    testoChartHistory,
    gripChartHistory,
    measurementChartHistory,
    volumeChartHistory,
    totalVolumeWeek,
    availableSubGroups,
    isLbs,
    isMetricMeasurements,
    measurementChanges,
    showBottomMetrics,
    error,
  ];
}
