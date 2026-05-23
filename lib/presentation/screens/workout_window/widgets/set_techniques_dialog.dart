import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../data/models/workout_day.dart';

/// Dialog for selecting which training techniques to track for a set
class TechniqueSelectionDialog extends StatefulWidget {
  final WorkoutSet currentSet;
  final Function(WorkoutSet) onSave;
  final VoidCallback onDelete;

  const TechniqueSelectionDialog({
    super.key,
    required this.currentSet,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<TechniqueSelectionDialog> createState() =>
      _TechniqueSelectionDialogState();
}

class _TechniqueSelectionDialogState extends State<TechniqueSelectionDialog> {
  late WorkoutSet _set;

  @override
  void initState() {
    super.initState();
    _set = WorkoutSet()
      ..weight = widget.currentSet.weight
      ..reps = widget.currentSet.reps
      ..isCompleted = widget.currentSet.isCompleted
      ..side = widget.currentSet.side
      ..rir = widget.currentSet.rir
      ..isFailure = widget.currentSet.isFailure
      ..spotReps = widget.currentSet.spotReps
      ..myoReps = widget.currentSet.myoReps
      ..myoPauseSeconds = widget.currentSet.myoPauseSeconds
      ..partialReps = widget.currentSet.partialReps
      ..isDropSet = widget.currentSet.isDropSet
      ..isWarmUp = widget.currentSet.isWarmUp
      ..eccentricSeconds = widget.currentSet.eccentricSeconds
      ..concentricSeconds = widget.currentSet.concentricSeconds
      ..isometricSeconds = widget.currentSet.isometricSeconds
      ..isRestTimerEnabled = widget.currentSet.isRestTimerEnabled
      ..restDuration = widget.currentSet.restDuration
      ..cablePosition = widget.currentSet.cablePosition
      ..benchPosition = widget.currentSet.benchPosition
      ..isTutEnabled = widget.currentSet.isTutEnabled;
  }

  void _showNumberInput(
    String title,
    int? currentValue,
    Function(int?) onChanged, {
    int max = 99,
  }) async {
    final controller = TextEditingController(
      text: currentValue?.toString() ?? '',
    );
    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          onTap: () {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
          },
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter value',
            suffixText: title.contains('seconds') || title.contains('Pause')
                ? 's'
                : '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              Navigator.pop(context, value);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() => onChanged(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Training Techniques',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),

            // Scrollable technique list
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTechniqueRow(
                      'RIR',
                      _set.rir != null,
                      const Color(0xFFADD8E6),
                      Icons.military_tech,
                      () => _showNumberInput(
                        'RIR',
                        _set.rir,
                        (v) => _set.rir = v,
                        max: 10,
                      ),
                      value: _set.rir?.toString(),
                      key: TutorialService().getKeyForStep(
                        TutorialStep.rirOption,
                      ),
                    ),
                    _buildToggleRow(
                      'Failure',
                      _set.isFailure,
                      const Color(0xFFFF6B6B),
                      Icons.bolt,
                      (v) => setState(() => _set.isFailure = v),
                    ),
                    _buildTechniqueRow(
                      'Spot (reps)',
                      _set.spotReps != null,
                      const Color(0xFFFF6B6B),
                      Icons.people,
                      () => _showNumberInput(
                        'Spot Reps',
                        _set.spotReps,
                        (v) => _set.spotReps = v,
                      ),
                      value: _set.spotReps?.toString(),
                    ),
                    _buildTechniqueRow(
                      'Myo Reps',
                      _set.myoReps != null || _set.myoPauseSeconds != null,
                      const Color(0xFFFFD93D),
                      Icons.layers,
                      () => _showMyoRepsDialog(),
                      value: _set.myoReps != null
                          ? '${_set.myoReps}x${_set.myoPauseSeconds ?? 0}s'
                          : null,
                    ),
                    _buildTechniqueRow(
                      'Partials',
                      _set.partialReps != null,
                      const Color(0xFF6FAAFF),
                      Icons.straighten,
                      () => _showNumberInput(
                        'Partial Reps',
                        _set.partialReps,
                        (v) => _set.partialReps = v,
                      ),
                      value: _set.partialReps?.toString(),
                    ),
                    _buildToggleRow(
                      'Drop Sets',
                      _set.isDropSet,
                      Colors.purpleAccent,
                      Icons.trending_down,
                      (v) => setState(() => _set.isDropSet = v),
                    ),
                    _buildToggleRow(
                      'Warm Up',
                      _set.isWarmUp,
                      const Color(0xFF90EE90),
                      Icons.whatshot,
                      (v) => setState(() => _set.isWarmUp = v),
                    ),
                    _buildTechniqueRow(
                      'Eccentric (seconds)',
                      _set.eccentricSeconds != null,
                      const Color(0xFFADD8E6),
                      Icons.south,
                      () => _showNumberInput(
                        'Eccentric seconds',
                        _set.eccentricSeconds,
                        (v) => _set.eccentricSeconds = v,
                        max: 30,
                      ),
                      value: _set.eccentricSeconds?.toString(),
                    ),
                    _buildTechniqueRow(
                      'Concentric (seconds)',
                      _set.concentricSeconds != null,
                      const Color(0xFF90EE90),
                      Icons.north,
                      () => _showNumberInput(
                        'Concentric seconds',
                        _set.concentricSeconds,
                        (v) => _set.concentricSeconds = v,
                        max: 30,
                      ),
                      value: _set.concentricSeconds?.toString(),
                    ),
                    _buildTechniqueRow(
                      'Isometric (seconds)',
                      _set.isometricSeconds != null,
                      Colors.orange,
                      Icons.pause_circle,
                      () => _showNumberInput(
                        'Isometric seconds',
                        _set.isometricSeconds,
                        (v) => _set.isometricSeconds = v,
                        max: 30,
                      ),
                      value: _set.isometricSeconds?.toString(),
                    ),
                    _buildToggleRow(
                      'Rest Timer',
                      _set.isRestTimerEnabled,
                      Colors.greenAccent,
                      Icons.timer_outlined,
                      (v) => setState(() => _set.isRestTimerEnabled = v),
                    ),
                    if (_set.isRestTimerEnabled)
                      _buildTechniqueRow(
                        'Rest Duration',
                        true,
                        Colors.greenAccent,
                        Icons.more_time,
                        () => _showNumberInput(
                          'Rest Timer Duration',
                          _set.restDuration,
                          (v) => _set.restDuration = v,
                          max: 600,
                        ),
                        value: '${_set.restDuration ?? 90}s',
                      ),
                    _buildToggleRow(
                      'TUT Feature',
                      _set.isTutEnabled,
                      Colors.blueAccent,
                      Icons.av_timer,
                      (v) => setState(() => _set.isTutEnabled = v),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    widget.onDelete();
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(40, 40),
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text(
                    'Delete\nSet',
                    textAlign: TextAlign.left,
                    style: TextStyle(height: 1.1, fontSize: 13),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(_set);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    String label,
    bool value,
    Color color,
    IconData icon,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => onChanged(!value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: value
                ? color.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            border: Border.all(color: value ? color : Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: value ? color : Colors.grey),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontWeight: value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              Icon(
                value ? Icons.check_box : Icons.check_box_outline_blank,
                color: value ? color : Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechniqueRow(
    String label,
    bool isActive,
    Color color,
    IconData icon,
    VoidCallback onTap, {
    String? value,
    Function(bool)? onToggle,
    Key? key,
  }) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (onToggle != null) {
            onToggle(!isActive);
          } else {
            onTap();
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? color.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            border: Border.all(color: isActive ? color : Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: isActive ? color : Colors.grey),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (value != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (onToggle != null)
                Switch(value: isActive, onChanged: onToggle, activeColor: color)
              else
                Icon(
                  isActive ? Icons.check_circle : Icons.add_circle_outline,
                  color: isActive ? color : Colors.grey,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMyoRepsDialog() async {
    final repsController = TextEditingController(
      text: _set.myoReps?.toString() ?? '',
    );
    final pauseController = TextEditingController(
      text: _set.myoPauseSeconds?.toString() ?? '',
    );

    final result = await showDialog<Map<String, int>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Myo Reps'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: repsController,
              autofocus: true,
              onTap: () {
                repsController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: repsController.text.length,
                );
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Reps',
                hintText: 'Number of reps',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pauseController,
              onTap: () {
                pauseController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: pauseController.text.length,
                );
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Pause (seconds)',
                hintText: 'Rest between sets',
                suffixText: 's',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final reps = int.tryParse(repsController.text);
              final pause = int.tryParse(pauseController.text);
              if (reps != null) {
                Navigator.pop(context, {'reps': reps, 'pause': pause ?? 0});
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        _set.myoReps = result['reps'];
        _set.myoPauseSeconds = result['pause'];
      });
    }
  }
}
