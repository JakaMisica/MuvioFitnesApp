import 'package:isar/isar.dart';

part 'analytics_experiment.g.dart';

@collection
class AnalyticsExperiment {
  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String variableChanged; // e.g. "Magnesium Supplement"

  late DateTime startDate;
  DateTime? endDate; // Null if ongoing

  // Stored as JSON or separate child objects for simplicity in Isar
  List<String> trackedMetricKeys = []; // e.g. ["grip", "gains", "fatigue"]

  bool isActive = true;
}

enum AnalyticsMetricType {
  gripStrength,
  muscleGains,
  fatigueIndex,
  workoutPerformance, // 1RM average
  bodyFat,
  bodyWeight,
  proteinIntake,
  fatIntake,
  carbsIntake,
  calorieIntake,
  sleepQuality,
  stressLevel,
  measurementNeck,
  measurementChest,
  measurementWaist,
  measurementHips,
  measurementLeftArm,
  measurementRightArm,
  measurementLeftForearm,
  measurementRightForearm,
  measurementLeftThigh,
  measurementRightThigh,
  measurementLeftCalf,
  measurementRightCalf,
  steps,
  distance,
}
