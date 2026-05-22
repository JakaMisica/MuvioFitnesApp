import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/exercise.dart';
import '../../../../data/models/enums.dart';
import '../../../../data/models/muscle_metadata.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';

class ExerciseManagementDialog extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback? onAfterDelete;

  const ExerciseManagementDialog({
    super.key,
    required this.exercise,
    this.onAfterDelete,
  });

  @override
  State<ExerciseManagementDialog> createState() =>
      _ExerciseManagementDialogState();
}

class _ExerciseManagementDialogState extends State<ExerciseManagementDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _subGroupController;
  late WeightUnit _selectedUnit;
  late MuscleGroup _selectedGroup;
  late bool _isIsolate;
  late bool _hasCablePosition;
  late bool _hasBenchPosition;

  late bool _trackWeightReps;
  late bool _trackDistance;
  late String _distanceUnit;
  late bool _trackSpeed;
  late String _speedUnit;
  late bool _trackCalories;
  late String _caloriesUnit;

  late Map<String, double> _secondaryEngagements;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exercise.name);
    _subGroupController = TextEditingController(
      text: widget.exercise.subGroup ?? '',
    );
    _selectedUnit = widget.exercise.defaultUnit;
    _selectedGroup = widget.exercise.muscleGroup;
    _isIsolate = widget.exercise.isIsolate;
    _hasCablePosition = widget.exercise.hasCablePosition;
    _hasBenchPosition = widget.exercise.hasBenchPosition;

    _trackWeightReps = widget.exercise.trackWeightReps;
    _trackDistance = widget.exercise.trackDistance;
    _distanceUnit = widget.exercise.distanceUnit ?? "km";
    _trackSpeed = widget.exercise.trackSpeed;
    _speedUnit = widget.exercise.speedUnit ?? "km/h";
    _trackCalories = widget.exercise.trackCalories;
    _caloriesUnit = widget.exercise.caloriesUnit ?? "kJ";

    // Initialize from exercise model
    _secondaryEngagements = {};
    final existingMap = widget.exercise.secondaryMuscleEngagement;
    for (final entry in existingMap.entries) {
      _secondaryEngagements[entry.key] = entry.value;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCardio = _selectedGroup == MuscleGroup.cardio;
    final isOther = _selectedGroup == MuscleGroup.other;

    return AlertDialog(
      title: const Text("Edit Exercise Template"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Exercise Name"),
                validator: (val) => val?.isEmpty == true ? "Required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MuscleGroup>(
                value: _selectedGroup,
                decoration: const InputDecoration(labelText: "Muscle Group"),
                items: MuscleGroup.values
                    .map(
                      (g) => DropdownMenuItem(
                        value: g,
                        child: Text(g.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedGroup = val;
                      _subGroupController.text = "";
                      // Reset flags based on group if changed
                      if (val == MuscleGroup.cardio) {
                        _trackWeightReps = false;
                        _trackDistance = true;
                        _trackSpeed = true;
                        _trackCalories = true;
                      } else {
                        _trackWeightReps = true;
                        _trackDistance = false;
                        _trackSpeed = false;
                        _trackCalories = false;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Sub Group Dropdown
              if (MuscleMetadata.subgroups[_selectedGroup]!.isNotEmpty)
                DropdownButtonFormField<String>(
                  value: _subGroupController.text.isEmpty
                      ? null
                      : _subGroupController.text,
                  decoration: const InputDecoration(
                    labelText: "Sub-group",
                    hintText: "Select target muscle area",
                  ),
                  items: MuscleMetadata.subgroups[_selectedGroup]!
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _subGroupController.text = val!),
                )
              else
                TextFormField(
                  controller: _subGroupController,
                  decoration: const InputDecoration(
                    labelText: "Sub-group (Optional)",
                  ),
                ),
              const SizedBox(height: 16),

              // Units & Attributes (Strength)
              if (!isCardio || isOther) ...[
                const Text(
                  "STRENGTH TRACKING",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 8),
                if (isOther)
                  _buildTrackingOptionSimple(
                    label: "Weight & Reps",
                    isActive: _trackWeightReps,
                    onToggle: (v) => setState(() => _trackWeightReps = v),
                  ),
                if (_trackWeightReps) ...[
                  DropdownButtonFormField<WeightUnit>(
                    value: _selectedUnit,
                    decoration: const InputDecoration(
                      labelText: "Default Weight Unit",
                    ),
                    items: WeightUnit.values.map((u) {
                      return DropdownMenuItem(
                        value: u,
                        child: Text(u.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedUnit = val!),
                  ),
                  SwitchListTile(
                    title: const Text("Isolate Left/Right?"),
                    value: _isIsolate,
                    onChanged: (val) => setState(() => _isIsolate = val),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SwitchListTile(
                    title: const Text("Cable Position?"),
                    value: _hasCablePosition,
                    onChanged: (val) => setState(() => _hasCablePosition = val),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  SwitchListTile(
                    title: const Text("Bench Position?"),
                    value: _hasBenchPosition,
                    onChanged: (val) => setState(() => _hasBenchPosition = val),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ],
                const SizedBox(height: 16),
              ],

              // Cardio tracking options
              if (isCardio || isOther) ...[
                const Text(
                  "ENDURANCE TRACKING",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTrackingOption(
                  label: "Distance",
                  isActive: _trackDistance,
                  onToggle: (v) => setState(() => _trackDistance = v),
                  unitValue: _distanceUnit,
                  units: ["meters", "km", "feet", "miles"],
                  onUnitChange: (v) => setState(() => _distanceUnit = v!),
                ),
                _buildTrackingOption(
                  label: "Speed",
                  isActive: _trackSpeed,
                  onToggle: (v) => setState(() => _trackSpeed = v),
                  unitValue: _speedUnit,
                  units: ["km/h", "mph", "m/s"],
                  onUnitChange: (v) => setState(() => _speedUnit = v!),
                ),
                _buildTrackingOption(
                  label: "Calories",
                  isActive: _trackCalories,
                  onToggle: (v) => setState(() => _trackCalories = v),
                  unitValue: _caloriesUnit,
                  units: ["cal", "kJ"],
                  onUnitChange: (v) => setState(() => _caloriesUnit = v!),
                ),
                const SizedBox(height: 16),
              ],
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Secondary Muscle Engagement (%)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ..._secondaryEngagements.entries.map((entry) {
                final parts = entry.key.split(':');
                final currentGroup = MuscleGroup.values.firstWhere(
                  (g) => g.name == parts[0],
                  orElse: () => MuscleGroup.chest,
                );
                final currentSub = parts.length > 1 ? parts[1] : "All";

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField<MuscleGroup>(
                              value: currentGroup,
                              decoration: const InputDecoration(
                                labelText: "Group",
                              ),
                              items: MuscleGroup.values
                                  .map(
                                    (g) => DropdownMenuItem(
                                      value: g,
                                      child: Text(g.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    final percent =
                                        _secondaryEngagements[entry.key];
                                    _secondaryEngagements.remove(entry.key);
                                    _secondaryEngagements[val.name] =
                                        percent ?? 30.0;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: entry.value.toStringAsFixed(0),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "%",
                                suffixText: "%",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _secondaryEngagements[entry.key] =
                                      double.tryParse(val) ?? 0.0;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                _secondaryEngagements.remove(entry.key);
                              });
                            },
                          ),
                        ],
                      ),
                      if (MuscleMetadata.subgroups[currentGroup]!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: DropdownButtonFormField<String>(
                            value: currentSub,
                            decoration: const InputDecoration(
                              labelText: "Target Area (Optional)",
                              isDense: true,
                            ),
                            items: [
                              const DropdownMenuItem(
                                value: "All",
                                child: Text("Entire Group"),
                              ),
                              ...MuscleMetadata.subgroups[currentGroup]!.map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  final percent =
                                      _secondaryEngagements[entry.key];
                                  _secondaryEngagements.remove(entry.key);
                                  final newKey = val == "All"
                                      ? currentGroup.name
                                      : "${currentGroup.name}:$val";
                                  _secondaryEngagements[newKey] =
                                      percent ?? 30.0;
                                });
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    final nextGroup = MuscleGroup.values.firstWhere(
                      (g) => !_secondaryEngagements.containsKey(g.name),
                      orElse: () => MuscleGroup.values.first,
                    );
                    _secondaryEngagements[nextGroup.name] = 30.0;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Secondary Muscle"),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Delete Exercise?"),
                content: const Text(
                  "This will remove the exercise from your library. Historical logs will remain but might show as 'Unknown'.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
            if (confirm == true && mounted) {
              await context.read<WorkoutCubit>().deleteExercise(
                widget.exercise.id,
              );
              widget.onAfterDelete?.call();
              Navigator.pop(context);
            }
          },
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(fontSize: 13)),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await context.read<WorkoutCubit>().updateExercise(
                    widget.exercise.id,
                    name: _nameController.text,
                    group: _selectedGroup,
                    subGroup: _subGroupController.text,
                    unit: _selectedUnit,
                    isIsolate: _isIsolate,
                    hasCablePosition: _hasCablePosition,
                    hasBenchPosition: _hasBenchPosition,
                    trackWeightReps: _trackWeightReps,
                    trackDistance: _trackDistance,
                    distanceUnit: _distanceUnit,
                    trackSpeed: _trackSpeed,
                    speedUnit: _speedUnit,
                    trackCalories: _trackCalories,
                    caloriesUnit: _caloriesUnit,
                    secondaryMuscleEngagement: Map<String, double>.from(
                      _secondaryEngagements,
                    ),
                  );
                  if (mounted) Navigator.pop(context);
                }
              },
              child: const Text("Save", style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackingOptionSimple({
    required String label,
    required bool isActive,
    required Function(bool) onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: isActive,
              onChanged: (v) => onToggle(v ?? false),
              activeColor: Colors.cyanAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white24,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingOption({
    required String label,
    required bool isActive,
    required Function(bool) onToggle,
    required String unitValue,
    required List<String> units,
    required Function(String?) onUnitChange,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: isActive,
              onChanged: (v) => onToggle(v ?? false),
              activeColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white24,
                fontSize: 13,
              ),
            ),
          ),
          if (isActive)
            Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: unitValue,
                underline: const SizedBox(),
                items: units
                    .map(
                      (u) => DropdownMenuItem(
                        value: u,
                        child: Text(u, style: const TextStyle(fontSize: 11)),
                      ),
                    )
                    .toList(),
                onChanged: onUnitChange,
              ),
            ),
        ],
      ),
    );
  }
}
