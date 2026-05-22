import 'package:biofit_pro/core/services/step_tracker_service.dart';
import 'package:biofit_pro/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../logic/cubit/diet/diet_cubit.dart';
import '../../../logic/cubit/social/social_cubit.dart';
import 'dart:convert';
import '../../../data/models/diet_models.dart';
import '../../widgets/foggy_background.dart';
import 'widgets/nutrient_report_dialog.dart';
import 'widgets/food_search_dialog.dart';
import 'widgets/meal_section.dart';
import 'widgets/template_manager_dialog.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DietContent();
  }
}

class _DietContent extends StatelessWidget {
  const _DietContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: BlocBuilder<DietCubit, DietState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              );
            }

            final diet = state.currentDiet;
            if (diet == null)
              return const Center(child: Text("Initializing Diet..."));

            return CustomScrollView(
              slivers: [
                _buildSliverHeader(context, state),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildActionButtons(context),
                        const SizedBox(height: 16),
                        _buildMacroSummary(context, diet),
                        const SizedBox(height: 24),
                        _buildMealList(context, diet),
                        const SizedBox(height: 24),
                        _buildSupplementSection(context, diet),
                        const SizedBox(height: 12),
                        _buildSaveDietButton(context),
                        const SizedBox(height: 80), // Space for bottom buttons
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openNutrientReport(context),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.analytics_outlined),
        label: const Text(
          "FULL REPORT",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Widget _buildSliverHeader(BuildContext context, DietState state) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 140, // More breathing room
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- LEFT: STEPS (CLICKABLE) ---
                GestureDetector(
                  onTap: () async {
                    // Check GPS status on click as requested
                    await locator<StepTrackerService>().checkLocationService();
                    if (context.mounted) _showStepTrackerDialog(context);
                  },
                  child: StreamBuilder<void>(
                    stream: locator<StepTrackerService>().updateStream,
                    builder: (context, snapshot) {
                      final steps = locator<StepTrackerService>().currentSteps;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.directions_walk,
                              color: Colors.greenAccent, size: 24),
                          Text(
                            steps.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            "STEPS",
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // --- CENTER: DATE ---
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white54, size: 24),
                      onPressed: () => context.read<DietCubit>().loadDate(
                        state.selectedDate.subtract(const Duration(days: 1)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: state.selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null)
                          context.read<DietCubit>().loadDate(picked);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('EEEE').format(state.selectedDate).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d').format(state.selectedDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.white54,
                        size: 24,
                      ),
                      onPressed: () => context.read<DietCubit>().loadDate(
                        state.selectedDate.add(const Duration(days: 1)),
                      ),
                    ),
                  ],
                ),

                // --- RIGHT: CALORIES (CLICKABLE) ---
                GestureDetector(
                  onTap: () => _showCaloriesDialog(context),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department,
                          color: Colors.orangeAccent, size: 24),
                      const Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                        "BURNED",
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStepTrackerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_walk, color: Colors.greenAccent),
                  const SizedBox(width: 12),
                  const Text(
                    'STEP TRACKER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              StreamBuilder<void>(
                stream: locator<StepTrackerService>().updateStream,
                builder: (context, snapshot) {
                  final service = locator<StepTrackerService>();
                  final steps = service.currentSteps;
                  const int target = 10000;
                  final progress = (steps / target).clamp(0.0, 1.0);

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 12,
                              backgroundColor: Colors.white10,
                              valueColor: const AlwaysStoppedAnimation(Colors.greenAccent),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                steps.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const Text(
                                '/ 10,000',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'DISTANCE',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        '${(service.currentDistance / 1000).toStringAsFixed(2)} km',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCaloriesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orangeAccent),
                  const SizedBox(width: 12),
                  const Text(
                    'CALORIES BURNED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white24),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Icon(Icons.bolt_rounded, color: Colors.orangeAccent, size: 64),
              const SizedBox(height: 16),
              const Text(
                'ACTIVE BURNED',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Text(
                '0 kcal',
                style: TextStyle( color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('BMR Estimate', style: TextStyle(color: Colors.white38)),
                    Text('1,850 kcal', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroSummary(BuildContext context, DailyDiet diet) {
    // Calculate actual totals
    double p = 0, c = 0, f = 0, cal = 0;
    for (var m in diet.meals) {
      for (var i in m.items) {
        p += i.protein;
        c += i.carbs;
        f += i.fat;
        cal += i.calories;
      }
    }
    for (var i in diet.supplements) {
      p += i.protein;
      c += i.carbs;
      f += i.fat;
      cal += i.calories;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildSummaryCircle(
                  "CALORIES",
                  cal.round().toString(),
                  cal / 2500,
                  Colors.cyanAccent,
                ),
              ),
              Flexible(
                child: _buildSummaryCircle(
                  "PROTEIN",
                  "${p.round()}g",
                  p / 180,
                  Colors.orangeAccent,
                ),
              ),
              Flexible(
                child: _buildSummaryCircle(
                  "CARBS",
                  "${c.round()}g",
                  c / 300,
                  Colors.greenAccent,
                ),
              ),
              Flexible(
                child: _buildSummaryCircle(
                  "FAT",
                  "${f.round()}g",
                  f / 80,
                  Colors.limeAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCircle(
    String label,
    String value,
    double progress,
    Color color,
  ) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: progress.clamp(0, 1),
                strokeWidth: 6,
                color: color,
                backgroundColor: Colors.white10,
                strokeCap: StrokeCap.round,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildMealList(BuildContext context, DailyDiet diet) {
    return Column(
      children: [
        ...diet.meals.asMap().entries.map((entry) {
          return MealSection(
            meal: entry.value,
            mealIndex: entry.key,
            onAdd: () => _openFoodSearch(context, entry.key),
          );
        }),
        const SizedBox(height: 8),
        _buildAddMealButton(context),
      ],
    );
  }

  Widget _buildAddMealButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: OutlinedButton.icon(
        onPressed: () => _showAddMealDialog(context),
        icon: const Icon(Icons.add, color: Colors.cyanAccent, size: 18),
        label: const Text(
          "ADD NEW MEAL",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.cyanAccent.withOpacity(0.2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
    );
  }

  void _showAddMealDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (diagContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          "CREATE NEW MEAL",
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
            hintText: "Meal Name (e.g. Afternoon Snack)",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(diagContext),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DietCubit>().addMeal(controller.text);
              }
              Navigator.pop(diagContext);
            },
            child: const Text("CREATE"),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplementSection(BuildContext context, DailyDiet diet) {
    return MealSection(
      meal: Meal()
        ..name = "SUPPLEMENTS"
        ..items = diet.supplements,
      mealIndex: null, // Signals supplement section
      onAdd: () => _openFoodSearch(context, null),
    );
  }

  void _openFoodSearch(BuildContext context, int? mealIndex) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<DietCubit>(),
        child: FoodSearchDialog(mealIndex: mealIndex),
      ),
    );
  }

  void _openNutrientReport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<DietCubit>(),
        child: const NutrientReportDialog(),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.read<DietCubit>().copyFromPreviousDay(),
            icon: const Icon(
              Icons.content_copy,
              size: 16,
              color: Colors.greenAccent,
            ),
            label: const Text(
              "YESTERDAY",
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.greenAccent.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _openTemplateManager(context),
            icon: const Icon(
              Icons.folder,
              size: 16,
              color: Colors.orangeAccent,
            ),
            label: const Text(
              "LOAD DIET",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.orangeAccent.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () =>
                _showDietSharePicker(context), // Modified this line
            icon: const Icon(
              Icons.share_outlined,
              size: 16,
              color: Colors.cyanAccent,
            ),
            label: const Text(
              "SHARE DIET",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveDietButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showSaveDialog(context),
        icon: const Icon(Icons.save, size: 18),
        label: const Text(
          "SAVE DIET AS TEMPLATE",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyanAccent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (diagContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          "SAVE DIET",
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
            hintText: "Template name (e.g. Cutting Plan)",
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(diagContext),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DietCubit>().saveAsTemplate(controller.text);
              }
              Navigator.pop(diagContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }

  void _openTemplateManager(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<DietCubit>(),
        child: const TemplateManagerDialog(),
      ),
    );
  }

  void _showDietSharePicker(BuildContext context) {
    final dietCubit = context.read<DietCubit>();
    final diet = dietCubit.state.currentDiet;
    if (diet == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No diet data to share!")));
      return;
    }

    // Serialize diet
    final data = {
      'date': diet.date.toIso8601String(),
      'meals': diet.meals.map((m) {
        return {
          'name': m.name,
          'time': m.time,
          'items': m.items.map((item) {
            return {
              'name': item.name,
              'amount': item.amount,
              'unit': item.unit,
              'calories': item.calories,
              'protein': item.protein,
              'carbs': item.carbs,
              'fat': item.fat,
            };
          }).toList(),
        };
      }).toList(),
      'supplements': diet.supplements.map((item) {
        return {
          'name': item.name,
          'amount': item.amount,
          'unit': item.unit,
          'calories': item.calories,
          'protein': item.protein,
          'carbs': item.carbs,
          'fat': item.fat,
        };
      }).toList(),
    };

    final socialCubit = context.read<SocialCubit>();
    final dateStr = DateFormat('EEEE, MMM d').format(diet.date);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SHARE DIET PLAN TO',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'FOR: $dateStr',
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...socialCubit.state.conversations.map((conv) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: conv.isGroup
                      ? Colors.purple
                      : Colors.orangeAccent,
                  child: Icon(
                    conv.isGroup ? Icons.groups : Icons.restaurant_menu,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                title: Text(
                  conv.name,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  socialCubit.shareContent(
                    conv.remoteId,
                    "Shared a diet plan with you.",
                    'diet',
                    jsonEncode(data),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Shared with ${conv.name}")),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
