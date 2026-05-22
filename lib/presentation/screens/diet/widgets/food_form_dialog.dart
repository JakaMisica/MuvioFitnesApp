import 'package:flutter/material.dart';
import '../../../../data/models/diet_models.dart';
import '../../../../data/repositories/diet_repository.dart';
import '../../../../locator.dart';
import 'barcode_scanner_view.dart';

class FoodFormDialog extends StatefulWidget {
  const FoodFormDialog({super.key});

  @override
  State<FoodFormDialog> createState() => _FoodFormDialogState();
}

class _FoodFormDialogState extends State<FoodFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _calController = TextEditingController(text: "0");
  final _proController = TextEditingController(text: "0");
  final _carbController = TextEditingController(text: "0");
  final _fatController = TextEditingController(text: "0");

  final Map<String, TextEditingController> _controllers = {};

  final List<Map<String, dynamic>> _vitamins = [
    {'label': 'Vit A (µg)', 'key': 'vitA'},
    {'label': 'Vit C (mg)', 'key': 'vitC'},
    {'label': 'Vit D (µg)', 'key': 'vitD'},
    {'label': 'Vit E (mg)', 'key': 'vitE'},
    {'label': 'Vit K (µg)', 'key': 'vitK'},
    {'label': 'Thiamine B1 (mg)', 'key': 'thiamine'},
    {'label': 'Riboflavin B2 (mg)', 'key': 'riboflavin'},
    {'label': 'Niacin B3 (mg)', 'key': 'niacin'},
    {'label': 'Pantothenic B5 (mg)', 'key': 'pantothenicAcid'},
    {'label': 'Vit B6 (mg)', 'key': 'vitB6'},
    {'label': 'Biotin B7 (µg)', 'key': 'biotin'},
    {'label': 'Folate B9 (µg)', 'key': 'folate'},
    {'label': 'Vit B12 (µg)', 'key': 'vitB12'},
    {'label': 'Choline (mg)', 'key': 'choline'},
  ];

  final List<Map<String, dynamic>> _minerals = [
    {'label': 'Calcium (mg)', 'key': 'calcium'},
    {'label': 'Iron (mg)', 'key': 'iron'},
    {'label': 'Magnesium (mg)', 'key': 'magnesium'},
    {'label': 'Phosphorus (mg)', 'key': 'phosphorus'},
    {'label': 'Potassium (mg)', 'key': 'potassium'},
    {'label': 'Sodium (mg)', 'key': 'sodium'},
    {'label': 'Zinc (mg)', 'key': 'zinc'},
    {'label': 'Copper (mg)', 'key': 'copper'},
    {'label': 'Manganese (mg)', 'key': 'manganese'},
    {'label': 'Selenium (µg)', 'key': 'selenium'},
    {'label': 'Iodine (µg)', 'key': 'iodine'},
  ];

  final List<Map<String, dynamic>> _essentialAminos = [
    {'label': 'Leucine (g)', 'key': 'leucine'},
    {'label': 'Isoleucine (g)', 'key': 'isoleucine'},
    {'label': 'Valine (g)', 'key': 'valine'},
    {'label': 'Lysine (g)', 'key': 'lysine'},
    {'label': 'Methionine (g)', 'key': 'methionine'},
    {'label': 'Phenylalanine (g)', 'key': 'phenylalanine'},
    {'label': 'Threonine (g)', 'key': 'threonine'},
    {'label': 'Tryptophan (g)', 'key': 'tryptophan'},
    {'label': 'Histidine (g)', 'key': 'histidine'},
  ];

  final List<Map<String, dynamic>> _otherAminos = [
    {'label': 'Arginine (Semi-Ess) (g)', 'key': 'arginine'},
    {'label': 'Tyrosine (Semi-Ess) (g)', 'key': 'tyrosine'},
    {'label': 'Cystine (g)', 'key': 'cystine'},
    {'label': 'Alanine (g)', 'key': 'alanine'},
    {'label': 'Glycine (g)', 'key': 'glycine'},
    {'label': 'Proline (g)', 'key': 'proline'},
    {'label': 'Serine (g)', 'key': 'serine'},
    {'label': 'Aspartic Acid (g)', 'key': 'asparticAcid'},
    {'label': 'Glutamic Acid (g)', 'key': 'glutamicAcid'},
  ];

  final List<Map<String, dynamic>> _extraMacros = [
    {'label': 'Fiber (g)', 'key': 'fiber'},
    {'label': 'Sugars (g)', 'key': 'sugars'},
    {'label': 'Sat. Fat (g)', 'key': 'satFat'},
    {'label': 'Cholesterol (mg)', 'key': 'cholesterol'},
    {'label': 'Omega-3 (g)', 'key': 'omega3'},
    {'label': 'Omega-6 (g)', 'key': 'omega6'},
  ];

  @override
  void initState() {
    super.initState();
    final all = [
      ..._vitamins,
      ..._minerals,
      ..._essentialAminos,
      ..._otherAminos,
      ..._extraMacros,
    ];
    for (var f in all) {
      _controllers[f['key']] = TextEditingController(text: "0");
    }
  }

  double _val(String key) => double.tryParse(_controllers[key]!.text) ?? 0;

  void _scanBarcode() async {
    final FoodItem? scannedFood = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerView()),
    );

    if (scannedFood != null) {
      _fillFromFoodItem(scannedFood);
    }
  }

  void _fillFromFoodItem(FoodItem food) {
    setState(() {
      _nameController.text = food.name;
      _brandController.text = food.brand ?? '';
      _calController.text = food.calories.toStringAsFixed(1);
      _proController.text = food.protein.toStringAsFixed(1);
      _carbController.text = food.carbs.toStringAsFixed(1);
      _fatController.text = food.fat.toStringAsFixed(1);

      final Map<String, double> nutriments = {
        'fiber': food.fiber,
        'sugars': food.sugars,
        'satFat': food.satFat,
        'cholesterol': food.cholesterol,
        'omega3': food.omega3,
        'omega6': food.omega6,
        'vitA': food.vitA,
        'vitC': food.vitC,
        'vitD': food.vitD,
        'vitE': food.vitE,
        'vitK': food.vitK,
        'thiamine': food.thiamine,
        'riboflavin': food.riboflavin,
        'niacin': food.niacin,
        'pantothenicAcid': food.pantothenicAcid,
        'vitB6': food.vitB6,
        'biotin': food.biotin,
        'folate': food.folate,
        'vitB12': food.vitB12,
        'choline': food.choline,
        'calcium': food.calcium,
        'iron': food.iron,
        'magnesium': food.magnesium,
        'phosphorus': food.phosphorus,
        'potassium': food.potassium,
        'sodium': food.sodium,
        'zinc': food.zinc,
        'copper': food.copper,
        'manganese': food.manganese,
        'selenium': food.selenium,
        'iodine': food.iodine,
      };

      nutriments.forEach((key, value) {
        if (_controllers.containsKey(key)) {
          _controllers[key]!.text = value.toStringAsFixed(1);
        }
      });
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.cyanAccent, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final food = FoodItem()
      ..name = _nameController.text
      ..brand = _brandController.text.isEmpty ? null : _brandController.text
      ..calories = double.tryParse(_calController.text) ?? 0
      ..protein = double.tryParse(_proController.text) ?? 0
      ..carbs = double.tryParse(_carbController.text) ?? 0
      ..fat = double.tryParse(_fatController.text) ?? 0
      ..fiber = _val('fiber')
      ..sugars = _val('sugars')
      ..satFat = _val('satFat')
      ..cholesterol = _val('cholesterol')
      ..omega3 = _val('omega3')
      ..omega6 = _val('omega6')
      ..vitA = _val('vitA')
      ..vitC = _val('vitC')
      ..vitD = _val('vitD')
      ..vitE = _val('vitE')
      ..vitK = _val('vitK')
      ..thiamine = _val('thiamine')
      ..riboflavin = _val('riboflavin')
      ..niacin = _val('niacin')
      ..pantothenicAcid = _val('pantothenicAcid')
      ..vitB6 = _val('vitB6')
      ..biotin = _val('biotin')
      ..folate = _val('folate')
      ..vitB12 = _val('vitB12')
      ..choline = _val('choline')
      ..calcium = _val('calcium')
      ..iron = _val('iron')
      ..magnesium = _val('magnesium')
      ..phosphorus = _val('phosphorus')
      ..potassium = _val('potassium')
      ..sodium = _val('sodium')
      ..zinc = _val('zinc')
      ..copper = _val('copper')
      ..manganese = _val('manganese')
      ..selenium = _val('selenium')
      ..iodine = _val('iodine')
      ..leucine = _val('leucine')
      ..isoleucine = _val('isoleucine')
      ..valine = _val('valine')
      ..lysine = _val('lysine')
      ..methionine = _val('methionine')
      ..phenylalanine = _val('phenylalanine')
      ..threonine = _val('threonine')
      ..tryptophan = _val('tryptophan')
      ..histidine = _val('histidine')
      ..arginine = _val('arginine')
      ..tyrosine = _val('tyrosine')
      ..cystine = _val('cystine')
      ..alanine = _val('alanine')
      ..glycine = _val('glycine')
      ..proline = _val('proline')
      ..serine = _val('serine')
      ..asparticAcid = _val('asparticAcid')
      ..glutamicAcid = _val('glutamicAcid');

    await locator<DietRepository>().saveFoodItem(food);
    if (mounted) Navigator.pop(context, food);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xFF0A0A0A),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "CREATE CUSTOM FOOD",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.qr_code_scanner,
                    label: "SCAN BARCODE",
                    onTap: _scanBarcode,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.auto_awesome,
                    label: "AI ESTIMATION",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('AI Estimation feature in progress...'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildSectionTitle("BASIC INFO"),
                    _buildTextField(
                      _nameController,
                      "Food Name",
                      isRequired: true,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(_brandController, "Brand (Optional)"),

                    const SizedBox(height: 32),
                    _buildSectionTitle("MACRONUTRIENTS (per 100g)"),
                    _buildMacroInputs(),
                    const SizedBox(height: 12),
                    _buildGridInputs(_extraMacros),

                    const SizedBox(height: 32),
                    _buildSectionTitle("VITAMINS (High Detail)"),
                    _buildGridInputs(_vitamins),

                    const SizedBox(height: 32),
                    _buildSectionTitle("MINERALS (High Detail)"),
                    _buildGridInputs(_minerals),

                    const SizedBox(height: 32),
                    _buildSectionTitle("ESSENTIAL AMINO ACIDS"),
                    _buildGridInputs(_essentialAminos),

                    const SizedBox(height: 32),
                    _buildSectionTitle("SEMI-ESSENTIAL & OTHER AMINOS"),
                    _buildGridInputs(_otherAminos),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "SAVE FOOD TO DATABASE",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.cyanAccent,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildMacroInputs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildNumField(_calController, "Kcal")),
            const SizedBox(width: 12),
            Expanded(child: _buildNumField(_proController, "Protein")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildNumField(_carbController, "Carbs")),
            const SizedBox(width: 12),
            Expanded(child: _buildNumField(_fatController, "Fat")),
          ],
        ),
      ],
    );
  }

  Widget _buildGridInputs(List<Map<String, dynamic>> fields) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: fields.length,
      itemBuilder: (context, index) {
        final field = fields[index];
        return _buildNumField(_controllers[field['key']]!, field['label']);
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isRequired = false,
  }) {
    return TextFormField(
      controller: controller,
      onTap: () {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white24, fontSize: 12),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: isRequired ? (v) => v!.isEmpty ? "Required" : null : null,
    );
  }

  Widget _buildNumField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      onTap: () {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _calController.dispose();
    _proController.dispose();
    _carbController.dispose();
    _fatController.dispose();
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }
}
