import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolumeChartDialog extends StatefulWidget {
  final EvolutionCubit cubit;

  const VolumeChartDialog({super.key, required this.cubit});

  @override
  State<VolumeChartDialog> createState() => _VolumeChartDialogState();
}

class _VolumeChartDialogState extends State<VolumeChartDialog> {
  String _timeFrame = '1m';
  bool _separateWorkouts = false;
  String?
  _selectedWorkout; // For filtering in separated mode if needed, but and asked for all lines

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    final now = DateTime.now();
    DateTime start;
    switch (_timeFrame) {
      case '1w':
        start = now.subtract(const Duration(days: 7));
        break;
      case '1m':
        start = now.subtract(const Duration(days: 30));
        break;
      case '3m':
        start = now.subtract(const Duration(days: 90));
        break;
      case '6m':
        start = now.subtract(const Duration(days: 180));
        break;
      case '1y':
        start = now.subtract(const Duration(days: 365));
        break;
      default:
        start = now.subtract(const Duration(days: 30));
    }
    widget.cubit.loadVolumeHistory(start: start, end: now);
  }

  String _formatVolume(double volumeInKg, bool isLbs) {
    double value = volumeInKg;
    String unit = "kg";

    if (isLbs) {
      value = volumeInKg * 2.20462;
      unit = "lbs";
    }

    if (value == 0) return "0$unit";
    if (value < 1000) return "${value.round()}$unit";
    double tons = value / 1000;
    if (tons < 10) return "${tons.toStringAsFixed(2)}T";
    if (tons < 100) return "${tons.toStringAsFixed(1)}T";
    return "${tons.round()}T";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<EvolutionCubit, EvolutionState>(
                bloc: widget.cubit,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _buildChart(state);
                },
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.fitness_center_rounded,
                color: Colors.blueAccent,
                size: 20,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'VOLUME ANALYTICS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Reduced from 18
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white38, size: 20),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<EvolutionCubit, EvolutionState>(
            bloc: widget.cubit,
            builder: (context, state) {
              return Row(
                children: [
                  _buildDropdown(
                    value: _timeFrame,
                    items: ['1w', '1m', '3m', '6m', '1y'],
                    onChanged: (v) {
                      setState(() => _timeFrame = v!);
                      _loadHistory();
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildDropdown(
                    value: _separateWorkouts ? 'Separated' : 'All Workouts',
                    items: ['All Workouts', 'Separated'],
                    onChanged: (v) {
                      setState(() => _separateWorkouts = v == 'Separated');
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => widget.cubit.toggleUnit(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blueAccent.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        state.isLbs ? 'lbs' : 'kg',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1A1A1A),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildChart(EvolutionState state) {
    if (state.volumeChartHistory.isEmpty) {
      return const Center(
        child: Text(
          'No volume data for this period',
          style: TextStyle(color: Colors.white38),
        ),
      );
    }

    final List<LineChartBarData> barData = [];
    final workoutNames = <String>{};
    for (var entry in state.volumeChartHistory) {
      workoutNames.addAll(entry.value.keys);
    }

    final colors = [
      Colors.blueAccent,
      Colors.orangeAccent,
      Colors.greenAccent,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.cyanAccent,
      Colors.yellowAccent,
    ];

    if (!_separateWorkouts) {
      // Group all as one line? Actually user said "all workouts or separated".
      // Usually "All Workouts" means aggregate per day.
      final Map<DateTime, double> aggregate = {};
      for (var entry in state.volumeChartHistory) {
        final date = DateUtils.dateOnly(entry.key);
        double dayTotal = 0;
        entry.value.forEach((_, v) => dayTotal += v);
        aggregate[date] = (aggregate[date] ?? 0) + dayTotal;
      }

      final sortedDates = aggregate.keys.toList()..sort();
      barData.add(
        LineChartBarData(
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
                  radius: 4,
                  color: Colors.blueAccent,
                  strokeWidth: 2,
                  strokeColor: Colors.white.withOpacity(0.5),
                ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [Colors.blueAccent.withOpacity(0.2), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          spots: sortedDates.map((d) {
            final x = d.millisecondsSinceEpoch.toDouble();
            return FlSpot(x, aggregate[d]!);
          }).toList(),
        ),
      );
    } else {
      // One line per workout name
      int colorIndex = 0;
      for (var name in workoutNames) {
        final List<FlSpot> spots = [];
        for (var entry in state.volumeChartHistory) {
          if (entry.value.containsKey(name)) {
            spots.add(
              FlSpot(
                entry.key.millisecondsSinceEpoch.toDouble(),
                entry.value[name]!,
              ),
            );
          }
        }
        if (spots.isNotEmpty) {
          barData.add(
            LineChartBarData(
              isCurved: true,
              color: colors[colorIndex % colors.length],
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 3,
                      color: colors[colorIndex % colors.length],
                      strokeWidth: 1,
                      strokeColor: Colors.white,
                    ),
              ),
              spots: spots..sort((a, b) => a.x.compareTo(b.x)),
            ),
          );
          colorIndex++;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: Colors.white.withOpacity(0.05), strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: _getInterval(),
                getTitlesWidget: (value, meta) {
                  final date = DateTime.fromMillisecondsSinceEpoch(
                    value.toInt(),
                  );
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('MM/dd').format(date),
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _formatVolume(value, state.isLbs),
                    style: const TextStyle(color: Colors.white38, fontSize: 8),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: barData,
          // Calculate dynamic range for Y axis
          minY: barData.isEmpty || barData.every((b) => b.spots.isEmpty) 
            ? 0 
            : barData.expand((b) => b.spots).map((s) => s.y).reduce(math.min) * 0.95,
          maxY: barData.isEmpty || barData.every((b) => b.spots.isEmpty)
            ? 100
            : barData.expand((b) => b.spots).map((s) => s.y).reduce(math.max) * 1.05,
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchSpotThreshold: 50,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => const Color(0xFF1A1A1A),
              tooltipBorder: BorderSide(color: Colors.white.withOpacity(0.1)),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  // Find the original name if separated
                  String label = "Total Volume";
                  if (_separateWorkouts) {
                    // Try to identify which series this spot belongs to
                    // This is slightly complex in fl_chart tooltip, we'll try to match by color or similar or just use the index
                    label = workoutNames.toList()[spot.barIndex];
                  }
                  return LineTooltipItem(
                    '$label\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    children: [
                      TextSpan(
                        text: _formatVolume(spot.y, state.isLbs),
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  double _getInterval() {
    switch (_timeFrame) {
      case '1w':
        return 86400000 * 1;
      case '1m':
        return 86400000 * 5;
      case '3m':
        return 86400000 * 15;
      case '6m':
        return 86400000 * 30;
      case '1y':
        return 86400000 * 60;
      default:
        return 86400000 * 5;
    }
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: Colors.white24, size: 14),
          SizedBox(width: 8),
          Text(
            'Volume is calculated as Sets x Reps x Weight',
            style: TextStyle(color: Colors.white24, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
