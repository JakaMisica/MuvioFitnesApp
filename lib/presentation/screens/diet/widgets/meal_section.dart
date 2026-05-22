import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/diet_models.dart';
import '../../../../logic/cubit/diet/diet_cubit.dart';
import 'food_detail_dialog.dart';

class MealSection extends StatefulWidget {
  final Meal meal;
  final int? mealIndex;
  final VoidCallback onAdd;

  const MealSection({
    super.key,
    required this.meal,
    this.mealIndex,
    required this.onAdd,
  });

  @override
  State<MealSection> createState() => _MealSectionState();
}

class _MealSectionState extends State<MealSection> {
  late List<ConsumedFood> _items;

  @override
  void initState() {
    super.initState();
    _items = List<ConsumedFood>.from(widget.meal.items);
  }

  @override
  void didUpdateWidget(MealSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync when parent rebuilds (e.g. after cubit updates)
    if (oldWidget.meal.items != widget.meal.items) {
      _items = List<ConsumedFood>.from(widget.meal.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: widget.mealIndex != null
                        ? () => _showRenameDialog(context)
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.meal.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.cyanAccent,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12.5,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            if (widget.mealIndex != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: const Icon(
                                  Icons.edit_note,
                                  size: 16,
                                  color: Colors.white24,
                                ),
                              ),
                          ],
                        ),
                        if (widget.meal.time.isNotEmpty)
                          Text(
                            widget.meal.time,
                            style: TextStyle(
                              color: Colors.white30,
                              fontSize: 10,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.mealIndex != null)
                      IconButton(
                        onPressed: () => _confirmDelete(context),
                        icon: const Icon(
                          Icons.delete_sweep_outlined,
                          color: Colors.white24,
                          size: 20,
                        ),
                        tooltip: "Delete Meal",
                      ),
                    IconButton(
                      onPressed: widget.onAdd,
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.cyanAccent,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_items.isEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                "No items added yet",
                style: TextStyle(
                  color: Colors.white10,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.white.withOpacity(0.05), height: 1),
              itemBuilder: (context, index) {
                final item = _items[index];
                return InkWell(
                  onTap: () async {
                    final results = await context.read<DietCubit>().search(
                      item.name ?? "",
                    );
                    final baseFood = results.firstWhere(
                      (f) => f.id == item.foodId,
                      orElse: () => FoodItem()
                        ..name = item.name ?? "Food"
                        ..calories = item.calories / (item.amount / 100),
                    );

                    if (context.mounted) {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (_) => FoodDetailDialog(
                          food: baseFood,
                          initialAmount: item.amount,
                          isEditing: true,
                        ),
                      );

                      if (result != null && context.mounted) {
                        context.read<DietCubit>().updateFoodAmount(
                          widget.mealIndex,
                          index,
                          result['amount'],
                          result['unit'],
                        );
                      }
                    }
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    title: Text(
                      item.name ?? "Unknown",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${item.amount.round()}${item.unit}",
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${item.calories.round()} kcal",
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white24,
                            size: 16,
                          ),
                          onPressed: () {
                            context.read<DietCubit>().removeFood(
                              widget.mealIndex,
                              index,
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  void _showRenameDialog(BuildContext context) {
    if (widget.mealIndex == null) return;
    final controller = TextEditingController(text: widget.meal.name);
    showDialog(
      context: context,
      builder: (diagContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          "RENAME MEAL",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Meal Name (e.g. Snack 2)",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(diagContext),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DietCubit>().renameMeal(
                widget.mealIndex!,
                controller.text,
              );
              Navigator.pop(diagContext);
            },
            child: const Text("RENAME"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    if (widget.mealIndex == null) return;
    showDialog(
      context: context,
      builder: (diagContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          "DELETE ${widget.meal.name.toUpperCase()}?",
          style: const TextStyle(color: Colors.redAccent),
        ),
        content: const Text(
          "This will remove the entire meal and all its items.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(diagContext),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              context.read<DietCubit>().deleteMeal(widget.mealIndex!);
              Navigator.pop(diagContext);
            },
            child: const Text("DELETE", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
