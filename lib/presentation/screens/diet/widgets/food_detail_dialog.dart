import 'package:flutter/material.dart';
import '../../../../data/models/diet_models.dart';

class FoodDetailDialog extends StatefulWidget {
  final FoodItem food;
  final double initialAmount;
  final bool isEditing;
  const FoodDetailDialog({
    super.key,
    required this.food,
    this.initialAmount = 100.0,
    this.isEditing = false,
  });

  @override
  State<FoodDetailDialog> createState() => _FoodDetailDialogState();
}

class _FoodDetailDialogState extends State<FoodDetailDialog> {
  late TextEditingController _amountController;
  late double _currentAmount;
  late String _selectedUnit;

  final Map<String, double> rda = {
    'Calories': 2500,
    'Protein': 180,
    'Carbs': 300,
    'Fat': 80,
    'Fiber': 30,
    'Sugars': 50,
    'Sat Fat': 20,
    'Cholesterol': 300,
    'Omega-3': 1.6,
    'Omega-6': 17,
    'Vit A': 900,
    'Vit C': 90,
    'Vit D': 15,
    'Vit E': 15,
    'Vit K': 120,
    'Thiamine (B1)': 1.2,
    'Riboflavin (B2)': 1.3,
    'Niacin (B3)': 16,
    'Pantothenic B5': 5,
    'Vit B6': 1.3,
    'Biotin (B7)': 30,
    'Folate (B9)': 400,
    'Vit B12': 2.4,
    'Choline': 550,
    'Zinc': 11,
    'Iron': 8,
    'Magnesium': 400,
    'Phosphorus': 700,
    'Potassium': 3400,
    'Sodium': 2300,
    'Selenium': 55,
    'Iodine': 150,
    'Copper': 0.9,
    'Manganese': 2.3,
    'Leucine': 2.7,
    'Isoleucine': 1.5,
    'Valine': 1.8,
    'Lysine': 2.5,
    'Methionine': 1.0,
    'Phenylalanine': 1.9,
    'Threonine': 1.5,
    'Tryptophan': 0.35,
    'Histidine': 0.8,
    'Arginine': 5.0,
    'Tyrosine': 3.0,
    'Cystine': 0.7,
    'Alanine': 4.0,
    'Glycine': 4.0,
    'Proline': 3.0,
    'Serine': 3.0,
    'Aspartic Acid': 6.0,
    'Glutamic Acid': 10.0,
  };

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.food.lastUsedAmount ?? widget.initialAmount;
    _selectedUnit = widget.food.lastUsedUnit ?? widget.food.baseUnit;
    _amountController = TextEditingController(
      text: _currentAmount.toStringAsFixed(0),
    );
  }

  void _onAmountChanged(String val) {
    setState(() {
      _currentAmount = double.tryParse(val) ?? 0.0;
    });
  }

  double _scale(double value) {
    return (value * _currentAmount) / widget.food.baseAmount;
  }

  @override
  Widget build(BuildContext context) {
    final scaledP = _scale(widget.food.protein);
    final scaledC = _scale(widget.food.carbs);
    final scaledF = _scale(widget.food.fat);
    final scaledCal = _scale(widget.food.calories);

    final pCal = scaledP * 4;
    final cCal = scaledC * 4;
    final fCal = scaledF * 9;
    final totalCal = pCal + cCal + fCal;

    final pPerc = totalCal > 0 ? (pCal / totalCal) : 0.0;
    final cPerc = totalCal > 0 ? (cCal / totalCal) : 0.0;
    final fPerc = totalCal > 0 ? (fCal / totalCal) : 0.0;

    return Dialog(
      backgroundColor: const Color(0xFF0F0F0F),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.food.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            const Divider(color: Colors.white10, height: 32),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "AMOUNT",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: TextField(
                                controller: _amountController,
                                onChanged: _onAmountChanged,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: "0",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(canvasColor: const Color(0xFF1A1A1A)),
                              child: DropdownButton<String>(
                                value: _selectedUnit,
                                items:
                                    [
                                          'g',
                                          'mg',
                                          'mcg',
                                          'IU',
                                          'scoop',
                                          'tab',
                                          'capsule',
                                          'ml',
                                          'piece',
                                        ]
                                        .map(
                                          (u) => DropdownMenuItem(
                                            value: u,
                                            child: Text(
                                              u,
                                              style: const TextStyle(
                                                color: Colors.cyanAccent,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _selectedUnit = val);
                                  }
                                },
                                underline: const SizedBox(),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                  color: Colors.white38,
                                ),
                                isDense: true,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      height: 10,
                      width: double.infinity,
                      child: Row(
                        children: [
                          if (pPerc > 0)
                            Expanded(
                              flex: (pPerc * 100).round(),
                              child: Container(color: Colors.orangeAccent),
                            ),
                          if (cPerc > 0)
                            Expanded(
                              flex: (cPerc * 100).round(),
                              child: Container(color: Colors.greenAccent),
                            ),
                          if (fPerc > 0)
                            Expanded(
                              flex: (fPerc * 100).round(),
                              child: Container(color: Colors.limeAccent),
                            ),
                          if (totalCal == 0)
                            Expanded(child: Container(color: Colors.white10)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPercStat("PROTEIN", pPerc, Colors.orangeAccent),
                      _buildPercStat("CARBS", cPerc, Colors.greenAccent),
                      _buildPercStat("FAT", fPerc, Colors.limeAccent),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle("MACRONUTRIENTS"),
                  _buildNutrientRow(
                    "Calories",
                    scaledCal,
                    "kcal",
                    Colors.cyanAccent,
                  ),
                  _buildNutrientRow(
                    "Protein",
                    scaledP,
                    "g",
                    Colors.orangeAccent,
                  ),
                  _buildNutrientRow("Carbs", scaledC, "g", Colors.greenAccent),
                  _buildNutrientRow("Fat", scaledF, "g", Colors.limeAccent),
                  _buildNutrientRow("Fiber", _scale(widget.food.fiber), "g"),
                  _buildNutrientRow("Sugars", _scale(widget.food.sugars), "g"),
                  _buildNutrientRow(
                    "Sat. Fat",
                    _scale(widget.food.satFat),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Cholesterol",
                    _scale(widget.food.cholesterol),
                    "mg",
                  ),
                  _buildNutrientRow("Omega-3", _scale(widget.food.omega3), "g"),
                  _buildNutrientRow("Omega-6", _scale(widget.food.omega6), "g"),

                  const SizedBox(height: 24),
                  _buildSectionTitle("VITAMIN SPECTRUM"),
                  _buildNutrientRow("Vit A", _scale(widget.food.vitA), "µg"),
                  _buildNutrientRow("Vit C", _scale(widget.food.vitC), "mg"),
                  _buildNutrientRow("Vit D", _scale(widget.food.vitD), "µg"),
                  _buildNutrientRow("Vit E", _scale(widget.food.vitE), "mg"),
                  _buildNutrientRow("Vit K", _scale(widget.food.vitK), "µg"),
                  _buildNutrientRow(
                    "Thiamine (B1)",
                    _scale(widget.food.thiamine),
                    "mg",
                  ),
                  _buildNutrientRow(
                    "Riboflavin (B2)",
                    _scale(widget.food.riboflavin),
                    "mg",
                  ),
                  _buildNutrientRow(
                    "Niacin (B3)",
                    _scale(widget.food.niacin),
                    "mg",
                  ),
                  _buildNutrientRow(
                    "Pantothenic B5",
                    _scale(widget.food.pantothenicAcid),
                    "mg",
                  ),
                  _buildNutrientRow("Vit B6", _scale(widget.food.vitB6), "mg"),
                  _buildNutrientRow(
                    "Biotin (B7)",
                    _scale(widget.food.biotin),
                    "µg",
                  ),
                  _buildNutrientRow(
                    "Folate (B9)",
                    _scale(widget.food.folate),
                    "µg",
                  ),
                  _buildNutrientRow(
                    "Vit B12",
                    _scale(widget.food.vitB12),
                    "µg",
                  ),
                  _buildNutrientRow(
                    "Choline",
                    _scale(widget.food.choline),
                    "mg",
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle("MINERAL SPECTRUM"),
                  _buildNutrientRow("Zinc", _scale(widget.food.zinc), "mg"),
                  _buildNutrientRow("Iron", _scale(widget.food.iron), "mg"),
                  _buildNutrientRow(
                    "Magnesium",
                    _scale(widget.food.magnesium),
                    "mg",
                  ),
                  _buildNutrientRow(
                    "Phosphorus",
                    _scale(widget.food.phosphorus),
                    "mg",
                  ),
                  _buildNutrientRow(
                    "Potassium",
                    _scale(widget.food.potassium),
                    "mg",
                  ),
                  _buildNutrientRow("Sodium", _scale(widget.food.sodium), "mg"),
                  _buildNutrientRow(
                    "Selenium",
                    _scale(widget.food.selenium),
                    "µg",
                  ),
                  _buildNutrientRow("Iodine", _scale(widget.food.iodine), "µg"),
                  _buildNutrientRow("Copper", _scale(widget.food.copper), "mg"),
                  _buildNutrientRow(
                    "Manganese",
                    _scale(widget.food.manganese),
                    "mg",
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle("ESSENTIAL AMINO ACIDS"),
                  _buildNutrientRow(
                    "Leucine",
                    _scale(widget.food.leucine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Isoleucine",
                    _scale(widget.food.isoleucine),
                    "g",
                  ),
                  _buildNutrientRow("Valine", _scale(widget.food.valine), "g"),
                  _buildNutrientRow("Lysine", _scale(widget.food.lysine), "g"),
                  _buildNutrientRow(
                    "Methionine",
                    _scale(widget.food.methionine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Phenylalanine",
                    _scale(widget.food.phenylalanine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Threonine",
                    _scale(widget.food.threonine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Tryptophan",
                    _scale(widget.food.tryptophan),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Histidine",
                    _scale(widget.food.histidine),
                    "g",
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle("SEMI-ESSENTIAL & OTHERS"),
                  _buildNutrientRow(
                    "Arginine",
                    _scale(widget.food.arginine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Tyrosine",
                    _scale(widget.food.tyrosine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Cystine",
                    _scale(widget.food.cystine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Alanine",
                    _scale(widget.food.alanine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Glycine",
                    _scale(widget.food.glycine),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Proline",
                    _scale(widget.food.proline),
                    "g",
                  ),
                  _buildNutrientRow("Serine", _scale(widget.food.serine), "g"),
                  _buildNutrientRow(
                    "Aspartic Acid",
                    _scale(widget.food.asparticAcid),
                    "g",
                  ),
                  _buildNutrientRow(
                    "Glutamic Acid",
                    _scale(widget.food.glutamicAcid),
                    "g",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, {
                  'amount': _currentAmount,
                  'unit': _selectedUnit,
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.isEditing ? "UPDATE ENTRY" : "ADD TO DIET",
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercStat(String label, double perc, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white24,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Text(
          "${(perc * 100).toStringAsFixed(1)}%",
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
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

  Widget _buildNutrientRow(
    String label,
    double value,
    String unit, [
    Color? color,
  ]) {
    final target = rda[label] ?? 100.0;
    final progress = (value / target).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color ?? Colors.white.withOpacity(0.85),
                  fontSize: 13,
                  fontWeight: color != null ? FontWeight.w900 : FontWeight.bold,
                ),
              ),
              Text(
                "${value.toStringAsFixed(value < 1 ? 2 : 1)}$unit",
                style: TextStyle(
                  color: color ?? Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.05),
              color: color ?? Colors.cyanAccent.withOpacity(0.5),
              minHeight: 2,
            ),
          ),
        ],
      ),
    );
  }
}
