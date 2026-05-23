import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';
import 'grip_strength_dialog.dart';

class GripChartDialog extends StatefulWidget {
  const GripChartDialog({super.key});

  @override
  State<GripChartDialog> createState() => _GripChartDialogState();
}

class _GripChartDialogState extends State<GripChartDialog> {
  String _selectedTimeframe = '30d';
  String _selectedMode = 'Average';
  final List<String> _timeframes = ['7d', '30d', '3m', '6m', '1y', 'All Time'];
  final List<String> _modes = ['Left', 'Right', 'Average'];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final end = DateTime.now();
    final start = _getStartTime(end);
    context.read<EvolutionCubit>().loadGripHistory(
      start: start,
      end: end,
      mode: _selectedMode,
    );
  }

  DateTime _getStartTime(DateTime end) {
    switch (_selectedTimeframe) {
      case '7d':
        return end.subtract(const Duration(days: 7));
      case '30d':
        return end.subtract(const Duration(days: 30));
      case '3m':
        return end.subtract(const Duration(days: 90));
      case '6m':
        return end.subtract(const Duration(days: 180));
      case '1y':
        return end.subtract(const Duration(days: 365));
      default:
        return DateTime(2020);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.05),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CNS VIGOR',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'Grip Strength',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildCompactDropdown(
                      'Time',
                      _selectedTimeframe,
                      _timeframes,
                      (v) {
                        setState(() => _selectedTimeframe = v!);
                        _loadHistory();
                      },
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  Expanded(
                    child: _buildCompactDropdown(
                      'Side',
                      _selectedMode,
                      _modes,
                      (v) {
                        setState(() => _selectedMode = v!);
                        _loadHistory();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 250,
              child: BlocBuilder<EvolutionCubit, EvolutionState>(
                builder: (context, state) {
                  if (state.isLoading)
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      ),
                    );
                  if (state.gripChartHistory.isEmpty)
                    return const Center(
                      child: Text(
                        'Not enough data points',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  return LineChart(_mainData(state.gripChartHistory));
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _logGripEntry(context),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text(
                      'LOG NEW MEASUREMENT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent.withOpacity(0.1),
                      foregroundColor: Colors.cyanAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _logGripEntry(BuildContext context) async {
    final cubit = context.read<EvolutionCubit>();
    Navigator.pop(context);
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => GripStrengthDialog(
        initialLeft: cubit.state.latestMetric?.gripStrengthLeft,
        initialRight: cubit.state.latestMetric?.gripStrengthRight,
        initialUseKg: cubit.state.settings?.useKgForGrip ?? true,
      ),
    );
    if (result != null) {
      cubit.saveGripStrength(
        left: result['left']!,
        right: result['right']!,
        useKg: result['useKg']!,
      );
    }
  }

  Widget _buildCompactDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 8,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: value,
            dropdownColor: const Color(0xFF1A1A1A),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: Colors.cyanAccent,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  LineChartData _mainData(List<MapEntry<DateTime, double>> history) {
    double minVal = history.isEmpty
        ? 0
        : history.map((e) => e.value).reduce(math.min);
    double maxVal = history.isEmpty
        ? 0
        : history.map((e) => e.value).reduce(math.max);

    if (maxVal == minVal) {
      maxVal = minVal + 5;
      minVal = minVal - 5;
    } else {
      double padding = (maxVal - minVal) * 0.1;
      maxVal += padding;
      minVal -= padding;
    }
    minVal = minVal.clamp(0.0, double.infinity);

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxVal - minVal) / 5,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: Colors.white.withOpacity(0.05), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: (history.length / 4).clamp(1, 100).toDouble(),
            getTitlesWidget: (value, meta) {
              if (value.toInt() < 0 || value.toInt() >= history.length)
                return const SizedBox();
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  DateFormat('MMM d').format(history[value.toInt()].key),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (maxVal - minVal) / 5,
            getTitlesWidget: (value, meta) => Text(
              '${value.toInt()}',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: history.isEmpty ? 0 : (history.length - 1).toDouble(),
      minY: minVal,
      maxY: maxVal,
      lineBarsData: [
        LineChartBarData(
          spots: history
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.value))
              .toList(),
          isCurved: true,
          gradient: const LinearGradient(
            colors: [Colors.cyan, Colors.cyanAccent],
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.cyan.withOpacity(0.2),
                Colors.cyanAccent.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchSpotThreshold: 50,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toStringAsFixed(1)}kg',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
