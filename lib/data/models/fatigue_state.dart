import 'package:isar/isar.dart';

part 'fatigue_state.g.dart';

/// Tracks real-time fatigue for muscle groups and subgroups
@collection
class FatigueState {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime workoutDate;
  late String muscleGroup; // e.g., "CHEST", "BACK"
  String? subGroup; // e.g., "Lower", "Upper", "Middle"
  String? side; // "L", "R", or null for bilateral

  double currentFatiguePercent = 0.0; // 0-100%
  double peakFatiguePercent = 0.0; // The highest fatigue reached during this session
  DateTime lastUpdateTime = DateTime.now();

  // Historical performance tracking
  List<FatigueSnapshot> snapshots = [];

  @Index()
  String get compositeKey =>
      '${workoutDate.toIso8601String()}_${muscleGroup}_${side ?? "B"}';
}

/// Individual performance snapshot for fatigue analysis
@embedded
class FatigueSnapshot {
  late DateTime timestamp;
  int setNumber = 0;
  double performanceDrop = 0.0; // % drop from baseline (0-100)
  int restSeconds = 0;
  double weight = 0.0;
  int reps = 0;

  // Position info for position-based analysis
  int? cablePosition;
  int? benchPosition;
}
