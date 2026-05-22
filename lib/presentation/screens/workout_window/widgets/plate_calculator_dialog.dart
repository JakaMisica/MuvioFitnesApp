import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../data/models/enums.dart';

class PlateCalculatorDialog extends StatefulWidget {
  final double initialTotalWeight;
  final WeightUnit unit;
  final int exerciseId;
  final Function(double) onWeightChanged;
  final bool isEmbedded;

  const PlateCalculatorDialog({
    super.key,
    required this.initialTotalWeight,
    required this.unit,
    required this.exerciseId,
    required this.onWeightChanged,
    this.isEmbedded = false,
  });

  @override
  State<PlateCalculatorDialog> createState() => _PlateCalculatorDialogState();
}

class _PlateCalculatorDialogState extends State<PlateCalculatorDialog> {
  late double _totalWeight;
  late double _barWeight;
  late Map<double, int> _inventory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _totalWeight = widget.initialTotalWeight;
    _loadSettings();
  }

  @override
  void didUpdateWidget(PlateCalculatorDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTotalWeight != widget.initialTotalWeight) {
      setState(() {
        _totalWeight = widget.initialTotalWeight;
      });
    }
  }

  Future<void> _loadSettings() async {
    try {
      final cubit = context.read<WorkoutCubit>();
      final settings = await cubit.getUserSettings();
      final weightUnit = widget.unit;

      // Determine default bar weight based on unit
      double barWeight = weightUnit == WeightUnit.kg ? 20.0 : 45.0;

      // Find exercise-specific bar weight from the database directly if possible
      // to ensure we get the most up-to-date persisted value.
      final allExercises = await cubit.getAllExercises();
      final exercise = allExercises.firstWhereOrNull(
        (e) => e.id == widget.exerciseId,
      );

      if (exercise != null && exercise.barbellWeight > 0) {
        barWeight = exercise.barbellWeight;
      }

      if (mounted) {
        setState(() {
          _barWeight = barWeight;
          final plateStrings = weightUnit == WeightUnit.kg
              ? settings.availableKgPlates
              : settings.availableLbsPlates;

          _inventory = {};
          if (plateStrings.isEmpty) {
            // Default fallback
            final defaults = weightUnit == WeightUnit.kg
                ? [25.0, 20.0, 15.0, 10.0, 5.0, 2.5, 1.25]
                : [45.0, 35.0, 25.0, 10.0, 5.0, 2.5];
            for (var d in defaults) {
              _inventory[d] = 10;
            }
          } else {
            for (var s in plateStrings) {
              final parts = s.split(':');
              if (parts.length == 2) {
                final w = double.tryParse(parts[0]);
                final c = int.tryParse(parts[1]);
                if (w != null && c != null) {
                  _inventory[w] = c;
                }
              } else {
                // Backward compatibility just in case
                final w = double.tryParse(s);
                if (w != null) _inventory[w] = 10;
              }
            }
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading plate calculator settings: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _barWeight = widget.unit == WeightUnit.kg ? 20.0 : 45.0;
          final defaults = widget.unit == WeightUnit.kg
              ? [25.0, 20.0, 15.0, 10.0, 5.0, 2.5, 1.25]
              : [45.0, 35.0, 25.0, 10.0, 5.0, 2.5];
          _inventory = {for (var v in defaults) v: 10};
        });
      }
    }
  }

  List<double> _calculatePlates() {
    double remaining = (_totalWeight - _barWeight) / 2;
    if (remaining <= 0) return [];

    List<double> result = [];
    // Work with a copy of inventory because each side needs the same plates
    // So if we have 4x20kg total, each side can use up to 2x20kg.
    final workingInventory = Map<double, int>.from(_inventory);

    List<double> sortedPlates = workingInventory.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    for (var plate in sortedPlates) {
      int availableTotal = workingInventory[plate] ?? 0;
      // We need it for both sides, so 1 per side = 2 total
      while (availableTotal >= 2 && (remaining - plate) >= -0.001) {
        result.add(plate);
        remaining -= plate;
        availableTotal -= 2;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    final plates = _calculatePlates();
    final isKg = widget.unit == WeightUnit.kg;
    final otherUnitWeight = isKg
        ? _totalWeight * 2.20462
        : _totalWeight / 2.20462;
    final otherUnitLabel = isKg ? "lbs" : "kg";

    final widgetContent = Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: widget.isEmbedded
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barbell Visualization
          SizedBox(
            height: 160, // Premium airy height
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Header (Top 32 for better balance)
                Positioned(
                  top: 32,
                  child: Column(
                    children: [
                      Text(
                        _totalWeight.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${isKg ? 'KG' : 'LBS'} (${otherUnitWeight.toStringAsFixed(1)} $otherUnitLabel)",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white38,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bar (Bottom 80)
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade800,
                          Colors.grey.shade400,
                          Colors.grey.shade800,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Center Box (Centered on bar)
                Positioned(
                  bottom: 68,
                  child: Container(
                    width: 90,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF252525),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "BAR",
                            style: TextStyle(
                              fontSize: 5,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _barWeight.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Plates (Fixed height 100, positioned at bottom 32)
                // Bar center is at 80 + 2 = 82 from bottom
                // Container height 100 positioned at bottom 32 means center at 32 + 50 = 82
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left side (End aligned, reversed)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: plates.reversed
                                .map((p) => _buildPlate(p, false))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 92), // Center gap
                        // Right side (Start aligned)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: plates
                                .map((p) => _buildPlate(p, true))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          // Plate Legend
          (() {
            final calculatedTotal = _barWeight + (plates.sum * 2);
            final isMatch = (calculatedTotal - _totalWeight).abs() < 0.001;
            if (!isMatch) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Exact match impossible with current plates.\nShowing closest match: ${calculatedTotal.toStringAsFixed(2)} ${isKg ? 'KG' : 'LBS'}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          })(),

          if (plates.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    "Each side:",
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  ...plates.toSet().map((p) {
                    int count = plates.where((x) => x == p).length;
                    return Text(
                      "$count x $p",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.cyanAccent,
                      ),
                    );
                  }),
                ],
              ),
            ),

          const SizedBox(height: 16),
          // Controls
          Row(
            children: [
              Expanded(
                child: _buildControlTile(
                  "Barbell",
                  "${_barWeight.toStringAsFixed(1)} ${isKg ? 'KG' : 'LBS'}",
                  _showBarWeightPicker,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildControlTile(
                  "Equipment",
                  "Available\nPlates",
                  () => _showAvailablePlatesPicker(),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (widget.isEmbedded) {
      return widgetContent;
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: widgetContent,
    );
  }

  Widget _buildPlate(double weight, bool isRight) {
    // Progressive sizing based on weight
    // For kg: reference 5kg as base, for lbs: reference 10lbs as base
    final isKg = widget.unit == WeightUnit.kg;
    final baseWeight = isKg ? 5.0 : 10.0;

    double height;
    double width;

    if (weight <= baseWeight) {
      // Lighter plates scale proportionally (smaller)
      // Min height 20px, scales up to 60px at base weight
      height = 20 + (weight / baseWeight) * 40;
      width = 6 + (weight / baseWeight) * 6;
    } else {
      // Heavier plates continue to scale
      // Start at 60px for base weight, add more for heavier
      final excessWeight = weight - baseWeight;
      height = 60 + (excessWeight * 1.5).clamp(0.0, 40.0);
      width = 12 + (excessWeight / 5).clamp(0.0, 8.0);
    }

    Color color = _getPlateColor(weight);

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );
  }

  Color _getPlateColor(double weight) {
    // All colors are fully opaque (no transparency)
    if (widget.unit == WeightUnit.kg) {
      if (weight >= 25) return Colors.red;
      if (weight >= 20) return Colors.blue;
      if (weight >= 15) return Colors.yellow.shade700;
      if (weight >= 10) return Colors.green;
      if (weight >= 5) return Colors.lightGreen;
      if (weight >= 2.5) return Colors.cyan;
      if (weight >= 1.25) return Colors.lightGreen.shade300;
      return Colors.grey.shade400; // For very light custom plates
    } else {
      // For lbs
      if (weight >= 45) return Colors.blue;
      if (weight >= 35) return Colors.yellow.shade700;
      if (weight >= 25) return Colors.green;
      if (weight >= 10) return Colors.lightGreen;
      if (weight >= 5) return Colors.cyan;
      if (weight >= 2.5) return Colors.lightGreen.shade300;
      return Colors.grey.shade400; // For very light custom plates
    }
  }

  Widget _buildControlTile(String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.white38),
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showBarWeightPicker() {
    final cubit = context.read<WorkoutCubit>(); // Capture cubit
    final controller = TextEditingController(text: _barWeight.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          "Barbell Weight",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixText: widget.unit == WeightUnit.kg ? "kg" : "lbs",
            suffixStyle: const TextStyle(color: Colors.white60),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
          ),
          autofocus: true,
          onTap: () {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(controller.text);
              if (val != null) {
                setState(() => _barWeight = val);
                cubit.updateBarbellWeight(widget.exerciseId, val);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showAvailablePlatesPicker() {
    final cubit = context.read<WorkoutCubit>();
    final isKg = widget.unit == WeightUnit.kg;
    final standardPlates = isKg
        ? [25.0, 20.0, 15.0, 10.0, 5.0, 2.5, 1.25, 0.5]
        : [45.0, 35.0, 25.0, 10.0, 5.0, 2.5, 1.25];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final allOptions = {...standardPlates, ..._inventory.keys}.toList();
            allOptions.sort((a, b) => b.compareTo(a));

            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Available Plates",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.cyanAccent),
                    onPressed: () async {
                      final customController = TextEditingController();
                      final customResult = await showDialog<double>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: const Color(0xFF2C2C2C),
                          title: const Text(
                            "Add New Plate",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: TextField(
                            controller: customController,
                            autofocus: true,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Enter weight...",
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(
                                ctx,
                                double.tryParse(customController.text),
                              ),
                              child: const Text("Add"),
                            ),
                          ],
                        ),
                      );
                      if (customResult != null && customResult > 0) {
                        setDialogState(() {
                          if (!_inventory.containsKey(customResult)) {
                            _inventory[customResult] = 10;
                          }
                        });
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: 320,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: allOptions.length,
                  itemBuilder: (context, index) {
                    final plate = allOptions[index];
                    final count = _inventory[plate] ?? 0;
                    final isSelected = count > 0;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: isSelected,
                        activeColor: Colors.cyanAccent,
                        checkColor: Colors.black,
                        onChanged: (bool? value) {
                          setDialogState(() {
                            if (value == true) {
                              _inventory[plate] = 10;
                            } else {
                              _inventory[plate] = 0;
                            }
                          });
                          setState(() {});
                        },
                      ),
                      title: Text(
                        "$plate ${isKg ? 'kg' : 'lbs'}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 18,
                              color: Colors.white38,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              if (count > 0) {
                                setDialogState(() {
                                  _inventory[plate] = count - 1;
                                });
                                setState(() {});
                              }
                            },
                          ),
                          SizedBox(
                            width: 24,
                            child: Text(
                              count.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 18,
                              color: Colors.white38,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setDialogState(() {
                                _inventory[plate] = count + 1;
                              });
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    // Save to settings after closing
                    final settings = await cubit.getUserSettings();
                    final plateStrings = _inventory.entries
                        .where((e) => e.value > 0)
                        .map((e) => "${e.key}:${e.value}")
                        .toList();

                    if (isKg) {
                      settings.availableKgPlates = plateStrings;
                    } else {
                      settings.availableLbsPlates = plateStrings;
                    }
                    await cubit.updateUserSettings(settings);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.cyanAccent),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
