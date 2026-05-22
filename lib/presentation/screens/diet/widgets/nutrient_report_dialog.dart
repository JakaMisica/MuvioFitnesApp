import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/diet/diet_cubit.dart';
import '../../../../data/models/diet_models.dart';

class NutrientReportDialog extends StatelessWidget {
  const NutrientReportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DietCubit, DietState>(
      builder: (context, state) {
        final diet = state.currentDiet;
        if (diet == null) return const SizedBox();

        final totals = _calculateTotals(diet);

        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: Color(0xFF0D0D0D),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "NEURAL NUTRITION REPORT",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildSection("VITAL MACRONUTRIENTS", [
                      _buildRow("Protein", totals['protein']!, "g", 180),
                      _buildRow("Carbs", totals['carbs']!, "g", 300),
                      _buildRow("Fat", totals['fat']!, "g", 80),
                      _buildRow("Fiber", totals['fiber']!, "g", 30),
                      _buildRow("Sugars", totals['sugars']!, "g", 50),
                      _buildRow("Sat. Fat", totals['satFat']!, "g", 20),
                      _buildRow(
                        "Cholesterol",
                        totals['cholesterol']!,
                        "mg",
                        300,
                      ),
                      _buildRow("Omega-3", totals['omega3']!, "g", 1.6),
                      _buildRow("Omega-6", totals['omega6']!, "g", 17),
                    ]),
                    const SizedBox(height: 24),
                    _buildSection("VITAMIN SPECTRUM", [
                      _buildRow("Vitamin A", totals['vitA']!, "µg", 900),
                      _buildRow("Vitamin C", totals['vitC']!, "mg", 90),
                      _buildRow("Vitamin D", totals['vitD']!, "µg", 15),
                      _buildRow("Vitamin E", totals['vitE']!, "mg", 15),
                      _buildRow("Vitamin K", totals['vitK']!, "µg", 120),
                      _buildRow(
                        "Thiamine (B1)",
                        totals['thiamine']!,
                        "mg",
                        1.2,
                      ),
                      _buildRow(
                        "Riboflavin (B2)",
                        totals['riboflavin']!,
                        "mg",
                        1.3,
                      ),
                      _buildRow("Niacin (B3)", totals['niacin']!, "mg", 16),
                      _buildRow(
                        "Pantothenic Acid (B5)",
                        totals['pantothenicAcid']!,
                        "mg",
                        5,
                      ),
                      _buildRow("Vitamin B6", totals['vitB6']!, "mg", 1.3),
                      _buildRow("Biotin (B7)", totals['biotin']!, "µg", 30),
                      _buildRow("Folate (B9)", totals['folate']!, "µg", 400),
                      _buildRow("Vitamin B12", totals['vitB12']!, "µg", 2.4),
                      _buildRow("Choline", totals['choline']!, "mg", 550),
                    ]),
                    const SizedBox(height: 24),
                    _buildSection("MINERAL SPECTRUM", [
                      _buildRow("Calcium", totals['calcium']!, "mg", 1000),
                      _buildRow("Iron", totals['iron']!, "mg", 8),
                      _buildRow("Magnesium", totals['magnesium']!, "mg", 400),
                      _buildRow("Phosphorus", totals['phosphorus']!, "mg", 700),
                      _buildRow("Potassium", totals['potassium']!, "mg", 3400),
                      _buildRow("Sodium", totals['sodium']!, "mg", 2300),
                      _buildRow("Zinc", totals['zinc']!, "mg", 11),
                      _buildRow("Copper", totals['copper']!, "mg", 0.9),
                      _buildRow("Manganese", totals['manganese']!, "mg", 2.3),
                      _buildRow("Selenium", totals['selenium']!, "µg", 55),
                      _buildRow("Iodine", totals['iodine']!, "µg", 150),
                    ]),
                    const SizedBox(height: 24),
                    _buildSection("ESSENTIAL AMINO ACIDS", [
                      _buildRow("Leucine", totals['leucine']!, "g", 2.5),
                      _buildRow("Isoleucine", totals['isoleucine']!, "g", 1.5),
                      _buildRow("Valine", totals['valine']!, "g", 1.6),
                      _buildRow("Lysine", totals['lysine']!, "g", 2.2),
                      _buildRow("Methionine", totals['methionine']!, "g", 1.0),
                      _buildRow(
                        "Phenylalanine",
                        totals['phenylalanine']!,
                        "g",
                        1.8,
                      ),
                      _buildRow("Threonine", totals['threonine']!, "g", 1.2),
                      _buildRow("Tryptophan", totals['tryptophan']!, "g", 0.3),
                      _buildRow("Histidine", totals['histidine']!, "g", 0.8),
                    ]),
                    const SizedBox(height: 24),
                    _buildSection("SEMI-ESSENTIAL & OTHERS", [
                      _buildRow("Arginine", totals['arginine']!, "g", 5.0),
                      _buildRow("Tyrosine", totals['tyrosine']!, "g", 1.0),
                      _buildRow("Cystine", totals['cystine']!, "g", 0.5),
                      _buildRow("Alanine", totals['alanine']!, "g", 3.0),
                      _buildRow("Glycine", totals['glycine']!, "g", 3.0),
                      _buildRow("Proline", totals['proline']!, "g", 2.0),
                      _buildRow("Serine", totals['serine']!, "g", 2.0),
                      _buildRow(
                        "Aspartic Acid",
                        totals['asparticAcid']!,
                        "g",
                        5.0,
                      ),
                      _buildRow(
                        "Glutamic Acid",
                        totals['glutamicAcid']!,
                        "g",
                        8.0,
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            fontSize: 10,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildRow(String name, double value, String unit, double target) {
    final progress = (value / (target > 0 ? target : 1)).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                "${value.toStringAsFixed(1)}$unit / $target$unit",
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
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
              color: progress >= 1.0 ? Colors.greenAccent : Colors.cyanAccent,
              minHeight: 3,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, double> _calculateTotals(DailyDiet diet) {
    final Map<String, double> res = {};

    // Initialize all with 0
    final keys = [
      'protein',
      'carbs',
      'fat',
      'fiber',
      'sugars',
      'satFat',
      'cholesterol',
      'omega3',
      'omega6',
      'vitA',
      'vitC',
      'vitD',
      'vitE',
      'vitK',
      'thiamine',
      'riboflavin',
      'niacin',
      'pantothenicAcid',
      'vitB6',
      'biotin',
      'folate',
      'vitB12',
      'choline',
      'calcium',
      'iron',
      'magnesium',
      'phosphorus',
      'potassium',
      'sodium',
      'zinc',
      'copper',
      'manganese',
      'selenium',
      'iodine',
      'leucine',
      'isoleucine',
      'valine',
      'lysine',
      'methionine',
      'phenylalanine',
      'threonine',
      'tryptophan',
      'histidine',
      'arginine',
      'tyrosine',
      'cystine',
      'alanine',
      'glycine',
      'proline',
      'serine',
      'asparticAcid',
      'glutamicAcid',
    ];
    for (var k in keys) {
      res[k] = 0.0;
    }

    void aggregate(ConsumedFood item) {
      res['protein'] = (res['protein'] ?? 0) + item.protein;
      res['carbs'] = (res['carbs'] ?? 0) + item.carbs;
      res['fat'] = (res['fat'] ?? 0) + item.fat;
      res['fiber'] = (res['fiber'] ?? 0) + item.fiber;
      res['sugars'] = (res['sugars'] ?? 0) + item.sugars;
      res['satFat'] = (res['satFat'] ?? 0) + item.satFat;
      res['cholesterol'] = (res['cholesterol'] ?? 0) + item.cholesterol;
      res['omega3'] = (res['omega3'] ?? 0) + item.omega3;
      res['omega6'] = (res['omega6'] ?? 0) + item.omega6;
      res['vitA'] = (res['vitA'] ?? 0) + item.vitA;
      res['vitC'] = (res['vitC'] ?? 0) + item.vitC;
      res['vitD'] = (res['vitD'] ?? 0) + item.vitD;
      res['vitE'] = (res['vitE'] ?? 0) + item.vitE;
      res['vitK'] = (res['vitK'] ?? 0) + item.vitK;
      res['thiamine'] = (res['thiamine'] ?? 0) + item.thiamine;
      res['riboflavin'] = (res['riboflavin'] ?? 0) + item.riboflavin;
      res['niacin'] = (res['niacin'] ?? 0) + item.niacin;
      res['pantothenicAcid'] =
          (res['pantothenicAcid'] ?? 0) + item.pantothenicAcid;
      res['vitB6'] = (res['vitB6'] ?? 0) + item.vitB6;
      res['biotin'] = (res['biotin'] ?? 0) + item.biotin;
      res['folate'] = (res['folate'] ?? 0) + item.folate;
      res['vitB12'] = (res['vitB12'] ?? 0) + item.vitB12;
      res['choline'] = (res['choline'] ?? 0) + item.choline;
      res['calcium'] = (res['calcium'] ?? 0) + item.calcium;
      res['iron'] = (res['iron'] ?? 0) + item.iron;
      res['magnesium'] = (res['magnesium'] ?? 0) + item.magnesium;
      res['phosphorus'] = (res['phosphorus'] ?? 0) + item.phosphorus;
      res['potassium'] = (res['potassium'] ?? 0) + item.potassium;
      res['sodium'] = (res['sodium'] ?? 0) + item.sodium;
      res['zinc'] = (res['zinc'] ?? 0) + item.zinc;
      res['copper'] = (res['copper'] ?? 0) + item.copper;
      res['manganese'] = (res['manganese'] ?? 0) + item.manganese;
      res['selenium'] = (res['selenium'] ?? 0) + item.selenium;
      res['iodine'] = (res['iodine'] ?? 0) + item.iodine;
      res['leucine'] = (res['leucine'] ?? 0) + item.leucine;
      res['isoleucine'] = (res['isoleucine'] ?? 0) + item.isoleucine;
      res['valine'] = (res['valine'] ?? 0) + item.valine;
      res['lysine'] = (res['lysine'] ?? 0) + item.lysine;
      res['methionine'] = (res['methionine'] ?? 0) + item.methionine;
      res['phenylalanine'] = (res['phenylalanine'] ?? 0) + item.phenylalanine;
      res['threonine'] = (res['threonine'] ?? 0) + item.threonine;
      res['tryptophan'] = (res['tryptophan'] ?? 0) + item.tryptophan;
      res['histidine'] = (res['histidine'] ?? 0) + item.histidine;
      res['arginine'] = (res['arginine'] ?? 0) + item.arginine;
      res['tyrosine'] = (res['tyrosine'] ?? 0) + item.tyrosine;
      res['cystine'] = (res['cystine'] ?? 0) + item.cystine;
      res['alanine'] = (res['alanine'] ?? 0) + item.alanine;
      res['glycine'] = (res['glycine'] ?? 0) + item.glycine;
      res['proline'] = (res['proline'] ?? 0) + item.proline;
      res['serine'] = (res['serine'] ?? 0) + item.serine;
      res['asparticAcid'] = (res['asparticAcid'] ?? 0) + item.asparticAcid;
      res['glutamicAcid'] = (res['glutamicAcid'] ?? 0) + item.glutamicAcid;
    }

    for (var m in diet.meals) {
      for (var i in m.items) {
        aggregate(i);
      }
    }
    for (var i in diet.supplements) {
      aggregate(i);
    }

    return res;
  }
}
