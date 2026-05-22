import 'package:flutter/material.dart';
import '../../../../data/models/analytics_experiment.dart';
import '../../../../data/repositories/task_repository.dart';
import '../../../../data/repositories/diet_repository.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../locator.dart';
import '../../../../core/utils/string_utils.dart';

class AddExperimentDialog extends StatefulWidget {
  const AddExperimentDialog({super.key});

  @override
  State<AddExperimentDialog> createState() => _AddExperimentDialogState();
}

class _AddExperimentDialogState extends State<AddExperimentDialog> {
  final _titleController = TextEditingController();
  final _variableController = TextEditingController();

  final List<String> _selectedMetricKeys = [];

  List<String> _availableTasks = [];
  List<String> _availableSupps = [];
  List<String> _availableFatigue = [];
  final Map<String, String> _keyToLabel = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDynamicOptions();
  }

  Future<void> _loadDynamicOptions() async {
    final taskRepo = locator<TaskRepository>();
    final dietRepo = locator<DietRepository>();
    final analyticsRepo = locator<AnalyticsRepository>();

    final tasks = await taskRepo.getAllTasks();
    final fatigueMap = await analyticsRepo.discoverAvailableFatigueMetrics();

    // Get unique supplements from last 30 days of diet
    final diets = await dietRepo.getDietsBetween(
      DateTime.now().subtract(const Duration(days: 30)),
      DateTime.now(),
    );

    final suppNames = diets
        .expand((d) => d.supplements.map((s) => s.name))
        .whereType<String>()
        .toSet()
        .toList();

    if (mounted) {
      setState(() {
        _availableTasks = tasks.map((t) {
          final key = 'task_${t.id}';
          _keyToLabel[key] = t.name;
          return key;
        }).toList();

        _availableSupps = suppNames.map((s) {
          final key = 'supp_$s';
          _keyToLabel[key] = s;
          return key;
        }).toList();

        _availableFatigue = fatigueMap.keys.toList();
        _keyToLabel.addAll(fatigueMap);

        // Also map enum types
        for (var type in AnalyticsMetricType.values) {
          _keyToLabel[type.name] = type.name.formatEnum;
        }

        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1a1a1a),
      title: const Text(
        'New Experiment',
        style: TextStyle(color: Colors.white),
      ),
      content: _isLoading
          ? const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Experiment Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _variableController,
                    decoration: const InputDecoration(
                      labelText: 'Variable (e.g. 5g Creatine)',
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'METRICS TO TRACK (COLLECTIVE CORRELATION)',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),

                    _buildSection(
                      'Core Performance',
                      AnalyticsMetricType.values
                          .where((e) =>
                              !e.name.contains('measurement') &&
                              e != AnalyticsMetricType.fatigueIndex)
                          .map((e) => e.name)
                          .toList(),
                      Icons.bolt,
                    ),
                  if (_availableFatigue.isNotEmpty)
                    _buildSection('Fatigue Improvements', _availableFatigue, Icons.battery_alert_rounded),
                  if (_availableTasks.isNotEmpty)
                    _buildSection('Behaviors & Habits', _availableTasks, Icons.task_alt),
                  if (_availableSupps.isNotEmpty)
                    _buildSection('Bio-Active Inputs', _availableSupps, Icons.science),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.white38)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            if (_titleController.text.isNotEmpty &&
                _selectedMetricKeys.isNotEmpty) {
              final exp = AnalyticsExperiment()
                ..title = _titleController.text
                ..variableChanged = _variableController.text
                ..description = "Tracking impact of ${_variableController.text}"
                ..startDate = DateTime.now()
                ..trackedMetricKeys = _selectedMetricKeys;
              Navigator.pop(context, exp);
            }
          },
          child: const Text('Start Experiment'),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<String> keys, IconData icon) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.white38, size: 16),
        tilePadding: EdgeInsets.zero,
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        initiallyExpanded: false,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: keys.map((key) {
              final isSelected = _selectedMetricKeys.contains(key);
              String label = _keyToLabel[key] ?? key.formatMetricKey;
    
              return FilterChip(
                visualDensity: VisualDensity.compact,
                label: Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontSize: 9,
                  ),
                ),
                selected: isSelected,
                selectedColor: Colors.orangeAccent,
                checkmarkColor: Colors.black,
                backgroundColor: Colors.white.withOpacity(0.05),
                onSelected: (val) {
                  setState(() {
                    if (val)
                      _selectedMetricKeys.add(key);
                    else
                      _selectedMetricKeys.remove(key);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
