import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import '../../../../data/repositories/workout_repository.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../data/models/exercise.dart';
import '../../../../data/datasources/isar_service.dart';
import '../../../../locator.dart';

class ExerciseAnalyticsDialog extends StatefulWidget {
  final int exerciseId;
  final String exerciseName;
  final bool isIsolate;

  const ExerciseAnalyticsDialog({
    super.key,
    required this.exerciseId,
    required this.exerciseName,
    this.isIsolate = false,
  });

  @override
  State<ExerciseAnalyticsDialog> createState() =>
      _ExerciseAnalyticsDialogState();
}

class _ExerciseAnalyticsDialogState extends State<ExerciseAnalyticsDialog> {
  TimeRange _selectedRange = TimeRange.oneMonth;
  AnalyticsMetric _selectedMetric = AnalyticsMetric.oneRM;
  String? _selectedSide; // null = All, "L" = Left, "R" = Right
  int? _selectedCablePosition; // null = Any
  int? _selectedBenchPosition; // null = Any

  final _repository = locator<WorkoutRepository>();

  Exercise? _exercise;
  List<int> _availableCablePositions = [];
  List<int> _availableBenchPositions = [];
  Map<DateTime, DailyStats>? _stats;
  double _strengthIndex = 1.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Fetch exercise if not already fetched
    if (_exercise == null) {
      final isar = await locator<IsarService>().db;
      _exercise = await isar.exercises.get(widget.exerciseId);

      // Fetch ALL history once to populate available positions
      final allHistory = await _repository.getExerciseHistory(
        widget.exerciseId,
        DateTime(2020),
      );
      final cablePos = <int>{};
      final benchPos = <int>{};
      for (var sets in allHistory.values) {
        for (var s in sets) {
          if (s.cablePosition != null) cablePos.add(s.cablePosition!);
          if (s.benchPosition != null) benchPos.add(s.benchPosition!);
        }
      }
      _availableCablePositions = cablePos.toList()..sort();
      _availableBenchPositions = benchPos.toList()..sort();
    }

    final startDate = _selectedRange.getStartDate();
    var history = await _repository.getExerciseHistory(
      widget.exerciseId,
      startDate,
    );

    // Apply Filters
    history = history.map((date, sets) {
      final filtered = sets.where((s) {
        // Side filter
        if (widget.isIsolate && _selectedSide != null) {
          if ((s.side ?? "R") != _selectedSide) return false;
        }
        // Cable position filter
        if (_selectedCablePosition != null) {
          if (s.cablePosition != _selectedCablePosition) return false;
        }
        // Bench position filter
        if (_selectedBenchPosition != null) {
          if (s.benchPosition != _selectedBenchPosition) return false;
        }
        return true;
      }).toList();
      return MapEntry(date, filtered);
    })..removeWhere((_, sets) => sets.isEmpty);

    // Calculate strength index from all historical data (unfiltered by position maybe?
    // User said "graf will only show for specified...". Strength index is usually per exercise.
    // I'll keep strength index calculated from ALL history for consistency in 1RM formulas.
    final allSetsForIndex = (await _repository.getExerciseHistory(
      widget.exerciseId,
      DateTime(2000),
    )).values.expand((s) => s).toList();
    final strengthIndex = AnalyticsService.calculateStrengthIndex(
      allSetsForIndex,
    );

    // Calculate daily stats
    final stats = AnalyticsService.aggregateDailyStats(history, strengthIndex);

