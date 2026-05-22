import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/enums.dart';
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';

class GainsChartDialog extends StatefulWidget {
  final Map<String, Map<String, double>> muscleGains;
  final Function(DateTime start, DateTime end) onTimeframeChange;

  const GainsChartDialog({
    super.key,
    required this.muscleGains,
    required this.onTimeframeChange,
  });

  @override
  State<GainsChartDialog> createState() => _GainsChartDialogState();
}

class _GainsChartDialogState extends State<GainsChartDialog> {
  String _selectedTimeframe = '7d';
  String _selectedMuscleGroup = 'All';
  String _selectedSubGroup = 'All';

  final List<String> _timeframes = ['7d', '30d', '3m', '6m', '1y', 'All Time'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHistory();
    });
  }

  void _loadHistory() {
    final end = DateTime.now();
    final start = _getStartTime(end);
    context.read<EvolutionCubit>().loadChartHistory(
      start: start,
      end: end,
      muscleGroup: _selectedMuscleGroup,
      subGroup: _selectedSubGroup,
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
    final muscleGroups = ['All', ...MuscleGroup.values.map((e) => e.name)];

    return BlocBuilder<EvolutionCubit, EvolutionState>(
      builder: (context, state) {
        final subGroups = ['All', ...state.availableSubGroups];
        if (!subGroups.contains(_selectedSubGroup)) {
          _selectedSubGroup = 'All';
        }

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
                  color: Colors.orangeAccent.withOpacity(0.05),
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
                      'GAINS',
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

                // Minimal Controllers in One Row
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
                      _divider(),
                      Expanded(
                        child: _buildCompactDropdown(
                          'Muscle',
                          _selectedMuscleGroup,
                          muscleGroups,
                          (v) {
                            setState(() {
                              _selectedMuscleGroup = v!;
                              _selectedSubGroup = 'All';
                            });
                            _loadHistory();
                          },
                        ),
                      ),
                      _divider(),
                      Expanded(
                        child: _buildCompactDropdown(
                          'Group',
                          _selectedSubGroup,
                          subGroups,
                          (v) {
                            setState(() => _selectedSubGroup = v!);
                            _loadHistory();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // THE GRAPH (Line Chart)
                SizedBox(
                  height: 250,
                  child: state.chartHistory.isEmpty
                      ? (state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.orangeAccent,
                              ),
                            )
                          : Center(
                              child: Text(
                                'No growth data for this period',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 12,
                                ),
                              ),
                            ))
                      : Opacity(
                          opacity: state.isLoading ? 0.6 : 1.0,
                          child: LineChart(_mainData(state.chartHistory)),
                        ),
                ),

                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'TOTAL ACCUMULATED',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_getDisplayTotal(state.chartHistory).toStringAsFixed(2)}g',
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _getDisplayTotal(List<MapEntry<DateTime, double>> history) {
    if (history.isEmpty) return 0;
    // For accumulated graph, the total is the last value
    return history.last.value;
  }

  Widget _divider() => Container(width: 1, height: 20, color: Colors.white10);

  Widget _buildCompactDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: items.contains(value) ? value : items.first,
        dropdownColor: const Color(0xFF1A1A1A),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 14,
          color: Colors.grey,
        ),
        isExpanded: true,
        style: const TextStyle(
          color: Colors.cyanAccent,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Center(
                  child: Text(e.toUpperCase(), textAlign: TextAlign.center),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  LineChartData _mainData(List<MapEntry<DateTime, double>> history) {
    double minGains = history.isEmpty ? 0 : history.map((e) => e.value).reduce(math.min);
    double maxGains = history.isEmpty ? 0 : history.map((e) => e.value).reduce(math.max);
    if (maxGains == minGains) {
      maxGains = minGains + 1.0;
      minGains = minGains - 0.1;
    } else {
      double padding = (maxGains - minGains) * 0.1;
      maxGains += padding;
      minGains -= padding;
    }
    minGains = minGains.clamp(0.0, double.infinity);

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxGains - minGains) / 4,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: Colors.white.withOpacity(0.03), strokeWidth: 1),
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
            interval: (maxGains - minGains) / 4,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toStringAsFixed(2)}g',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 9),
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: history.isEmpty ? 0 : (history.length - 1).toDouble(),
      minY: minGains,
      maxY: maxGains,
      lineBarsData: [
        LineChartBarData(
          spots: history
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.value))
              .toList(),
          isCurved: true,
          color: Colors.orangeAccent,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: history.length < 15,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
                  radius: 3,
                  color: Colors.orangeAccent,
                  strokeWidth: 2,
                  strokeColor: const Color(0xFF121212),
                ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.orangeAccent.withOpacity(0.3),
                Colors.orangeAccent.withOpacity(0.0),
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
                '${spot.y.toStringAsFixed(1)}g',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
