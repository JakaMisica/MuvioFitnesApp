import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../logic/cubit/sleep/sleep_cubit.dart';
import '../../../data/models/sleep_models.dart';
import '../../widgets/foggy_background.dart';

class SleepTrendsScreen extends StatefulWidget {
  const SleepTrendsScreen({super.key});

  @override
  State<SleepTrendsScreen> createState() => _SleepTrendsScreenState();
}

class _SleepTrendsScreenState extends State<SleepTrendsScreen> {
  String _timeframe = '7d';
  String _metric = 'Quality';

  final timeframeOptions = {'7d': 7, '30d': 30, '3m': 90, '1y': 365};

  final metricOptions = [
    'Quality',
    'Snoring',
    'Movement',
    'Stages',
    'Respiratory',
  ];

  @override
  void initState() {
    super.initState();
    context.read<SleepCubit>().loadTrendData(timeframeOptions[_timeframe]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: SafeArea(
          child: BlocBuilder<SleepCubit, SleepState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const Gap(32),
                    _buildSelectors(context),
                    const Gap(32),
                    Expanded(
                      child: state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.cyanAccent,
                              ),
                            )
                          : state.history.isEmpty
                          ? const Center(
                              child: Text(
                                "No health data detected for this period",
                                style: TextStyle(color: Colors.white24),
                              ),
                            )
                          : _buildContent(state),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SLEEP ANALYTICS",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
            Text(
              "Biological Trends & Deep Recovery",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSelectors(BuildContext context) {
    return Row(
      children: [
        _buildDropdown(
          value: _timeframe,
          items: timeframeOptions.keys.toList(),
          onChanged: (val) {
            setState(() => _timeframe = val!);
            context.read<SleepCubit>().loadTrendData(timeframeOptions[val]!);
          },
        ),
        const Gap(12),
        _buildDropdown(
          value: _metric,
          items: metricOptions,
          onChanged: (val) {
            setState(() => _metric = val!);
          },
        ),
      ],
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
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          dropdownColor: const Color(0xFF1A1A1A),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.cyanAccent,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(SleepState state) {
    if (_metric == 'Stages') {
      return _buildStagesChart(state);
    }
    return _buildMetricChart(state);
  }

  Widget _buildMetricChart(SleepState state) {
    final history = state.history.reversed.toList();
    final spots = history.asMap().entries.map((e) {
      double value = 0;
      if (_metric == 'Quality') value = e.value.qualityScore * 100;
      if (_metric == 'Snoring')
        value = e.value.events
            .where((ev) => ev.type == SleepEventType.snoring)
            .length
            .toDouble();
      if (_metric == 'Movement')
        value = e.value.events
            .where((ev) => ev.type == SleepEventType.movement)
            .length
            .toDouble();
      if (_metric == 'Respiratory')
        value = e.value.events
            .where((ev) => ev.type == SleepEventType.breathing)
            .length
            .toDouble();

      return FlSpot(e.key.toDouble(), value);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (v) =>
              FlLine(color: Colors.white10, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, meta) {
                if (val.toInt() >= history.length) return const SizedBox();
                final date = history[val.toInt()].startTime;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('MM/dd').format(date),
                    style: const TextStyle(color: Colors.white24, fontSize: 8),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (val, meta) => Text(
                val.toInt().toString(),
                style: const TextStyle(color: Colors.white24, fontSize: 8),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.cyanAccent,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                radius: 3,
                color: Colors.cyanAccent,
                strokeColor: Colors.black,
                strokeWidth: 1.5,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.cyanAccent.withOpacity(0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStagesChart(SleepState state) {
    final history = state.history.reversed.toList();

    final List<BarChartGroupData> groups = [];
    for (int i = 0; i < history.length; i++) {
      final session = history[i];

      // Calculate duration in minutes for each stage
      final stageCounts = {
        SleepStage.awake: 0,
        SleepStage.light: 0,
        SleepStage.deep: 0,
        SleepStage.rem: 0,
      };

      for (var sd in session.stages) {
        stageCounts[sd.stage] =
            (stageCounts[sd.stage] ?? 0) +
            1; // Approx 1 minute per stage detection in our current logic
      }

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: stageCounts.values.fold(0.0, (a, b) => a + b),
              width: 16,
              rodStackItems: [
                BarChartRodStackItem(
                  0,
                  stageCounts[SleepStage.awake]!.toDouble(),
                  Colors.redAccent.withOpacity(0.4),
                ),
                BarChartRodStackItem(
                  stageCounts[SleepStage.awake]!.toDouble(),
                  (stageCounts[SleepStage.awake]! +
                          stageCounts[SleepStage.light]!)
                      .toDouble(),
                  Colors.yellowAccent.withOpacity(0.4),
                ),
                BarChartRodStackItem(
                  (stageCounts[SleepStage.awake]! +
                          stageCounts[SleepStage.light]!)
                      .toDouble(),
                  (stageCounts[SleepStage.awake]! +
                          stageCounts[SleepStage.light]! +
                          stageCounts[SleepStage.rem]!)
                      .toDouble(),
                  Colors.purpleAccent.withOpacity(0.4),
                ),
                BarChartRodStackItem(
                  (stageCounts[SleepStage.awake]! +
                          stageCounts[SleepStage.light]! +
                          stageCounts[SleepStage.rem]!)
                      .toDouble(),
                  stageCounts.values.fold(0.0, (a, b) => a + b),
                  Colors.cyanAccent.withOpacity(0.4),
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val, meta) {
                      if (val.toInt() >= history.length)
                        return const SizedBox();
                      return Text(
                        DateFormat(
                          'MM/dd',
                        ).format(history[val.toInt()].startTime),
                        style: const TextStyle(
                          color: Colors.white24,
                          fontSize: 8,
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: groups,
            ),
          ),
        ),
        const Gap(16),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("Wake", Colors.redAccent.withOpacity(0.4)),
        const Gap(12),
        _legendItem("Light", Colors.yellowAccent.withOpacity(0.4)),
        const Gap(12),
        _legendItem("REM", Colors.purpleAccent.withOpacity(0.4)),
        const Gap(12),
        _legendItem("Deep", Colors.cyanAccent.withOpacity(0.4)),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const Gap(6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
