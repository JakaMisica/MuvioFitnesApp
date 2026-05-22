import 'package:flutter/material.dart';

class GripStrengthDialog extends StatefulWidget {
  final double? initialLeft;
  final double? initialRight;
  final bool initialUseKg;

  const GripStrengthDialog({
    super.key,
    this.initialLeft,
    this.initialRight,
    required this.initialUseKg,
  });

  @override
  State<GripStrengthDialog> createState() => _GripStrengthDialogState();
}

class _GripStrengthDialogState extends State<GripStrengthDialog> {
  late final TextEditingController _leftController;
  late final TextEditingController _rightController;
  late bool _useKg;

  @override
  void initState() {
    super.initState();
    _useKg = widget.initialUseKg;
    _leftController = TextEditingController(
      text: widget.initialLeft?.toStringAsFixed(1) ?? '',
    );
    _rightController = TextEditingController(
      text: widget.initialRight?.toStringAsFixed(1) ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.05),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Grip Strength',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                // KG/LBS Toggle
                GestureDetector(
                  onTap: () {
                    setState(() {
                      double l = double.tryParse(_leftController.text) ?? 0;
                      double r = double.tryParse(_rightController.text) ?? 0;
                      if (_useKg) {
                        _leftController.text = (l / 0.453592).toStringAsFixed(
                          1,
                        );
                        _rightController.text = (r / 0.453592).toStringAsFixed(
                          1,
                        );
                      } else {
                        _leftController.text = (l * 0.453592).toStringAsFixed(
                          1,
                        );
                        _rightController.text = (r * 0.453592).toStringAsFixed(
                          1,
                        );
                      }
                      _useKg = !_useKg;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Text(
                      _useKg ? 'METRIC (KG)' : 'IMPERIAL (LBS)',
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _buildInput(
                    'LEFT ARM',
                    _leftController,
                    _useKg ? 'KG' : 'LBS',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInput(
                    'RIGHT ARM',
                    _rightController,
                    _useKg ? 'KG' : 'LBS',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final left = double.tryParse(_leftController.text);
                      final right = double.tryParse(_rightController.text);
                      if (left != null && right != null) {
                        Navigator.pop(context, {
                          'left': left,
                          'right': right,
                          'useKg': _useKg,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent.shade400,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'SAVE DATA',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller,
    String unit,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixText: unit,
              suffixStyle: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }
}
