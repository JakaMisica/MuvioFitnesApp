import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/analytics/analytics_cubit.dart';
import '../../../data/models/analytics_experiment.dart';
import '../../../core/utils/string_utils.dart';
import '../../widgets/foggy_background.dart';
import 'widgets/multi_metric_chart.dart';
import 'widgets/add_experiment_dialog.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FoggyBackground(
          child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      'CORRELATION LAB',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- Multi-Metric Chart Section ---
                    _buildAnalyticsCard(
                      title: 'CROSS-DOMAIN PERFORMANCE',
                      subtitle: 'Correlating habits with gains',
                      icon: Icons.analytics_outlined,
                      color: Colors.cyanAccent,
                      child: Column(
                        children: [
                          MultiMetricChart(
                            data: state.chartData,
                            visibleMetrics: state.selectedMetrics,
                            isLoading: state.isLoading,
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 24),
                          ...state.availableMetricGroups.entries.map((group) {
                            if (group.value.isEmpty) return const SizedBox();

                            // Check how many are selected in this group
                            final selectedCount = group.value
                                .where((k) => state.selectedMetrics.contains(k))
                                .length;

                            return Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(
                                    group.key.contains('Core')
                                        ? Icons.bolt
                                        : group.key.contains('Physical')
                                            ? Icons.straighten
                                            : group.key.contains('Behaviors')
                                                ? Icons.task_alt
                                                : group.key.contains('Fatigue')
                                                    ? Icons.battery_alert_rounded
                                                    : Icons.science,
                                    color: Colors.white38,
                                    size: 16,
                                  ),
                                title: Text(
                                  group.key.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                subtitle: selectedCount > 0
                                    ? Text(
                                        '$selectedCount selected',
                                        style: const TextStyle(
                                          color: Colors.cyanAccent,
                                          fontSize: 8,
                                        ),
                                      )
                                    : null,
                                iconColor: Colors.cyanAccent,
                                collapsedIconColor: Colors.white24,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      12,
                                      0,
                                      12,
                                      12,
                                    ),
                                    child: Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: group.value.map((key) {
                                        final isSelected = state.selectedMetrics
                                            .contains(key);
                                        final label =
                                            state.metricLabels[key] ??
                                            key.formatMetricKey;
                                        return _MetricToggle(
                                          label: label.toUpperCase(),
                                          isSelected: isSelected,
                                          color: _getMetricColor(key),
                                          onTap: () => context
                                              .read<AnalyticsCubit>()
                                              .toggleMetric(key),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- Correlations Summary ---
                    const Text(
                      'TOP BIO-SYNCHRONIZATIONS',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (state.correlations.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            "Scanning for correlations...",
                            style: TextStyle(
                              color: Colors.white12,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: state.correlations.entries.map((e) {
                            return _buildInsightCard(e.key, e.value);
                          }).toList(),
                        ),
                      ),

                    const SizedBox(height: 32),

                    // --- Experiments Section ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'EXPERIMENTS',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.orangeAccent,
                          ),
                          onPressed: () async {
                            final result =
                                await showDialog<AnalyticsExperiment>(
                                  context: context,
                                  builder: (context) =>
                                      const AddExperimentDialog(),
                                );
                            if (result != null && context.mounted) {
                              context.read<AnalyticsCubit>().addExperiment(
                                result,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (state.experiments.isEmpty)
                      const Center(
                        child: Text(
                          "No active experiments.\nChange a variable and track the results.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white24, fontSize: 12),
                        ),
                      )
                    else
                      ...state.experiments.map((exp) {
                        final results = state.experimentResults[exp.id] ?? {};
                        return _buildExperimentCard(context, exp, results);
                      }),

                    const SizedBox(height: 80),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, double correlation) {
    final color = correlation.abs() > 0.5 ? Colors.greenAccent : Colors.white38;
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(correlation * 100).toInt()}% Sync',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentCard(
    BuildContext context,
    AnalyticsExperiment exp,
    Map<String, double> results,
  ) {
    final List<List<String>> metricRows = [];
    for (var i = 0; i < exp.trackedMetricKeys.length; i += 2) {
      metricRows.add(
        exp.trackedMetricKeys.sublist(
          i,
          i + 2 > exp.trackedMetricKeys.length
              ? exp.trackedMetricKeys.length
              : i + 2,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exp.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                exp.isActive ? 'ACTIVE' : 'COMPLETED',
                style: TextStyle(
                  color: exp.isActive ? Colors.green : Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Variable: ${exp.variableChanged}",
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 16),
          ...metricRows.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  // Left Metric
                  Expanded(
                    child: _buildExperimentCell(row[0], results[row[0]] ?? 0.0),
                  ),
                  // Right Metric (if exists)
                  Expanded(
                    child: row.length > 1
                        ? _buildExperimentCell(row[1], results[row[1]] ?? 0.0)
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () =>
                  context.read<AnalyticsCubit>().deleteExperiment(exp.id),
              child: const Text(
                'End Experiment',
                style: TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentCell(String key, double delta) {
    final isPositive = delta >= 0;
    return Column(
      children: [
        Text(
          "${isPositive ? '+' : ''}${delta.toStringAsFixed(1)}%",
          style: TextStyle(
            color: isPositive ? Colors.greenAccent : Colors.redAccent,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          key.formatMetricKey.toUpperCase(),
          style: const TextStyle(
            color: Colors.white24,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getMetricColor(String key) {
    if (key.startsWith('task_')) return Colors.purpleAccent;
    if (key.startsWith('supp_')) return Colors.orangeAccent;
    if (key.startsWith('fatigue_')) return Colors.redAccent;

    final type = AnalyticsMetricType.values.firstWhereOrNull(
      (e) => e.name == key,
    );
    switch (type) {
      case AnalyticsMetricType.gripStrength:
        return Colors.blueAccent;
      case AnalyticsMetricType.muscleGains:
        return Colors.greenAccent;
      case AnalyticsMetricType.proteinIntake:
        return Colors.blueGrey;
      case AnalyticsMetricType.fatIntake:
        return Colors.yellowAccent;
      case AnalyticsMetricType.carbsIntake:
        return Colors.brown;
      case AnalyticsMetricType.sleepQuality:
        return Colors.indigoAccent;
      case AnalyticsMetricType.workoutPerformance:
        return Colors.cyanAccent;
      case AnalyticsMetricType.stressLevel:
        return Colors.redAccent;
      case AnalyticsMetricType.steps:
        return Colors.greenAccent;
      case AnalyticsMetricType.distance:
        return Colors.blueAccent;
      default:
        if (key.startsWith('measurement')) return Colors.tealAccent;
        return Colors.grey;
    }
  }
}

class _MetricToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _MetricToggle({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.white10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? color : Colors.white24,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
