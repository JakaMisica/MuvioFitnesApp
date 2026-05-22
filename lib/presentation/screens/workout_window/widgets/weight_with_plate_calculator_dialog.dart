import 'package:flutter/material.dart';
import 'plate_calculator_dialog.dart';
import 'value_input_dialog.dart';
import '../../../../data/models/enums.dart';

class WeightWithPlateCalculatorDialog extends StatefulWidget {
  final double initialValue;
  final String unit;
  final double increment;
  final int exerciseId;
  final Function(double)? onIncrementChanged;

  const WeightWithPlateCalculatorDialog({
    super.key,
    required this.initialValue,
    required this.unit,
    required this.increment,
    required this.exerciseId,
    this.onIncrementChanged,
  });

  @override
  State<WeightWithPlateCalculatorDialog> createState() =>
      _WeightWithPlateCalculatorDialogState();
}

class _WeightWithPlateCalculatorDialogState
    extends State<WeightWithPlateCalculatorDialog> {
  late double _currentWeight;

  @override
  void initState() {
    super.initState();
    _currentWeight = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final weightUnit = widget.unit.toLowerCase().contains('lb')
        ? WeightUnit.lbs
        : WeightUnit.kg;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Dim
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black54),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Upper Window: Plate Calculator
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: PlateCalculatorDialog(
                      initialTotalWeight: _currentWeight,
                      unit: weightUnit,
                      exerciseId: widget.exerciseId,
                      onWeightChanged: (newWeight) {
                        setState(() => _currentWeight = newWeight);
                      },
                      isEmbedded: true,
                    ),
                  ),

                  const SizedBox(height: 4), // Shrunk from 12
                  // Lower Window: Value Input
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: 400,
                    child: ValueInputDialog(
                      title: 'Weight',
                      initialValue: _currentWeight,
                      unit: widget.unit,
                      defaultIncrement: widget.increment,
                      onIncrementChanged: widget.onIncrementChanged,
                      onChanged: (newVal) {
                        setState(() => _currentWeight = newVal);
                      },
                      showDelete: false,
                      isEmbedded: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
