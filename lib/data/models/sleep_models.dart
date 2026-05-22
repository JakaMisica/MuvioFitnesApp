import 'package:isar/isar.dart';

part 'sleep_models.g.dart';

@collection
class SleepSession {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  late DateTime startTime;
  DateTime? endTime;

  double qualityScore = 0.0; // 0.0 to 1.0

  List<SleepStageData> stages = [];
  List<SleepEvent> events = [];

  // Settings
  double sensitivity = 0.5;
  DateTime? smartAlarmStart;
  DateTime? smartAlarmEnd;
}

@collection
class SleepSettings {
  Id id = 0; // Singleton instance

  bool autoTrackEnabled = false;

  // Day index (1=Mon, 7=Sun) -> "HH:mm-HH:mm" (Start-End)
  List<String> daySchedules = [
    "22:00-07:00", // Mon
    "22:00-07:00", // Tue
    "22:00-07:00", // Wed
    "22:00-07:00", // Thu
    "22:00-07:00", // Fri
    "23:30-09:00", // Sat
    "23:30-09:00", // Sun
  ];

  DateTime? smartAlarmStart;
  DateTime? smartAlarmEnd;
  bool isSmartAlarmEnabled = false;
  int smartAlarmWindowMinutes = 30; // 5 to 30
  String? alarmSoundPath;
  int? lastSnoozeDurationMinutes;
}

@embedded
class SleepStageData {
  late DateTime timestamp;
  @enumerated
  late SleepStage stage;
}

enum SleepStage { awake, light, deep, rem }

@embedded
class SleepEvent {
  late DateTime timestamp;
  @enumerated
  late SleepEventType type;
  double confidence = 0.0;
}

enum SleepEventType { snoring, breathing, movement }
