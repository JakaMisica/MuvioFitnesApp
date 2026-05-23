import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeasurementsDialog extends StatefulWidget {
  final Map<String, double?> initialValues;
  final Map<String, double> changes;
  final bool initialIsMetric;

  const MeasurementsDialog({
    super.key,
    required this.initialValues,
    this.changes = const {},
    this.initialIsMetric = true,
  });

  @override
  State<MeasurementsDialog> createState() => _MeasurementsDialogState();
}

class _MeasurementsDialogState extends State<MeasurementsDialog> {
  late Map<String, TextEditingController> _controllers;
  late bool _isMetric;

  final List<Map<String, String>> _fields = [
    {'key': 'neck', 'label': 'Neck'},
    {'key': 'chest', 'label': 'Chest'},
    {'key': 'waist', 'label': 'Waist'},
    {'key': 'hips', 'label': 'Hips'},
    {'key': 'leftArm', 'label': 'L Arm'},
    {'key': 'rightArm', 'label': 'R Arm'},
    {'key': 'leftForearm', 'label': 'L Forearm'},
    {'key': 'rightForearm', 'label': 'R Forearm'},
    {'key': 'leftThigh', 'label': 'L Thigh'},
    {'key': 'rightThigh', 'label': 'R Thigh'},
    {'key': 'leftCalf', 'label': 'L Calf'},
    {'key': 'rightCalf', 'label': 'R Calf'},
  ];

  @override
  void initState() {
    super.initState();
    _isMetric = widget.initialIsMetric;
    _controllers = {};
    for (var field in _fields) {
      final key = field['key']!;
      final value = widget.initialValues[key];

      String text = '';
      if (value != null) {
        if (_isMetric) {
          text = value.toStringAsFixed(1);
        } else {
          text = (value / 2.54).toStringAsFixed(1);
        }
      }

      _controllers[key] = TextEditingController(text: text);
    }
  }

  void _toggleUnit() {
    setState(() {
      _isMetric = !_isMetric;
      for (var entry in _controllers.entries) {
        final val = double.tryParse(entry.value.text);
        if (val != null) {
          if (_isMetric) {
            // Inches to CM
            entry.value.text = (val * 2.54).toStringAsFixed(1);
          } else {
            // CM to Inches
            entry.value.text = (val / 2.54).toStringAsFixed(1);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 440,
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.05),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const Icon(
                    Icons.straighten,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    child: Text(
                      'BODY MEASUREMENTS',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Unit Switcher
                  GestureDetector(
                    onTap: _toggleUnit,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        _isMetric ? 'CM' : 'IN',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white24,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _fields.length,
                  itemBuilder: (context, index) {
                    final field = _fields[index];
                    return _buildInputField(field['key']!, field['label']!);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final results = <String, double>{};

                    _controllers.forEach((key, controller) {
                      final val = double.tryParse(controller.text);
                      if (val != null) {
                        if (_isMetric) {
                          results[key] = val;
                        } else {
                          // Save as CM (Inches * 2.54)
                          results[key] = val * 2.54;
                        }
                      }
                    });

                    Navigator.pop(context, {
                      'values': results,
                      'isMetric': _isMetric,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SAVE METRICS',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String key, String label) {
    final controller = _controllers[key]!;
    final change = widget.changes[key];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white24,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (change != null && change != 0)
              Text(
                '${change > 0 ? "+" : ""}${_isMetric ? change.toStringAsFixed(1) : (change / 2.54).toStringAsFixed(1)}${_isMetric ? "cm" : "in"}',
                style: TextStyle(
                  color: change > 0 ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onTap: () {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            isDense: true,
            suffixText: _isMetric ? 'cm' : 'in',
            suffixStyle: const TextStyle(color: Colors.white24, fontSize: 10),
            filled: true,
            fillColor: Colors.white.withOpacity(0.03),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