    setState(() {
      _stats = stats;
      _strengthIndex = strengthIndex;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.exerciseName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white60),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row 1: Metric & Range
                    Row(
                      children: [
                        Expanded(
                          child: _buildFilterDropdown<AnalyticsMetric>(
                            label: "Metric",
                            value: _selectedMetric,
                            items: AnalyticsMetric.values
                                .map(
                                  (v) => DropdownMenuItem(
                                    value: v,
                                    child: Text(v.label),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedMetric = v!),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFilterDropdown<TimeRange>(
                            label: "Range",
                            value: _selectedRange,
                            items: TimeRange.values
                                .map(
                                  (v) => DropdownMenuItem(
                                    value: v,
                                    child: Text(v.label),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              setState(() => _selectedRange = v!);
                              _loadData();
                            },
                          ),
                        ),
                      ],
                    ),

                    if ((_exercise?.hasCablePosition ?? false) ||
                        (_exercise?.hasBenchPosition ?? false)) ...[
                      const SizedBox(height: 16),
                      // Row 2: Cable & Bench Positions
                      Row(
                        children: [
                          if (_exercise?.hasCablePosition ?? false)
                            Expanded(
                              child: _buildFilterDropdown<int?>(
                                label: "Cable Pos",
                                value: _selectedCablePosition,
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text("Any"),
                                  ),
                                  ..._availableCablePositions.map(
                                    (pos) => DropdownMenuItem(
                                      value: pos,
                                      child: Text(pos.toString()),
                                    ),
                                  ),
                                ],
                                onChanged: (v) {
                                  setState(() => _selectedCablePosition = v);
                                  _loadData();
                                },
                              ),
                            )
                          else
                            const Spacer(),
                          const SizedBox(width: 16),
                          if (_exercise?.hasBenchPosition ?? false)
                            Expanded(
                              child: _buildFilterDropdown<int?>(
                                label: "Bench Pos",
                                value: _selectedBenchPosition,
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text("Any"),
                                  ),
                                  ..._availableBenchPositions.map(
                                    (pos) => DropdownMenuItem(
                                      value: pos,
                                      child: Text(pos.toString()),
                                    ),
                                  ),
                                ],
                                onChanged: (v) {
                                  setState(() => _selectedBenchPosition = v);
                                  _loadData();
                                },
                              ),
                            )
                          else
                            const Spacer(),
                        ],
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Side Filter
                    if (widget.isIsolate) ...[
                      _buildSideFilter(),
                      const SizedBox(height: 24),
                    ],

                    // Chart Section
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.03),
                          ),
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.cyanAccent,
                                ),
                              )
                            : _buildChart(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Bottom Analytics Card
                    _buildStrengthIndexDisplay(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              dropdownColor: const Color(0xFF2A2A2A),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSideFilter() {
    return Wrap(
      spacing: 8,
      children: [
        _buildSideChip('All', null),
        _buildSideChip('Left', 'L'),
        _buildSideChip('Right', 'R'),
      ],
    );
  }

  Widget _buildSideChip(String label, String? value) {
    final isSelected = _selectedSide == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedSide = value);
          _loadData();
        }
      },
      selectedColor: Colors.cyanAccent.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.cyanAccent : Colors.white60,
      ),
      backgroundColor: Colors.black.withOpacity(0.2),
    );
  }

  Widget _buildChart() {
    if (_stats == null || _stats!.isEmpty) {
      return Center(
        child: Text(
          "No data available for this time range",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Sort dates
    final sortedDates = _stats!.keys.toList()..sort();

    // Create data points
    final spots = <FlSpot>[];
    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final stats = _stats![date]!;

      double value;
      switch (_selectedMetric) {
        case AnalyticsMetric.oneRM:
          value = stats.best1RM;
          break;
        case AnalyticsMetric.volume:
          value = stats.volume;
          break;
        case AnalyticsMetric.tut:
          value = stats.totalTUT;
          break;
        case AnalyticsMetric.tutWeight:
          value = stats.totalTUTWeight;
          break;
      }

      spots.add(FlSpot(i.toDouble(), value));
    }

    if (spots.isEmpty) {
      return Center(child: Text("No data"));
    }

    // Calculate dynamic range for Y axis
    double minVal = spots.map((s) => s.y).reduce(math.min);
    double maxVal = spots.map((s) => s.y).reduce(math.max);
    double range = maxVal - minVal;
    
    // Add 10% padding
    double padding = range == 0 ? minVal * 0.1 : range * 0.1;
    if (padding == 0) padding = 1.0; // Fallback for all zeroes

    double finalMinY = (minVal - padding).clamp(0.0, double.infinity);
    double finalMaxY = maxVal + padding;

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final value = spot.y;
                final date = sortedDates[spot.x.toInt()];
                final stats = _stats![date]!;

                // Format value to ~4 characters logic
                String formatted;
                if (value == value.toInt()) {
                  formatted = value.toInt().toString();
                } else {
                  final s = value.toString();
                  final dot = s.indexOf('.');
                  final precision = (4 - dot).clamp(0, 3);
                  formatted = value.toStringAsFixed(precision);
                }

                String tooltipText =
                    "${DateFormat('MMM d').format(date)}\n$formatted${_selectedMetric.unit}";

                if (stats.bestWeight != null && stats.bestReps != null) {
                  tooltipText +=
                      "\nBest: ${stats.bestWeight}kg x ${stats.bestReps}";
                }

                return LineTooltipItem(
                  tooltipText,
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: range == 0 ? 1 : (range / 5).clamp(0.1, double.infinity),
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.05),
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.05),
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < sortedDates.length) {
                  final date = sortedDates[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MM/dd').format(date),
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.3)),
            bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.cyanAccent,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.cyanAccent.withOpacity(0.2),
                  Colors.cyanAccent.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        minY: finalMinY,
        maxY: finalMaxY,
      ),
    );
  }

  Widget _buildStrengthIndexDisplay() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Strength-to-Rep Index: ${_strengthIndex.toStringAsFixed(2)}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.fitness_center, size: 20), // Weight icon
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                  ),
                  child: Slider(
                    value: _strengthIndex.clamp(0.5, 1.5),
                    min: 0.5,
                    max: 1.5,
                    onChanged: null, // Non-interactive, just displays
                  ),
                ),
              ),
              Icon(Icons.fitness_center, size: 20), // Biceps/muscle icon
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Low Rep",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text(
                "Balanced",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text(
                "High Rep",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
