import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

part 'task_item.g.dart';

@collection
class TaskItem {
  Id id = Isar.autoIncrement;

  late String name;

  @Index()
  late bool isNote;

  String? group; // New: grouping for tasks

  // Sentiment: -1.0 (Addiction/Red) to 0.0 (Neutral/Gray) to 1.0 (Good/Green)
  @Index()
  late double sentiment;

  @Index()
  late int orderIndex;

  // Metric flags
  late bool hasTimeMetric;
  late bool hasDistanceMetric;
  late bool hasDoseMetric;
  late bool hasCounterMetric;
  late bool hasWeightMetric;
  late bool hasEnergyMetric;
  late bool hasRatingMetric;
  late bool hasPercentageMetric;
  late bool hasFinancialMetric;

  // Timer configuration
  // 0 = None, 1 = Countdown, 2 = Stopwatch, 3 = Alarm
  late int timerType;
  late int targetSeconds; // For countdown timer
  late int currentSeconds; // Current timer value

  // Alarm configuration
  String? alarmTime; // e.g. "08:30"
  String? alarmSoundPath; // Path to custom mp3

  // Metric values
  late int counterValue;
  late int counterMax; // New: optional maximum for counter
  late double distanceValue; // in km
  late String doseValue;
  late double weightValue; // in kg/lbs
  late double energyValue; // calories
  late int ratingValue; // 1-10 scale
  late double percentageValue; // 0-100
  late double financialValue; // monetary amount
  late String currency; // USD, EUR, GBP, etc.
  late String notes; // New: notes field
  late List<String> imagePaths; // New: list of image paths

  // Completion tracking
  DateTime? lastCompleted;
  DateTime? lastEditedDate;
  late bool isTimerRunning;

  // Recurrence settings
  // 0 = None, 1 = Daily, 2 = Weekly, 3 = Specific Days, 4 = Monthly
  late int recurrenceType;
  // For "Specific Days" - comma-separated day numbers (1=Mon, 7=Sun)
  late String specificDays; // e.g., "1,3,5" for Mon/Wed/Fri
  DateTime? lastReset; // Track when task was last reset

  // RAS / Hourly Chime configuration
  late bool isHourlyChimeEnabled;
  late int chimeIntervalMinutes; // e.g., 60 for every hour
  late int chimeStartHour; // 0-23
  late int chimeEndHour; // 0-23
  DateTime? lastChimeTime;

  // Double Timer (Study/Break)
  late bool isDoubleTimer;
  late int breakTargetSeconds;
  late bool isWorkPeriod; // true = work, false = break

  TaskItem({
    this.name = '',
    this.isNote = false,
    this.group,
    this.sentiment = 0.0,
    this.orderIndex = 0,
    this.hasTimeMetric = false,
    this.hasDistanceMetric = false,
    this.hasDoseMetric = false,
    this.hasCounterMetric = false,
    this.hasWeightMetric = false,
    this.hasEnergyMetric = false,
    this.hasRatingMetric = false,
    this.hasPercentageMetric = false,
    this.hasFinancialMetric = false,
    this.timerType = 0,
    this.targetSeconds = 0,
    this.currentSeconds = 0,
    this.alarmTime,
    this.alarmSoundPath,
    this.counterValue = 0,
    this.counterMax = 0,
    this.distanceValue = 0.0,
    this.doseValue = '',
    this.weightValue = 0.0,
    this.energyValue = 0.0,
    this.ratingValue = 5,
    this.percentageValue = 0.0,
    this.financialValue = 0.0,
    this.currency = 'USD',
    this.notes = '',
    this.imagePaths = const [],
    this.lastCompleted,
    this.lastEditedDate,
    this.isTimerRunning = false,
    this.recurrenceType = 0,
    this.specificDays = '',
    this.lastReset,
    this.isHourlyChimeEnabled = false,
    this.chimeIntervalMinutes = 60,
    this.chimeStartHour = 8,
    this.chimeEndHour = 22,
    this.lastChimeTime,
    this.isDoubleTimer = false,
    this.breakTargetSeconds = 300, // Default 5 min
    this.isWorkPeriod = true,
  });

  // Helper to get sentiment-based color
  Color getSentimentColor() {
    if (sentiment < -0.3) {
      // Extremely Subtle & Dark Addiction hint
      return Color.lerp(
        Colors.grey.shade700,
        Colors.red.shade900.withOpacity(0.15),
        (sentiment.abs() - 0.3) / 0.7,
      )!;
    } else if (sentiment > 0.3) {
      // Extremely Subtle & Dark Good hint
      return Color.lerp(
        Colors.grey.shade700,
        Colors.teal.shade900.withOpacity(0.1),
        (sentiment - 0.3) / 0.7,
      )!;
    } else {
      // Neutral - Lighter, more visible grey (kept as is)
      return Colors.grey.shade700;
    }
  }
}
