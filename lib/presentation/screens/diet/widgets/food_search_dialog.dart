import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/diet_models.dart';
import '../../../../logic/cubit/diet/diet_cubit.dart';
import 'food_detail_dialog.dart';
import 'food_form_dialog.dart';

class FoodSearchDialog extends StatefulWidget {
  final int? mealIndex;
  const FoodSearchDialog({super.key, this.mealIndex});

  @override
  State<FoodSearchDialog> createState() => _FoodSearchDialogState();
}

class _FoodSearchDialogState extends State<FoodSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodItem> _results = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _onSearch("");
  }

  void _onSearch(String val) async {
    setState(() => _isSearching = true);
    final category = widget.mealIndex == null ? 'Supplement' : null;
    final results = await context.read<DietCubit>().search(
      val,
      category: category,
    );
    setState(() {
      _results = results;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF121212),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40), // Balance
                const Text(
                  "ADD FOOD",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white24,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              onChanged: _onSearch,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search NCCDB, USDA, Supplements...",
                hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _isSearching
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final food = _results[index];
                        return _buildFoodResult(food);
                      },
                    ),
            ),
            if (widget.mealIndex != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _createCheatMeal,
                  icon: const Icon(Icons.restaurant, size: 20),
                  label: const Text(
                    "CHEAT MEAL",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _createNewFood,
                icon: const Icon(Icons.add, color: Colors.cyanAccent, size: 20),
                label: const Text(
                  "OR CREATE NEW CUSTOM FOOD",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createNewFood() async {
    final food = await showDialog<FoodItem>(
      context: context,
      builder: (_) => const FoodFormDialog(),
    );
    if (food != null) {
      _showDetailDialog(food);
    }
  }

  void _createCheatMeal() async {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    bool isAccurate = false;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (diagContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text(
            "CHEAT MEAL",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "e.g., Pizza Night",
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: caloriesController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Calories",
                  hintText: "e.g., 1500",
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: isAccurate,
                onChanged: (val) => setState(() => isAccurate = val ?? false),
                title: const Text(
                  "Real calories (not estimation)",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                activeColor: Colors.deepOrange,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(diagContext),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    caloriesController.text.isNotEmpty) {
                  Navigator.pop(diagContext, {
                    'name': nameController.text,
                    'calories': double.tryParse(caloriesController.text) ?? 0,
                    'isAccurate': isAccurate,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text("ADD"),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      // Create a simple FoodItem with just calories
      final cheatFood = FoodItem()
        ..name = "${result['name']}${result['isAccurate'] ? ' ✓' : ' ~'}"
        ..category = 'Cheat Meal'
        ..calories = result['calories']
        ..protein = 0
        ..carbs = 0
        ..fat = 0
        ..baseAmount = 1
        ..baseUnit = 'serving';

      // Add directly without showing detail dialog
      if (widget.mealIndex == null) {
        context.read<DietCubit>().addSupplement(cheatFood, 1);
      } else {
        context.read<DietCubit>().addFoodToMeal(
          widget.mealIndex!,
          cheatFood,
          1,
        );
      }
      Navigator.pop(context); // Close search dialog
    }
  }

  Widget _buildFoodResult(FoodItem food) {
    return InkWell(
      onTap: () => _showDetailDialog(food),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "P: ${food.protein}g | C: ${food.carbs}g | F: ${food.fat}g",
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${food.calories.round()} kcal",
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white24,
                    size: 16,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _showDetailDialog(food),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(FoodItem food) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => FoodDetailDialog(food: food),
    );

    if (result != null) {
      final amount = result['amount'] as double;
      final unit = result['unit'] as String;

      // Update sticky preference
      food.lastUsedAmount = amount;
      food.lastUsedUnit = unit;

      if (widget.mealIndex == null) {
        context.read<DietCubit>().addSupplement(food, amount, unit);
      } else {
        context.read<DietCubit>().addFoodToMeal(
          widget.mealIndex!,
          food,
          amount,
          unit,
        );
      }
      Navigator.pop(context); // Close search dialog
    }
  }
}
