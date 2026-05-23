import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/analytics_experiment.dart';
import '../../../../core/utils/string_utils.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class MultiMetricChart extends StatelessWidget {
  final Map<String, List<MapEntry<DateTime, double>>> data;
  final List<String> visibleMetrics;
  final bool isLoading;

  const MultiMetricChart({
    super.key,
    required this.data,
    required this.visibleMetrics,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 250, child: _buildChartContent());
  }

  Widget _buildChartContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.cyanAccent,
          strokeWidth: 2,
        ),
      );
    }

    if (data.isEmpty || visibleMetrics.isEmpty) {
      return const Center(
        child: Text(
          "No metrics selected or no data",
          style: TextStyle(color: Colors.white24, fontSize: 10),
        ),
      );
    }

    final List<DateTime> sortedDates =
        data.values.expand((list) => list.map((e) => e.key)).toSet().toList()
          ..sort();

    if (sortedDates.isEmpty) {
      return const Center(
        child: Text(
          "Empty timeline",
          style: TextStyle(color: Colors.white24, fontSize: 10),
        ),
      );
    }

    return LineChart(
      LineChartData(
        minY: -0.02,
        maxY: 1.02,
        lineBarsData: visibleMetrics.map((key) {
          final metricData = data[key] ?? [];
          if (metricData.isEmpty) return LineChartBarData(spots: []);

          final values = metricData.map((e) => e.value).toList();
          final min = values.reduce(math.min);
          final max = values.reduce(math.max);
          final range = (max - min) == 0 ? 1.0 : (max - min);

          final Map<DateTime, double> dateToVal = Map.fromEntries(metricData);

          final spots = sortedDates
              .asMap()
              .entries
              .where((e) => dateToVal.containsKey(e.value))
              .map((e) {
                final date = e.value;
                final val = dateToVal[date]!;

                // If range is 0 (all points same), center the point at 0.5
                final normalizedY = (max - min) == 0
                    ? 0.5
                    : (val - min) / range;
                return FlSpot(e.key.toDouble(), normalizedY);
              })
              .toList();

          return LineChartBarData(
            spots: spots,
            isCurved: true,
            color: _getMetricColor(key),
            barWidth: 3,
            dotData: FlDotData(
              show:
                  spots.length ==
                  1, // Show dots only if there is nothing to connect
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                    radius: 4,
                    color: _getMetricColor(key),
                    strokeWidth: 2,
                    strokeColor: Colors.black,
                  ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: _getMetricColor(key).withOpacity(0.05),
            ),
          );
        }).toList(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (val) =>
              FlLine(color: Colors.white.withOpacity(0.05), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: (sortedDates.length / 4).clamp(1, 100).toDouble(),
              getTitlesWidget: (val, meta) {
                final idx = val.toInt();
                if (idx < 0 || idx >= sortedDates.length)
                  return const SizedBox();
                final date = sortedDates[idx];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    DateFormat('MM/dd').format(date),
                    style: const TextStyle(color: Colors.white24, fontSize: 9),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final key = visibleMetrics[touchedSpots.indexOf(spot)];
                final date = sortedDates[spot.x.toInt()];
                final valEntry = data[key]!.firstWhereOrNull(
                  (e) => e.key == date,
                );
                final valStr = valEntry != null
                    ? valEntry.value.toStringAsFixed(1)
                    : "N/A";

                return LineTooltipItem(
                  "${key.formatMetricKey}: $valStr",
                  TextStyle(
                    color: _getMetricColor(key),
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Color _getMetricColor(String key) {
    if (key.startsWith('task_')) return Colors.purpleAccent;
    if (key.startsWith('supp_')) return Colors.orangeAccent;

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
      default:
        return Colors.grey;
    }
  }
}
