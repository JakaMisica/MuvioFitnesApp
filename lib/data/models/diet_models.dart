import 'package:isar/isar.dart';

part 'diet_models.g.dart';

@collection
class FoodItem {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String name;

  String? brand;
  String? category; // Supplement, Fruit, Meat, etc.

  double baseAmount = 100.0;
  String baseUnit = 'g'; // g, ml, piece

  // Primary Macros
  double calories = 0.0;
  double protein = 0.0;
  double carbs = 0.0;
  double fat = 0.0;

  // Fiber & Sugars
  double fiber = 0.0;
  double sugars = 0.0;
  double starch = 0.0;

  // Fats detailed
  double satFat = 0.0;
  double monounsatFat = 0.0;
  double polyunsatFat = 0.0;
  double transFat = 0.0;
  double cholesterol = 0.0;
  double omega3 = 0.0;
  double omega6 = 0.0;

  // Vitamins
  double vitA = 0.0;
  double vitC = 0.0;
  double vitD = 0.0;
  double vitE = 0.0;
  double vitK = 0.0;
  double thiamine = 0.0; // B1
  double riboflavin = 0.0; // B2
  double niacin = 0.0; // B3
  double pantothenicAcid = 0.0; // B5
  double vitB6 = 0.0;
  double biotin = 0.0; // B7
  double folate = 0.0; // B9
  double vitB12 = 0.0;
  double choline = 0.0;

  // Minerals
  double calcium = 0.0;
  double iron = 0.0;
  double magnesium = 0.0;
  double phosphorus = 0.0;
  double potassium = 0.0;
  double sodium = 0.0;
  double zinc = 0.0;
  double copper = 0.0;
  double manganese = 0.0;
  double selenium = 0.0;
  double iodine = 0.0;

  // Amino Acids (Essential)
  double tryptophan = 0.0;
  double threonine = 0.0;
  double isoleucine = 0.0;
  double leucine = 0.0;
  double lysine = 0.0;
  double methionine = 0.0;
  double phenylalanine = 0.0;
  double valine = 0.0;
  double histidine = 0.0;

  // Non-Essential / Semi-Essential
  double arginine = 0.0;
  double cystine = 0.0;
  double tyrosine = 0.0;
  double alanine = 0.0;
  double asparticAcid = 0.0;
  double glutamicAcid = 0.0;
  double glycine = 0.0;
  double proline = 0.0;
  double serine = 0.0;

  double? lastUsedAmount;
  String? lastUsedUnit;
}

@embedded
class ConsumedFood {
  int? foodId;
  String? name;
  double amount = 0.0;
  String unit = 'g';

  double calories = 0.0;
  double protein = 0.0;
  double carbs = 0.0;
  double fat = 0.0;

  double fiber = 0.0;
  double sugars = 0.0;
  double satFat = 0.0;
  double cholesterol = 0.0;
  double omega3 = 0.0;
  double omega6 = 0.0;

  double vitA = 0.0;
  double vitC = 0.0;
  double vitD = 0.0;
  double vitE = 0.0;
  double vitK = 0.0;
  double thiamine = 0.0;
  double riboflavin = 0.0;
  double niacin = 0.0;
  double pantothenicAcid = 0.0;
  double vitB6 = 0.0;
  double biotin = 0.0;
  double folate = 0.0;
  double vitB12 = 0.0;
  double choline = 0.0;

  double calcium = 0.0;
  double iron = 0.0;
  double magnesium = 0.0;
  double phosphorus = 0.0;
  double potassium = 0.0;
  double sodium = 0.0;
  double zinc = 0.0;
  double copper = 0.0;
  double manganese = 0.0;
  double selenium = 0.0;
  double iodine = 0.0;

  double tryptophan = 0.0;
  double threonine = 0.0;
  double isoleucine = 0.0;
  double leucine = 0.0;
  double lysine = 0.0;
  double methionine = 0.0;
  double phenylalanine = 0.0;
  double valine = 0.0;
  double histidine = 0.0;
  double arginine = 0.0;
  double cystine = 0.0;
  double tyrosine = 0.0;
  double alanine = 0.0;
  double asparticAcid = 0.0;
  double glutamicAcid = 0.0;
  double glycine = 0.0;
  double proline = 0.0;
  double serine = 0.0;
}

@embedded
class Meal {
  String name = 'Meal';
  List<ConsumedFood> items = [];
  String time = '';
}

@collection
class DailyDiet {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  List<Meal> meals = [];
  List<ConsumedFood> supplements = [];

  double get totalCalories =>
      meals.fold(
        0.0,
        (sum, m) => sum + m.items.fold(0.0, (s, i) => s + i.calories),
      ) +
      supplements.fold(0.0, (sum, i) => sum + i.calories);

  double get totalProtein =>
      meals.fold(
        0.0,
        (sum, m) => sum + m.items.fold(0.0, (s, i) => s + i.protein),
      ) +
      supplements.fold(0.0, (sum, i) => sum + i.protein);

  double get totalCarbs =>
      meals.fold(
        0.0,
        (sum, m) => sum + m.items.fold(0.0, (s, i) => s + i.carbs),
      ) +
      supplements.fold(0.0, (sum, i) => sum + i.carbs);

  double get totalFat =>
      meals.fold(
        0.0,
        (sum, m) => sum + m.items.fold(0.0, (s, i) => s + i.fat),
      ) +
      supplements.fold(0.0, (sum, i) => sum + i.fat);

  double get totalMagnesium =>
      meals.fold(
        0.0,
        (sum, m) => sum + m.items.fold(0.0, (s, i) => s + i.magnesium),
      ) +
      supplements.fold(0.0, (sum, i) => sum + i.magnesium);
}

@collection
class DietTemplate {
  Id id = Isar.autoIncrement;

  late String name;
  List<Meal> meals = [];
  List<ConsumedFood> supplements = [];
  List<int> scheduledDays = [];
}
