import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/diet_models.dart';
import '../../../data/repositories/diet_repository.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../locator.dart';
import '../evolution/evolution_cubit.dart';
import '../evolution/evolution_state.dart';

part 'diet_state.dart';

class DietCubit extends Cubit<DietState> {
  final DietRepository _repository = locator<DietRepository>();
  final WorkoutRepository _workoutRepository = locator<WorkoutRepository>();

  DietCubit() : super(DietState.initial()) {
    _init();
  }

  Future<void> _init() async {
    await _repository.seedCommonFoods();
    await loadDate(DateTime.now());
  }

  Future<void> loadDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    emit(state.copyWith(isLoading: true, selectedDate: startOfDay));
    try {
      DailyDiet? diet = await _repository.getDietForDate(startOfDay);
      final weekday = startOfDay.weekday; // 1 (Mon) - 7 (Sun)

      // Check if we should apply a scheduled template
      bool shouldApplyTemplate = false;
      DietTemplate? scheduledTemplate;

      if (diet == null) {
        // No diet exists, definitely check for template
        shouldApplyTemplate = true;
      } else {
        // Diet exists, but check if it's empty and there's a template for this day
        final isEmpty =
            diet.meals.every((m) => m.items.isEmpty) &&
            diet.supplements.isEmpty;
        if (isEmpty) {
          shouldApplyTemplate = true;
        }
      }

      if (shouldApplyTemplate) {
        // Check for scheduled template for this weekday
        final templates = await _repository.getAllTemplates();
        for (var t in templates) {
          if (t.scheduledDays.contains(weekday)) {
            scheduledTemplate = t;
            break;
          }
        }
      }

      if (scheduledTemplate != null) {
        // Apply the scheduled template
        if (diet == null) {
          diet = DailyDiet()..date = startOfDay;
        }

        diet.meals = scheduledTemplate.meals.map((m) {
          return Meal()
            ..name = m.name
            ..time = m.time
            ..items = List.from(m.items);
        }).toList();
        diet.supplements = List.from(scheduledTemplate.supplements);

        await _repository.saveDailyDiet(diet);
        diet = await _repository.getDietForDate(startOfDay);
      } else if (diet == null) {
        // No template and no existing diet - create empty one
        diet = DailyDiet()..date = startOfDay;

        // Fallback: Copy structure from PREVIOUS day
        final latestPastDiet = await _repository.getLatestDietBefore(
          startOfDay,
        );
        if (latestPastDiet != null) {
          diet.meals = latestPastDiet.meals.map((m) {
            return Meal()
              ..name = m.name
              ..time = m.time
              ..items = []; // Structure only
          }).toList();
          diet.supplements = [];
        } else {
          // Absolute fallback default
          diet.meals = [
            Meal()
              ..name = 'Breakfast'
              ..time = '08:00',
            Meal()
              ..name = 'Lunch'
              ..time = '13:00',
            Meal()
              ..name = 'Dinner'
              ..time = '19:00',
            Meal()
              ..name = 'Snacks'
              ..time = '16:00',
          ];
        }

        await _repository.saveDailyDiet(diet);
        diet = await _repository.getDietForDate(startOfDay);
      }

      final burnedCalories = await _workoutRepository.getCaloriesBurnedForDate(startOfDay);

      emit(state.copyWith(
        isLoading: false,
        currentDiet: diet,
        burnedCalories: burnedCalories,
      ));
    } catch (e) {
      debugPrint("Error loading diet: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  ConsumedFood _mapFood(FoodItem food, double amount, [String? unit]) {
    final ratio = amount / food.baseAmount;
    return ConsumedFood()
      ..foodId = food.id
      ..name = food.name
      ..amount = amount
      ..unit = unit ?? food.baseUnit
      ..calories = food.calories * ratio
      ..protein = food.protein * ratio
      ..carbs = food.carbs * ratio
      ..fat = food.fat * ratio
      ..fiber = food.fiber * ratio
      ..sugars = food.sugars * ratio
      ..satFat = food.satFat * ratio
      ..cholesterol = food.cholesterol * ratio
      ..omega3 = food.omega3 * ratio
      ..omega6 = food.omega6 * ratio
      ..vitA = food.vitA * ratio
      ..vitC = food.vitC * ratio
      ..vitD = food.vitD * ratio
      ..vitE = food.vitE * ratio
      ..vitK = food.vitK * ratio
      ..thiamine = food.thiamine * ratio
      ..riboflavin = food.riboflavin * ratio
      ..niacin = food.niacin * ratio
      ..pantothenicAcid = food.pantothenicAcid * ratio
      ..vitB6 = food.vitB6 * ratio
      ..biotin = food.biotin * ratio
      ..folate = food.folate * ratio
      ..vitB12 = food.vitB12 * ratio
      ..choline = food.choline * ratio
      ..calcium = food.calcium * ratio
      ..iron = food.iron * ratio
      ..magnesium = food.magnesium * ratio
      ..phosphorus = food.phosphorus * ratio
      ..potassium = food.potassium * ratio
      ..sodium = food.sodium * ratio
      ..zinc = food.zinc * ratio
      ..copper = food.copper * ratio
      ..manganese = food.manganese * ratio
      ..selenium = food.selenium * ratio
      ..iodine = food.iodine * ratio
      ..leucine = food.leucine * ratio
      ..isoleucine = food.isoleucine * ratio
      ..valine = food.valine * ratio
      ..lysine = food.lysine * ratio
      ..methionine = food.methionine * ratio
      ..phenylalanine = food.phenylalanine * ratio
      ..threonine = food.threonine * ratio
      ..tryptophan = food.tryptophan * ratio
      ..histidine = food.histidine * ratio
      ..arginine = food.arginine * ratio
      ..tyrosine = food.tyrosine * ratio
      ..cystine = food.cystine * ratio
      ..alanine = food.alanine * ratio
      ..glycine = food.glycine * ratio
      ..proline = food.proline * ratio
      ..serine = food.serine * ratio
      ..asparticAcid = food.asparticAcid * ratio
      ..glutamicAcid = food.glutamicAcid * ratio;
  }

  DailyDiet _cloneDiet(DailyDiet original) {
    return DailyDiet()
      ..id = original.id
      ..date = original.date
      ..supplements = List.from(original.supplements)
      ..meals = original.meals
          .map(
            (m) => Meal()
              ..name = m.name
              ..time = m.time
              ..items = List.from(m.items),
          )
          .toList();
  }

  Future<void> addFoodToMeal(
    int mealIndex,
    FoodItem food,
    double amount, [
    String? unit,
  ]) async {
    if (state.currentDiet == null) return;

    // Save sticky settings
    food.lastUsedAmount = amount;
    food.lastUsedUnit = unit ?? food.baseUnit;
    await _repository.saveFoodItem(food);

    final newDiet = _cloneDiet(state.currentDiet!);
    newDiet.meals[mealIndex].items.add(_mapFood(food, amount, unit));
    await _repository.saveDailyDiet(newDiet);

    // --- REWARD SYSTEM ---
    locator<EvolutionCubit>().addCoins(1, isDiet: true);

    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<void> addSupplement(FoodItem food, double amount, [String? unit]) async {
    if (state.currentDiet == null) return;

    // Save sticky settings
    food.lastUsedAmount = amount;
    food.lastUsedUnit = unit ?? food.baseUnit;
    await _repository.saveFoodItem(food);

    final newDiet = _cloneDiet(state.currentDiet!);
    newDiet.supplements.add(_mapFood(food, amount, unit));
    await _repository.saveDailyDiet(newDiet);
    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<void> removeFood(int? mealIndex, int itemIndex) async {
    if (state.currentDiet == null) return;
    final newDiet = _cloneDiet(state.currentDiet!);
    if (mealIndex == null) {
      newDiet.supplements.removeAt(itemIndex);
    } else {
      newDiet.meals[mealIndex].items.removeAt(itemIndex);
    }
    await _repository.saveDailyDiet(newDiet);
    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<void> updateFoodAmount(
    int? mealIndex,
    int itemIndex,
    double newAmount,
    String newUnit,
  ) async {
    if (state.currentDiet == null) return;
    final newDiet = _cloneDiet(state.currentDiet!);

    final ConsumedFood oldItem = (mealIndex == null)
        ? newDiet.supplements[itemIndex]
        : newDiet.meals[mealIndex].items[itemIndex];

    if (oldItem.foodId != null) {
      final allFoods = await _repository.searchFoods(oldItem.name ?? "");
      final baseFood = allFoods.firstWhere(
        (f) => f.id == oldItem.foodId,
        orElse: () => FoodItem()
          ..name = oldItem.name!
          ..baseAmount = 100,
      );

      final updatedItem = _mapFood(baseFood, newAmount);

      if (mealIndex == null) {
        newDiet.supplements[itemIndex] = updatedItem;
      } else {
        newDiet.meals[mealIndex].items[itemIndex] = updatedItem;
      }

      await _repository.saveDailyDiet(newDiet);
      emit(state.copyWith(currentDiet: newDiet));
    }
  }

  Future<void> addMeal(String name) async {
    if (state.currentDiet == null) return;
    final newDiet = _cloneDiet(state.currentDiet!);
    newDiet.meals.add(
      Meal()
        ..name = name
        ..time = DateFormat('HH:mm').format(DateTime.now()),
    );
    await _repository.saveDailyDiet(newDiet);
    await _propagateStructureToFuture(newDiet);
    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<void> deleteMeal(int index) async {
    if (state.currentDiet == null) return;
    final newDiet = _cloneDiet(state.currentDiet!);
    newDiet.meals.removeAt(index);
    await _repository.saveDailyDiet(newDiet);
    await _propagateStructureToFuture(newDiet);
    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<void> renameMeal(int index, String newName) async {
    if (state.currentDiet == null) return;
    final newDiet = _cloneDiet(state.currentDiet!);
    newDiet.meals[index].name = newName;
    await _repository.saveDailyDiet(newDiet);
    await _propagateStructureToFuture(newDiet);
    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<void> _propagateStructureToFuture(DailyDiet source) async {
    try {
      final futures = await _repository.getFutureEmptyDiets(source.date);
      for (var f in futures) {
        f.meals = source.meals.map((m) {
          return Meal()
            ..name = m.name
            ..time = m.time
            ..items = [];
        }).toList();
        await _repository.saveDailyDiet(f);
      }
    } catch (e) {
      debugPrint("Propagation Error: $e");
    }
  }

  Future<List<FoodItem>> search(String query, {String? category}) async {
    return await _repository.searchFoods(query, category: category);
  }

  Future<void> copyFromPreviousDay() async {
    if (state.currentDiet == null) return;
    final yesterday = state.selectedDate.subtract(const Duration(days: 1));
    final prevDiet = await _repository.getDietForDate(yesterday);

    if (prevDiet != null) {
      final newDiet = _cloneDiet(state.currentDiet!);
      newDiet.meals = prevDiet.meals.map((m) {
        return Meal()
          ..name = m.name
          ..time = m.time
          ..items = List.from(m.items);
      }).toList();
      newDiet.supplements = List.from(prevDiet.supplements);

      await _repository.saveDailyDiet(newDiet);
      emit(state.copyWith(currentDiet: newDiet));
    }
  }

  Future<void> loadTemplate(DietTemplate template) async {
    if (state.currentDiet == null) return;
    final newDiet = _cloneDiet(state.currentDiet!);

    newDiet.meals = template.meals.map((m) {
      return Meal()
        ..name = m.name
        ..time = m.time
        ..items = List.from(m.items);
    }).toList();
    newDiet.supplements = List.from(template.supplements);

    await _repository.saveDailyDiet(newDiet);
    emit(state.copyWith(currentDiet: newDiet));
  }

  Future<List<DietTemplate>> getTemplates() async {
    return await _repository.getAllTemplates();
  }

  Future<void> deleteTemplate(int id) async {
    await _repository.deleteTemplate(id);
  }

  Future<void> updateTemplateSchedule(int id, List<int> days) async {
    final templates = await _repository.getAllTemplates();

    // First, remove these days from ALL other templates
    for (var t in templates) {
      if (t.id == id) continue;

      bool changed = false;
      for (var day in days) {
        if (t.scheduledDays.contains(day)) {
          t.scheduledDays.remove(day);
          changed = true;
        }
      }

      if (changed) {
        await _repository.saveTemplate(t);
      }
    }

    // Now assign the days to this template
    final template = templates.firstWhere((t) => t.id == id);
    template.scheduledDays = days;
    await _repository.saveTemplate(template);
  }

  Future<void> saveAsTemplate(String name) async {
    if (state.currentDiet == null) return;
    final template = DietTemplate()
      ..name = name
      ..meals = state.currentDiet!.meals.map((m) {
        return Meal()
          ..name = m.name
          ..time = m.time
          ..items = List.from(m.items);
      }).toList()
      ..supplements = List.from(state.currentDiet!.supplements)
      ..scheduledDays = [];
    await _repository.saveTemplate(template);
  }

  Future<void> saveSharedDietAsTemplate(
    Map<String, dynamic> data,
    String name,
  ) async {
    final mealsData = data['meals'] as List? ?? [];
    final supplementsData = data['supplements'] as List? ?? [];

    final template = DietTemplate()
      ..name = name
      ..meals = mealsData.map((m) {
        final mMap = m as Map<String, dynamic>;
        final items = mMap['items'] as List? ?? [];
        return Meal()
          ..name = mMap['name'] ?? 'Meal'
          ..time = mMap['time'] ?? ''
          ..items = items.map((i) {
            final iMap = i as Map<String, dynamic>;
            return ConsumedFood()
              ..name = iMap['name']
              ..amount = (iMap['amount'] as num?)?.toDouble() ?? 0.0
              ..unit = iMap['unit'] ?? 'g'
              ..calories = (iMap['calories'] as num?)?.toDouble() ?? 0.0
              ..protein = (iMap['protein'] as num?)?.toDouble() ?? 0.0
              ..carbs = (iMap['carbs'] as num?)?.toDouble() ?? 0.0
              ..fat = (iMap['fat'] as num?)?.toDouble() ?? 0.0;
          }).toList();
      }).toList()
      ..supplements = supplementsData.map((i) {
        final iMap = i as Map<String, dynamic>;
        return ConsumedFood()
          ..name = iMap['name']
          ..amount = (iMap['amount'] as num?)?.toDouble() ?? 0.0
          ..unit = iMap['unit'] ?? 'g'
          ..calories = (iMap['calories'] as num?)?.toDouble() ?? 0.0
          ..protein = (iMap['protein'] as num?)?.toDouble() ?? 0.0
          ..carbs = (iMap['carbs'] as num?)?.toDouble() ?? 0.0
          ..fat = (iMap['fat'] as num?)?.toDouble() ?? 0.0;
      }).toList()
      ..scheduledDays = [];

    await _repository.saveTemplate(template);
  }

  Future<void> importDietPlan(
    Map<String, dynamic> data, {
    DateTime? targetDate,
  }) async {
    try {
      final date = targetDate ?? state.selectedDate;
      DailyDiet? targetDiet = await _repository.getDietForDate(date);

      if (targetDiet == null) {
        targetDiet = DailyDiet()..date = date;
      } else {
        targetDiet = _cloneDiet(targetDiet);
      }

      final mealsData = data['meals'] as List? ?? [];
      final supplementsData = data['supplements'] as List? ?? [];

      for (var m in mealsData) {
        final meal = Meal()
          ..name = m['name'] as String? ?? 'Meal'
          ..time = m['time'] as String? ?? '12:00'
          ..items = (m['items'] as List? ?? []).map((item) {
            return ConsumedFood()
              ..name = item['name'] as String? ?? 'Food'
              ..amount = (item['amount'] as num?)?.toDouble() ?? 100.0
              ..unit = item['unit'] as String? ?? 'g'
              ..calories = (item['calories'] as num?)?.toDouble() ?? 0.0
              ..protein = (item['protein'] as num?)?.toDouble() ?? 0.0
              ..carbs = (item['carbs'] as num?)?.toDouble() ?? 0.0
              ..fat = (item['fat'] as num?)?.toDouble() ?? 0.0;
          }).toList();

        final existingMealIdx = targetDiet.meals.indexWhere(
          (em) => em.name == meal.name,
        );
        if (existingMealIdx != -1) {
          targetDiet.meals[existingMealIdx].items.addAll(meal.items);
        } else {
          targetDiet.meals.add(meal);
        }
      }

      for (var s in supplementsData) {
        targetDiet.supplements.add(
          ConsumedFood()
            ..name = s['name'] as String? ?? 'Supplement'
            ..amount = (s['amount'] as num?)?.toDouble() ?? 5.0
            ..unit = s['unit'] as String? ?? 'g'
            ..calories = (s['calories'] as num?)?.toDouble() ?? 0.0
            ..protein = (s['protein'] as num?)?.toDouble() ?? 0.0
            ..carbs = (s['carbs'] as num?)?.toDouble() ?? 0.0
            ..fat = (s['fat'] as num?)?.toDouble() ?? 0.0,
        );
      }

      await _repository.saveDailyDiet(targetDiet);
      if (DateUtils.isSameDay(date, state.selectedDate)) {
        emit(state.copyWith(currentDiet: targetDiet));
      }
    } catch (e) {
      debugPrint("Error importing diet: $e");
    }
  }

  Future<void> addDietTemplateFromAI(Map<String, dynamic> data) async {
    try {
      final name = data['name'] as String? ?? 'AI Diet Plan';
      final mealsData = data['meals'] as List? ?? [];
      final supplementsData = data['supplements'] as List? ?? [];

      final template = DietTemplate()
        ..name = name
        ..scheduledDays = []
        ..meals = mealsData.map((m) {
          final itemsData = m['items'] as List? ?? [];
          return Meal()
            ..name = m['name'] as String? ?? 'Meal'
            ..time = m['time'] as String? ?? '12:00'
            ..items = itemsData.map((item) {
              return ConsumedFood()
                ..name = item['name'] as String? ?? 'Food'
                ..amount = (item['amount'] as num?)?.toDouble() ?? 100.0
                ..unit = item['unit'] as String? ?? 'g'
                ..calories = (item['calories'] as num?)?.toDouble() ?? 0.0
                ..protein = (item['protein'] as num?)?.toDouble() ?? 0.0
                ..carbs = (item['carbs'] as num?)?.toDouble() ?? 0.0
                ..fat = (item['fat'] as num?)?.toDouble() ?? 0.0;
            }).toList();
        }).toList()
        ..supplements = supplementsData.map((item) {
          return ConsumedFood()
            ..name = item['name'] as String? ?? 'Supplement'
            ..amount = (item['amount'] as num?)?.toDouble() ?? 5.0
            ..unit = item['unit'] as String? ?? 'g'
            ..calories = (item['calories'] as num?)?.toDouble() ?? 0.0
            ..protein = (item['protein'] as num?)?.toDouble() ?? 0.0
            ..carbs = (item['carbs'] as num?)?.toDouble() ?? 0.0
            ..fat = (item['fat'] as num?)?.toDouble() ?? 0.0;
        }).toList();

      await _repository.saveTemplate(template);
    } catch (e) {
      debugPrint("Error saving AI diet: $e");
    }
  }

  Future<DailyDiet?> getLatestDiet() async {
    return await _repository.getLatestDietBefore(
      DateTime.now().add(const Duration(days: 1)),
    );
  }

  Future<List<DateTime>> getDaysWithData() async {
    return await _repository.getDaysWithDiets();
  }
}
