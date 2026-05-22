import 'package:isar/isar.dart';
import 'exercise.dart';

part 'workout_day.g.dart';

@collection
class WorkoutDay {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date; // Store as dateOnly (normalized to midnight)

  bool isRestDay = false;
  int? templateId;

  final exercises = IsarLinks<WorkoutExerciseLog>();

  int steps = 0;
  double distanceMeters = 0.0;
}

@collection
class WorkoutExerciseLog {
  Id id = Isar.autoIncrement;

  final exercise = IsarLink<Exercise>();

  List<WorkoutSet> sets = [];

  String? notes;

  int orderIndex = 0;
}

@embedded
class DropSetItem {
  double? weight;
  int? reps;
  bool isCompleted = false;
  int? tutSeconds;
  bool pointsEarned = false;
}

@embedded
class WorkoutSet {
  double? weight;
  int? reps;
  bool isCompleted = false;

  // For Isolate exercises (Left/Right)
  String? side; // "L", "R", null

  // Training Techniques
  int? rir; // Reps in reserve (0-10)
  bool isFailure = false;
  int? spotReps; // Number of reps with spotter
  bool isTutEnabled = true;

  // Myo Reps
  int? myoReps;
  int? myoPauseSeconds;

  // Advanced
  int? partialReps;
  bool isDropSet = false;
  bool isWarmUp = false;

  // Multiple Drop Sets nested under a single main set
  List<DropSetItem> dropSetItems = [];

  // Tempo (in seconds)
  int? eccentricSeconds;
  int? concentricSeconds;
  int? isometricSeconds;

  // Rest Timer
  bool isRestTimerEnabled = true;
  int? restDuration; // Default duration in seconds (90 normal, 45 isolate)

  // Equipment Settings
  int? cablePosition;
  int? benchPosition;

  bool isPr = false;
  bool isTodayPr = false;

  // Cardio Data
  double? distance;
  double? speed;
  double? calories;

  // Completion Timing & TUT
  DateTime? timeCompleted;
  int? tutSeconds;
  int tutPrepSeconds = 5;
  bool pointsEarned = false;

  WorkoutSet copyWith({
    double? weight,
    int? reps,
    bool? isCompleted,
    String? side,
    int? rir,
    bool? isFailure,
    int? spotReps,
    bool? isTutEnabled,
    int? myoReps,
    int? myoPauseSeconds,
    int? partialReps,
    bool? isDropSet,
    bool? isWarmUp,
    List<DropSetItem>? dropSetItems,
    int? eccentricSeconds,
    int? concentricSeconds,
    int? isometricSeconds,
    bool? isRestTimerEnabled,
    int? restDuration,
    int? cablePosition,
    int? benchPosition,
    bool? isPr,
    bool? isTodayPr,
    double? distance,
    double? speed,
    double? calories,
    DateTime? timeCompleted,
    int? tutSeconds,
    int? tutPrepSeconds,
    bool? pointsEarned,
  }) {
    return WorkoutSet()
      ..weight = weight ?? this.weight
      ..reps = reps ?? this.reps
      ..isCompleted = isCompleted ?? this.isCompleted
      ..side = side ?? this.side
      ..rir = rir ?? this.rir
      ..isFailure = isFailure ?? this.isFailure
      ..spotReps = spotReps ?? this.spotReps
      ..isTutEnabled = isTutEnabled ?? this.isTutEnabled
      ..myoReps = myoReps ?? this.myoReps
      ..myoPauseSeconds = myoPauseSeconds ?? this.myoPauseSeconds
      ..partialReps = partialReps ?? this.partialReps
      ..isDropSet = isDropSet ?? this.isDropSet
      ..isWarmUp = isWarmUp ?? this.isWarmUp
      ..dropSetItems = dropSetItems ?? List.from(this.dropSetItems)
      ..eccentricSeconds = eccentricSeconds ?? this.eccentricSeconds
      ..concentricSeconds = concentricSeconds ?? this.concentricSeconds
      ..isometricSeconds = isometricSeconds ?? this.isometricSeconds
      ..isRestTimerEnabled = isRestTimerEnabled ?? this.isRestTimerEnabled
      ..restDuration = restDuration ?? this.restDuration
      ..cablePosition = cablePosition ?? this.cablePosition
      ..benchPosition = benchPosition ?? this.benchPosition
      ..isPr = isPr ?? this.isPr
      ..isTodayPr = isTodayPr ?? this.isTodayPr
      ..distance = distance ?? this.distance
      ..speed = speed ?? this.speed
      ..calories = calories ?? this.calories
      ..timeCompleted = timeCompleted ?? this.timeCompleted
      ..tutSeconds = tutSeconds ?? this.tutSeconds
      ..tutPrepSeconds = tutPrepSeconds ?? this.tutPrepSeconds
      ..pointsEarned = pointsEarned ?? this.pointsEarned;
  }
}
