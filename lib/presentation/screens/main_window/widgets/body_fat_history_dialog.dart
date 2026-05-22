import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';
import 'body_fat_dialog.dart';

class BodyFatHistoryDialog extends StatefulWidget {
  const BodyFatHistoryDialog({super.key});

  @override
  State<BodyFatHistoryDialog> createState() => _BodyFatHistoryDialogState();
}

class _BodyFatHistoryDialogState extends State<BodyFatHistoryDialog> {
  String _selectedTimeframe = '30d';
  final List<String> _timeframes = ['7d', '30d', '3m', '6m', '1y', 'All Time'];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final end = DateTime.now();
    final start = _getStartTime(end);
    context.read<EvolutionCubit>().loadMeasurementHistory(
          start: start,
          end: end,
          field: 'bodyFatPercentage',
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
    return BlocBuilder<EvolutionCubit, EvolutionState>(
      builder: (context, state) {
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
                  color: const Color(0xFFFF4081).withOpacity(0.05),
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
                    const Text(
                      'BODY FAT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Timeframe Selector
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFF4081) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              t.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
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
                  height: 250,
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Color(0xFFFF4081)),
                        )
                      : state.measurementChartHistory.isEmpty
                          ? Center(
                              child: Text(
                                'No body fat data for this period',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                              ),
                            )
                          : LineChart(_mainData(state.measurementChartHistory)),
                ),

                const SizedBox(height: 32),
                
                // Add Body Fat Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _showBodyFatDialog(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('LOG NEW BODY FAT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4081),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBodyFatDialog(BuildContext context) async {
    final cubit = context.read<EvolutionCubit>();
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => BodyFatDialog(
        initialPercentage: cubit.state.latestMetric?.bodyFatPercentage,
        age: cubit.state.settings?.age ?? 25,
        gender: cubit.state.settings?.gender ?? 'male',
        weight: cubit.state.latestMetric?.weight ?? 75.0,
      ),
    );
    if (result != null) {
      await cubit.saveBodyFat(
        percentage: result['percentage'],
        method: result['method'],
        chest: result['chest'],
        abdominal: result['abs'],
        thigh: result['thigh'],
        tricep: result['tricep'],
        subscapular: result['subscapular'],
        suprailiac: result['suprailiac'],
        midaxillary: result['midaxillary'],
        bicep: result['bicep'],
        lowerBack: result['lowerBack'],
        calf: result['calf'],
      );
      _loadHistory(); // Refresh
    }
  }

  LineChartData _mainData(List<MapEntry<DateTime, double>> history) {
    if (history.isEmpty) return LineChartData();
    
    double minVal = history.map((e) => e.value).reduce(math.min);
    double maxVal = history.map((e) => e.value).reduce(math.max);
    
    double padding = (maxVal - minVal) * 0.2;
    if (padding == 0) padding = 2.0;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxVal - minVal + padding) / 4,
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
            interval: history.length > 7 ? (history.length / 5).toDouble() : 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= 0 && value.toInt() < history.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    DateFormat('MM/dd').format(history[value.toInt()].key),
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 9),
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
            interval: (maxVal - minVal + padding) / 4,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toStringAsFixed(1)}%',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 9),
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (history.length - 1).toDouble(),
      minY: (minVal - padding).clamp(0, double.infinity),
      maxY: maxVal + padding,
      lineBarsData: [
        LineChartBarData(
          spots: history
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.value))
              .toList(),
          isCurved: true,
          color: const Color(0xFFFF4081),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: history.length < 20),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFF4081).withOpacity(0.3),
                const Color(0xFFFF4081).withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
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
                '${spot.y.toStringAsFixed(1)}%',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
