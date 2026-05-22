import 'package:flutter/material.dart';
import '../../../../data/models/enums.dart';
import '../../../../data/models/muscle_metadata.dart';
import '../../../widgets/flip_image_carousel.dart';

class ExerciseCreatorDialog extends StatefulWidget {
  final String initialName;
  const ExerciseCreatorDialog({super.key, this.initialName = ''});

  @override
  State<ExerciseCreatorDialog> createState() => _ExerciseCreatorDialogState();
}

class _ExerciseCreatorDialogState extends State<ExerciseCreatorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subGroupController = TextEditingController();
  String? _selectedGlutePart;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
  }

  MuscleGroup _selectedGroup = MuscleGroup.chest;
  WeightUnit _selectedUnit = WeightUnit.kg;
  bool _isIsolate = false;
  bool _hasCablePosition = false;
  bool _hasBenchPosition = false;

  // New tracking flags
  bool _trackWeightReps = true;
  bool _trackDistance = false;
  String _distanceUnit = "km";
  bool _trackSpeed = false;
  String _speedUnit = "km/h";
  bool _trackCalories = false;
  String _caloriesUnit = "kJ";

  final Map<String, double> _secondaryEngagements = {};

  @override
  Widget build(BuildContext context) {
    final isCardio = _selectedGroup == MuscleGroup.cardio;
    final isOther = _selectedGroup == MuscleGroup.other;

    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.fitness_center),
          SizedBox(width: 8),
          Text("Create Exercise"),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exercise Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Exercise Name",
                  hintText: "e.g. Bench Press or Running",
                ),
                validator: (val) => val?.isEmpty == true ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Muscle Group selection
              DropdownButtonFormField<MuscleGroup>(
                value: _selectedGroup,
                decoration: const InputDecoration(labelText: "Muscle Group"),
                items: MuscleGroup.values.map((g) {
                  return DropdownMenuItem(
                    value: g,
                    child: Text(g.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedGroup = val;
                      _subGroupController.text = "";
                      // Reset flags based on group
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

              // Sub-group selection
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
                    hintText: "e.g. Upper Chest",
                  ),
                ),
              const SizedBox(height: 16),

              // Nested Glute Part selection
              if (_subGroupController.text == 'Glutes' && _selectedGroup == MuscleGroup.legs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DropdownButtonFormField<String>(
                    value: _selectedGlutePart,
                    decoration: const InputDecoration(
                      labelText: "Specific Glute Area",
                      hintText: "Optional detailed targeting",
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text("All Glutes")),
                      ...MuscleMetadata.gluteParts.map((s) => DropdownMenuItem(value: s, child: Text(s))),
                    ],
                    onChanged: (val) => setState(() => _selectedGlutePart = val),
                  ),
                ),

              // Image Preview
              FlipImageCarousel(
                imagePath: MuscleMetadata.getMuscleImagePath(_selectedGroup, _subGroupController.text),
                height: 150,
                width: double.infinity,
              ),

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
                    // Find first group not already in map
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
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(fontSize: 13)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Return new exercise data to caller
              final result = {
                'name': _nameController.text,
                'muscleGroup': _selectedGroup,
                'subGroup': _subGroupController.text == 'Glutes' && _selectedGlutePart != null 
                    ? "Glutes ($_selectedGlutePart)" 
                    : _subGroupController.text,
                'unit': _selectedUnit,
                'isIsolate': _isIsolate,
                'hasCablePosition': _hasCablePosition,
                'hasBenchPosition': _hasBenchPosition,
                'trackWeightReps': _trackWeightReps,
                'trackDistance': _trackDistance,
                'distanceUnit': _distanceUnit,
                'trackSpeed': _trackSpeed,
                'speedUnit': _speedUnit,
                'trackCalories': _trackCalories,
                'caloriesUnit': _caloriesUnit,
                'secondaryMuscleEngagement': _secondaryEngagements,
              };
              Navigator.pop(context, result);
            }
          },
          child: const Text("Create", style: TextStyle(fontSize: 13)),
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
