import 'package:isar/isar.dart';

part 'user_settings.g.dart';

@collection
class UserSettings {
  Id id = 0; // Only one instance

  List<String> availableKgPlates = [
    "0.5:10",
    "1.25:10",
    "2.5:10",
    "5:10",
    "10:10",
    "15:10",
    "20:10",
    "25:10",
  ];
  List<String> availableLbsPlates = [
    "1.25:10",
    "2.5:10",
    "5:10",
    "10:10",
    "25:10",
    "35:10",
    "45:10",
  ];

  bool useKgAsDefault = true;

  // Profile settings for calculations
  int age = 25;
  String gender = "male"; // male, female
  bool useKgForGrip = true;
  double heightCm = 175.0;
  bool useMetricHeight = true;
  String goal = "Build Muscle"; // Build Muscle, Burn Fat, Performance, Recovery
  bool isProfileComplete = false;
  bool useLbsForVolume = false;
  bool showExtraMetrics = false;
  bool useMetricMeasurements = true; // true = cm, false = feet

  // AI Messaging & Subscription
  int totalFreeAiMessages = 5;
  int usedAiMessages = 0;
  bool isPremium = false;

  // Referral system
  bool hasProcessedReferral = false;

  // Dev Persistent Login
  bool devPersistLogin = false;

  bool isGuidedBreathingEnabled = false;
  
  // Tracking for Coaching system
  DateTime? lastAppOpenDate;
  DateTime? lastWorkoutDate;
  int? activeCoachId; // ID of the currently selected coach
  
  // AI Call Feature
  bool isAiCallEnabled = true;
  DateTime? nextAiCallAllowedDate;
  int consecutiveGetLostCount = 0;
  DateTime? lastWorkoutFinishTime;
  bool isAiCallActive = false;
  
  // Persistent Rest Timer
  DateTime? restTimerEndTime;
  int? restTimerExerciseLogId;
  int? restTimerNextSetIndex;
  int? restTimerTotalDuration;
  
  String? socialUserName;
  String? socialUserId;
  
  bool isSick = false;
  bool isInjured = false;
  int workoutFrequencyDays = 3; // How often the AI expects a workout
  DateTime? lastSetCompletedDate;

  List<int> expandedExerciseIds = [];

  // Point System
  int musclePoints = 0;
  int coins = 0;
  DateTime? lastMusclePointTime;
  
  // Daily Reward Tracking
  DateTime? lastRewardResetDate;
  int todayDietCoinsCount = 0;
  List<String> rewardedTaskNamesToday = [];
  
  // Social Points Tracking (🕶️)
  int socialPoints = 0;
  int todayMessageRewardsCount = 0;
  int todaySnapRewardsCount = 0;
}
