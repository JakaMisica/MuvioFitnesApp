import 'package:flutter/material.dart';

class ProfileDialog extends StatefulWidget {
  final String? initialGender;
  final int? initialAge;
  final double? initialHeightCm;
  final bool initialIsMetric;

  const ProfileDialog({
    super.key,
    this.initialGender,
    this.initialAge,
    this.initialHeightCm,
    required this.initialIsMetric,
  });

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  late String _gender;
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late bool _isMetric;

  @override
  void initState() {
    super.initState();
    _gender = widget.initialGender ?? 'male';
    _ageController = TextEditingController(
      text: (widget.initialAge ?? 25).toString(),
    );
    _isMetric = widget.initialIsMetric;

    double h = widget.initialHeightCm ?? 175.0;
    if (!_isMetric) {
      // CM to Inches for display
      _heightController = TextEditingController(
        text: (h / 2.54).toStringAsFixed(1),
      );
    } else {
      _heightController = TextEditingController(text: h.toStringAsFixed(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        constraints: const BoxConstraints(maxWidth: 450),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.08),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Biometric Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Used for high-precision metabolism and hormonal estimation.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 32),

            // Gender Selector
            _buildLabel('GENDER'),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildGenderButton('male', Icons.male),
                const SizedBox(width: 12),
                _buildGenderButton('female', Icons.female),
              ],
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(flex: 2, child: _buildInput('AGE', _ageController)),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('HEIGHT'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _heightController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  double val =
                                      double.tryParse(_heightController.text) ??
                                      175;
                                  if (_isMetric) {
                                    // CM to IN
                                    _heightController.text = (val / 2.54)
                                        .toStringAsFixed(1);
                                  } else {
                                    // IN to CM
                                    _heightController.text = (val * 2.54)
                                        .toStringAsFixed(1);
                                  }
                                  _isMetric = !_isMetric;
                                });
                              },
                              child: Text(
                                _isMetric ? 'CM' : 'IN',
                                style: TextStyle(
                                  color: Colors.blueAccent.shade100,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'INITIALIZE PROFILE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildGenderButton(String value, IconData icon) {
    bool isSelected = _gender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blueAccent.withOpacity(0.15)
                : Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Colors.blueAccent
                  : Colors.white.withOpacity(0.05),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blueAccent : Colors.grey),
              const SizedBox(height: 8),
              Text(
                value.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller, {
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixText: suffix,
              suffixStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  void _submit() {
    final age = int.tryParse(_ageController.text) ?? 25;
    double hVal = double.tryParse(_heightController.text) ?? 175;

    double hCm = hVal;
    if (!_isMetric) {
      hCm = hVal * 2.54;
    }

    Navigator.pop(context, {
      'gender': _gender,
      'age': age,
      'heightCm': hCm,
      'isMetric': _isMetric,
    });
  }
}
