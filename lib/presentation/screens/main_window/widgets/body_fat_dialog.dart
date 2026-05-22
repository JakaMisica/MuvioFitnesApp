import 'package:flutter/material.dart';

class BodyFatDialog extends StatefulWidget {
  final double? initialPercentage;
  final int age;
  final String gender;
  final double weight;

  const BodyFatDialog({
    super.key,
    this.initialPercentage,
    required this.age,
    required this.gender,
    required this.weight,
  });

  @override
  State<BodyFatDialog> createState() => _BodyFatDialogState();
}

class _BodyFatDialogState extends State<BodyFatDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _estimatedController = TextEditingController();
  final _dexaController = TextEditingController();

  // Caliper selection
  int _caliperMethod = 0; // 0: 3rd, 1: 7th, 2: 9th

  // Caliper controllers
  final _chestController = TextEditingController();
  final _absController = TextEditingController();
  final _thighController = TextEditingController();
  final _tricepController = TextEditingController();
  final _suprailiacController = TextEditingController();
  final _subscapularController = TextEditingController();
  final _midaxillaryController = TextEditingController();
  final _bicepController = TextEditingController();
  final _lowerBackController = TextEditingController();
  final _calfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _estimatedController.text =
        widget.initialPercentage?.toStringAsFixed(1) ?? '';
    _dexaController.text = widget.initialPercentage?.toStringAsFixed(1) ?? '';

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.05),
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
                  'BODY FAT ANALYSIS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Reduced from 20
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTabSelector(),
            const SizedBox(height: 28),
            SizedBox(
              height: 380, // Increased from 340 to provide more breathing room
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEstimateTab(),
                  _buildDexaTab(),
                  _buildCaliperTab(),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        dividerColor: Colors.transparent,
        labelColor: Colors.orangeAccent,
        unselectedLabelColor: Colors.grey.shade500,
        tabs: const [
          Tab(text: 'VISUAL'),
          Tab(text: 'DEXA'),
          Tab(text: 'CALIPER'),
        ],
      ),
    );
  }

  Widget _buildEstimateTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Visual Estimation',
          'Quick updates via comparison.',
        ),
        const SizedBox(height: 12),
        _buildStyledInput(
          'Current Body Fat %',
          _estimatedController,
          suffix: '%',
        ),
      ],
    );
  }

  Widget _buildDexaTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'DEXA Scan',
          'Clinical accuracy from medical reports.',
        ),
        const SizedBox(height: 12),
        _buildStyledInput('DEXA Body Fat %', _dexaController, suffix: '%'),
      ],
    );
  }

  Widget _buildCaliperTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildSectionHeader(
                  'Caliper Method',
                  'Skinfold measurements',
                ),
              ),
              _buildCaliperMethodSelector(),
            ],
          ),
          const SizedBox(height: 24),
          _buildCaliperFields(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildCaliperMethodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildMethodChip(0, '3rd'),
          _buildMethodChip(1, '7th'),
          _buildMethodChip(2, '9th'),
        ],
      ),
    );
  }

  Widget _buildMethodChip(int index, String label) {
    final isSelected = _caliperMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _caliperMethod = index),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ), // Reduced padding
        decoration: BoxDecoration(
          color: isSelected ? Colors.orangeAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontSize: 9, // Reduced font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCaliperFields() {
    final fields = _getFieldsForMethod();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            4.2, // Slightly increased for even tighter vertical fit
        crossAxisSpacing: 10,
        mainAxisSpacing: 8, // Reduced from 10
      ),
      itemCount: fields.length,
      itemBuilder: (context, index) {
        final field = fields[index];
        return _buildStyledInput(field.label, field.controller, suffix: 'mm');
      },
    );
  }

  List<_Field> _getFieldsForMethod() {
    switch (_caliperMethod) {
      case 0: // 3-site
        if (widget.gender == 'male') {
          return [
            _Field('Chest', _chestController),
            _Field('Abs', _absController),
            _Field('Thigh', _thighController),
          ];
        } else {
          return [
            _Field('Tricep', _tricepController),
            _Field('Thigh', _thighController),
            _Field('Suprailiac', _suprailiacController),
          ];
        }
      case 1: // 7-site
        return [
          _Field('Chest', _chestController),
          _Field('Abs', _absController),
          _Field('Thigh', _thighController),
          _Field('Tricep', _tricepController),
          _Field('Subscapula', _subscapularController),
          _Field('Suprailiac', _suprailiacController),
          _Field('Midaxilla', _midaxillaryController),
        ];
      case 2: // 9-site (Parillo)
        return [
          _Field('Chest', _chestController),
          _Field('Abs', _absController),
          _Field('Thigh', _thighController),
          _Field('Tricep', _tricepController),
          _Field('Subscapula', _subscapularController),
          _Field('Suprailiac', _suprailiacController),
          _Field('Bicep', _bicepController),
          _Field('Calf', _calfController),
          _Field('Lower Back', _lowerBackController),
        ];
      default:
        return [];
    }
  }

  Widget _buildStyledInput(
    String label,
    TextEditingController controller, {
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2), // Reduced from 3
        Container(
          height: 34, // Reduced from 38
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8), // Even smaller radius
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12, // Reduced from 13
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 6,
              ), // Reduced from 8
              border: InputBorder.none,
              suffixText: suffix,
              suffixStyle: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 10,
              ), // Reduced from 11
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
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
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'SAVE DATA',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ],
    );
  }

  void _submit() {
    final method = _tabController.index;
    double? result;

    if (method == 0) {
      result = double.tryParse(_estimatedController.text);
    } else if (method == 1) {
      result = double.tryParse(_dexaController.text);
    } else if (method == 2) {
      // CALIPER
      final sum = _getSum();
      if (sum > 0) {
        if (_caliperMethod == 0 || _caliperMethod == 1) {
          // Jackson-Pollock
          double bd;
          if (_caliperMethod == 0) {
            // 3-site
            if (widget.gender == 'male') {
              bd =
                  1.10938 -
                  (0.0008267 * sum) +
                  (0.0000016 * sum * sum) -
                  (0.0002574 * widget.age);
            } else {
              bd =
                  1.0994921 -
                  (0.0009929 * sum) +
                  (0.0000023 * sum * sum) -
                  (0.0001392 * widget.age);
            }
          } else {
            // 7-site
            if (widget.gender == 'male') {
              bd =
                  1.112 -
                  (0.00043499 * sum) +
                  (0.00000055 * sum * sum) -
                  (0.00028826 * widget.age);
            } else {
              bd =
                  1.097 -
                  (0.00046971 * sum) +
                  (0.00000056 * sum * sum) -
                  (0.00012828 * widget.age);
            }
          }
          result = (495 / bd) - 450;
        } else {
          // 9-site (Parillo)
          // Result = (27 * Sum) / Bodyweight (lbs)
          double weightLbs = widget.weight * 2.20462;
          result = (27 * sum) / weightLbs;
        }
      }
    }

    if (result != null) {
      Navigator.pop(context, {
        'percentage': result,
        'method': method,
        'chest': double.tryParse(_chestController.text),
        'abs': double.tryParse(_absController.text),
        'thigh': double.tryParse(_thighController.text),
        'tricep': double.tryParse(_tricepController.text),
        'subscapular': double.tryParse(_subscapularController.text),
        'suprailiac': double.tryParse(_suprailiacController.text),
        'midaxillary': double.tryParse(_midaxillaryController.text),
        'bicep': double.tryParse(_bicepController.text),
        'lowerBack': double.tryParse(_lowerBackController.text),
        'calf': double.tryParse(_calfController.text),
      });
    }
  }

  double _getSum() {
    double total = 0;
    final fields = _getFieldsForMethod();
    for (var f in fields) {
      total += double.tryParse(f.controller.text) ?? 0;
    }
    return total;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _estimatedController.dispose();
    _dexaController.dispose();
    _chestController.dispose();
    _absController.dispose();
    _thighController.dispose();
    _tricepController.dispose();
    _suprailiacController.dispose();
    _subscapularController.dispose();
    _midaxillaryController.dispose();
    _bicepController.dispose();
    _lowerBackController.dispose();
    _calfController.dispose();
    super.dispose();
  }
}

class _Field {
  final String label;
  final TextEditingController controller;
  _Field(this.label, this.controller);
}
