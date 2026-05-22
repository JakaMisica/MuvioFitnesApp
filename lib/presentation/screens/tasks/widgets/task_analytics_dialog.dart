import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/task_item.dart';
import '../../../../data/models/task_history.dart';
import '../../../../data/repositories/task_repository.dart';
import '../../../../locator.dart';

class TaskAnalyticsDialog extends StatefulWidget {
  final TaskItem task;

  const TaskAnalyticsDialog({super.key, required this.task});

  @override
  State<TaskAnalyticsDialog> createState() => _TaskAnalyticsDialogState();
}

class _TaskAnalyticsDialogState extends State<TaskAnalyticsDialog> {
  final _repository = locator<TaskRepository>();
  List<TaskHistory> _history = [];
  bool _isLoading = true;
  String _selectedTimeRange = '1W'; // 1W, 1M, 3M, 1Y, All
  String? _selectedMetric;
  List<String> _availableMetrics = [];

  @override
  void initState() {
    super.initState();
    _initMetrics();
    _loadHistory();
  }

  void _initMetrics() {
    if (widget.task.hasCounterMetric) _availableMetrics.add('counter');
    if (widget.task.hasDistanceMetric) _availableMetrics.add('distance');
    if (widget.task.hasWeightMetric) _availableMetrics.add('weight');
    if (widget.task.hasEnergyMetric) _availableMetrics.add('energy');
    if (widget.task.hasRatingMetric) _availableMetrics.add('rating');
    if (widget.task.hasPercentageMetric) _availableMetrics.add('percentage');
    if (widget.task.hasFinancialMetric) _availableMetrics.add('financial');

    if (_availableMetrics.isNotEmpty) {
      _selectedMetric = _availableMetrics.first;
    }
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);

    DateTime start;
    final now = DateTime.now();

    switch (_selectedTimeRange) {
      case '1W':
        start = now.subtract(const Duration(days: 7));
        break;
      case '1M':
        start = now.subtract(const Duration(days: 30));
        break;
      case '3M':
        start = now.subtract(const Duration(days: 90));
        break;
      case '1Y':
        start = now.subtract(const Duration(days: 365));
        break;
      default:
        start = DateTime(2000);
    }

    final data = await _repository.getTaskHistory(
      widget.task.id,
      startDate: start,
    );

    setState(() {
      _history = data.where((h) => h.metricType == _selectedMetric).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Analytics',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTimeRangeSelector(),
                  const SizedBox(height: 20),
                  if (_availableMetrics.length > 1) ...[
                    _buildMetricSelector(),
                    const SizedBox(height: 20),
                  ],
                  _buildStatsGrid(),
                  const SizedBox(height: 30),
                  _buildChartContainer(),
                  const SizedBox(height: 30),
                  _buildHistoryList(),
                ],
              ),
            ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['1W', '1M', '3M', '1Y', 'All']
            .map(
              (range) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(range),
                  selected: _selectedTimeRange == range,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedTimeRange = range);
                      _loadHistory();
                    }
                  },
                  backgroundColor: Colors.grey.shade900,
                  selectedColor: Colors.cyanAccent,
                  labelStyle: TextStyle(
                    color: _selectedTimeRange == range
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildMetricSelector() {
    return Wrap(
      spacing: 8,
      children: _availableMetrics
          .map(
            (m) => ChoiceChip(
              label: Text(m.toUpperCase()),
              selected: _selectedMetric == m,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedMetric = m);
                  _loadHistory();
                }
              },
              backgroundColor: Colors.grey.shade900,
              selectedColor: Colors.cyanAccent.withOpacity(0.3),
              labelStyle: TextStyle(
                color: _selectedMetric == m ? Colors.cyanAccent : Colors.white,
                fontSize: 10,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatsGrid() {
    if (_history.isEmpty) return const SizedBox();

    final values = _history.map((h) => h.numericValue).toList();
    final avg = values.reduce((a, b) => a + b) / values.length;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final total = values.reduce((a, b) => a + b);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        _buildStatCard('Average', avg.toStringAsFixed(1)),
        _buildStatCard('Total', total.toStringAsFixed(1)),
        _buildStatCard('Minimum', min.toStringAsFixed(1)),
        _buildStatCard('Maximum', max.toStringAsFixed(1)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartContainer() {
    if (_history.isEmpty) {
      return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'No data for this period',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      height: 300,
      padding: const EdgeInsets.fromLTRB(10, 24, 24, 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.1)),
      ),
      child: LineChart(_buildChartData()),
    );
  }

  LineChartData _buildChartData() {
    final spots = _history.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.numericValue);
    }).toList();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: Colors.white.withOpacity(0.05), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: (_history.length / 5).clamp(1, 100).toDouble(),
            getTitlesWidget: (value, meta) {
              if (value.toInt() < 0 || value.toInt() >= _history.length)
                return const SizedBox();
              final date = _history[value.toInt()].recordedDate;
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  DateFormat('MM/dd').format(date),
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 45,
            getTitlesWidget: (value, meta) => Text(
              value.toStringAsFixed(0),
              style: const TextStyle(color: Colors.grey, fontSize: 10),
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
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyanAccent.withOpacity(0.2),
                Colors.cyanAccent.withOpacity(0),
              ],
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((s) {
              final history = _history[s.x.toInt()];
              return LineTooltipItem(
                '${DateFormat('MMM dd').format(history.recordedDate)}\n${s.y.toStringAsFixed(1)}',
                const TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Entries',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _history.length > 5 ? 5 : _history.length,
          itemBuilder: (context, index) {
            final entry = _history[_history.length - 1 - index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                tileColor: Colors.grey.shade900.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  entry.getFormattedValue(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  DateFormat('MMM dd, yyyy HH:mm').format(entry.recordedDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                trailing: const Icon(
                  Icons.history,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
