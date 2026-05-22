import 'package:isar/isar.dart';
import 'enums.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String name;

  @Enumerated(EnumType.name)
  late MuscleGroup muscleGroup;

  String? subGroup; // e.g. Upper Chest

  @Enumerated(EnumType.name)
  WeightUnit defaultUnit = WeightUnit.kg;

  double weightIncrement = 2.5;
  double repsIncrement = 1.0;

  bool isIsolate = false; // Isolate Left/Right feature

  bool hasCablePosition = false;
  bool hasBenchPosition = false;

  double barbellWeight = 20.0;

  bool isCustom = true;

  // New tracking options
  bool trackWeightReps = true;
  bool trackDistance = false;
  String? distanceUnit; // meters, km, ft, miles

  bool trackSpeed = false;
  String? speedUnit; // km/h, mph, m/s

  bool trackCalories = false;
  String? caloriesUnit; // cal, kcal, kJ

  // Fatigue tracking: secondary muscle groups affected by this exercise
  // E.g., bench press might affect: [SHOULDERS, TRICEPS]
  List<String> secondaryMuscleGroups = [];

  // Fatigue tracking: secondary muscle engagement percentages
  // E.g., for overhead press: {"Triceps": 20, "Shoulders": 30}
  // Format: "MuscleGroup:percentage"
  List<String> secondaryMuscleEngagementMap = [];

  // Fatigue tracking: subgroup engagement percentages
  // E.g., for bench press: {"Upper": 30, "Middle": 50, "Lower": 20}
  // Values should sum to 100 for the primary muscle group
  // Format: "subGroupName:percentage"
  List<String> subGroupEngagementMap = [];

  /// Helper to get secondary muscle engagement as a map
  @ignore
  Map<String, double> get secondaryMuscleEngagement {
    final map = <String, double>{};
    for (final entry in secondaryMuscleEngagementMap) {
      final lastColon = entry.lastIndexOf(':');
      if (lastColon != -1) {
        final key = entry.substring(0, lastColon);
        final valStr = entry.substring(lastColon + 1);
        map[key] = double.tryParse(valStr) ?? 0.0;
      }
    }
    return map;
  }

  /// Helper to set secondary muscle engagement from a map
  void setSecondaryMuscleEngagement(Map<String, double> engagement) {
    // Recreate the list to ensure change detection
    secondaryMuscleEngagementMap = List<String>.from(
      engagement.entries.map((e) => '${e.key}:${e.value}'),
    );
    // Also sync the generic muscle groups list for redundancy and change detection
    secondaryMuscleGroups = engagement.keys
        .map((k) => k.split(':').first)
        .toSet()
        .toList();
  }

  /// Helper to get subgroup engagement as a map
  @ignore
  Map<String, double> get subGroupEngagement {
    final map = <String, double>{};
    for (final entry in subGroupEngagementMap) {
      final parts = entry.split(':');
      if (parts.length == 2) {
        map[parts[0]] = double.tryParse(parts[1]) ?? 0.0;
      }
    }
    return map;
  }

  /// Helper to set subgroup engagement from a map
  void setSubGroupEngagement(Map<String, double> engagement) {
    subGroupEngagementMap = engagement.entries
        .map((e) => '${e.key}:${e.value}')
        .toList();
  }
}
