import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';
import 'measurements_dialog.dart';

class BodyMetricsHistoryDialog extends StatefulWidget {
  final String initialField;
  const BodyMetricsHistoryDialog({super.key, this.initialField = 'waist'});

  @override
  State<BodyMetricsHistoryDialog> createState() => _BodyMetricsHistoryDialogState();
}

class _BodyMetricsHistoryDialogState extends State<BodyMetricsHistoryDialog> {
  late String _selectedField;
  String _selectedTimeframe = '30d';
  final List<String> _timeframes = ['7d', '30d', '3m', '6m', '1y', 'All Time'];

  final List<Map<String, String>> _fields = [
    {'key': 'neck', 'label': 'Neck'},
    {'key': 'chest', 'label': 'Chest'},
    {'key': 'waist', 'label': 'Waist'},
    {'key': 'hips', 'label': 'Hips'},
    {'key': 'leftArm', 'label': 'L Arm'},
    {'key': 'rightArm', 'label': 'R Arm'},
    {'key': 'leftForearm', 'label': 'L Forearm'},
    {'key': 'rightForearm', 'label': 'R Forearm'},
    {'key': 'leftThigh', 'label': 'L Thigh'},
    {'key': 'rightThigh', 'label': 'R Thigh'},
    {'key': 'leftCalf', 'label': 'L Calf'},
    {'key': 'rightCalf', 'label': 'R Calf'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedField = widget.initialField;
    _loadHistory();
  }

  void _loadHistory() {
    final end = DateTime.now();
    final start = _getStartTime(end);
    context.read<EvolutionCubit>().loadMeasurementHistory(
          start: start,
          end: end,
          field: _selectedField,
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

  String _getFieldLabel(String key) {
    return _fields.firstWhere((f) => f['key'] == key)['label']!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvolutionCubit, EvolutionState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF101010),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.08),
                  blurRadius: 40,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'BODY METRICS',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              _getFieldLabel(_selectedField).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
                              color: const Color(0xFF1A1A1A),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              onSelected: (val) {
                                setState(() => _selectedField = val);
                                _loadHistory();
                              },
                              itemBuilder: (ctx) => _fields.map((f) => PopupMenuItem(
                                value: f['key'],
                                child: Text(f['label']!, style: const TextStyle(color: Colors.white, fontSize: 13)),
                              )).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white24, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.03),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Timeframe Selector
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.03)),
                  ),
                  child: Row(
                    children: _timeframes.map((t) {
                      final isSelected = _selectedTimeframe == t;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedTimeframe = t);
                            _loadHistory();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blueAccent : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ] : null,
                            ),
                            child: Text(
                              t.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white38,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 32),

                // THE GRAPH
                SizedBox(
                  height: 260,
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.blueAccent),
                        )
                      : state.measurementChartHistory.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.query_stats, color: Colors.white.withOpacity(0.05), size: 48),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No data for ${_getFieldLabel(_selectedField)}',
                                    style: TextStyle(color: Colors.white24, fontSize: 11),
                                  ),
                                ],
                              ),
                            )
                          : LineChart(_mainData(state.measurementChartHistory, state.isMetricMeasurements)),
                ),

                const SizedBox(height: 24),
                
                // Add Metrics Button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showAddDialog(context),
                        icon: const Icon(Icons.add_circle_outline, size: 18),
                        label: const Text('LOG MEASUREMENTS'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.05),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.white.withOpacity(0.05)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddDialog(BuildContext context) async {
    final cubit = context.read<EvolutionCubit>();
    final state = cubit.state;
    final metric = state.latestMetric;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => MeasurementsDialog(
        initialValues: {
          'neck': metric?.neck,
          'chest': metric?.chest,
          'waist': metric?.waist,
          'hips': metric?.hips,
          'leftArm': metric?.leftArm,
          'rightArm': metric?.rightArm,
          'leftForearm': metric?.leftForearm,
          'rightForearm': metric?.rightForearm,
          'leftThigh': metric?.leftThigh,
          'rightThigh': metric?.rightThigh,
          'leftCalf': metric?.leftCalf,
          'rightCalf': metric?.rightCalf,
        },
        initialIsMetric: state.isMetricMeasurements,
      ),
    );

    if (result != null && result['values'] != null) {
      await cubit.saveMeasurements(result['values']);
      _loadHistory();
    }
  }

  LineChartData _mainData(List<MapEntry<DateTime, double>> history, bool isMetric) {
    if (history.isEmpty) return LineChartData();
    
    // Sort history chronologically
    final sorted = List<MapEntry<DateTime, double>>.from(history)..sort((a, b) => a.key.compareTo(b.key));
    
    double minVal = sorted.map((e) => isMetric ? e.value : e.value / 2.54).reduce(math.min);
    double maxVal = sorted.map((e) => isMetric ? e.value : e.value / 2.54).reduce(math.max);
    
    double range = maxVal - minVal;
    double padding = range * 0.2;
    if (padding == 0) padding = 1.0;

    final unit = isMetric ? 'cm' : 'in';

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (range + padding) / 4,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: Colors.white.withOpacity(0.03), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: sorted.length > 7 ? (sorted.length / 5).toDouble() : 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= 0 && value.toInt() < sorted.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    DateFormat('MM/dd').format(sorted[value.toInt()].key),
                    style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (range + padding) / 4,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toStringAsFixed(1)}$unit',
                style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 8),
              );
            },
            reservedSize: 45,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (sorted.length - 1).toDouble(),
      minY: (minVal - padding / 2).clamp(0, double.infinity),
      maxY: maxVal + padding / 2,
      lineBarsData: [
        LineChartBarData(
          spots: sorted
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), isMetric ? e.value.value : e.value.value / 2.54))
              .toList(),
          isCurved: true,
          curveSmoothness: 0.35,
          color: Colors.blueAccent,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: sorted.length < 20,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 5,
              color: const Color(0xFF101010),
              strokeWidth: 3,
              strokeColor: Colors.blueAccent,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.2),
                Colors.blueAccent.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => const Color(0xFF1A1A1A),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toStringAsFixed(1)}$unit',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
