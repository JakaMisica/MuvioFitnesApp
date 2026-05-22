import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/exercise.dart';
import '../models/workout_day.dart';
import '../models/workout_template.dart';
import '../models/user_settings.dart';
import '../models/fatigue_state.dart';
import '../models/task_item.dart';
import '../models/task_history.dart';
import '../models/body_metric.dart';
import '../models/diet_models.dart';
import '../models/analytics_experiment.dart';
import '../models/sleep_models.dart';
import '../models/auto_workout_config.dart';
import '../models/chat_models.dart';
import '../models/coach_model.dart';
import '../models/social_models.dart';

import 'dart:io';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    debugPrint('IsarService: _initDb() started');
    try {
      if (Isar.instanceNames.isEmpty) {
        debugPrint('IsarService: No instances found. Getting application support directory...');
        final dir = await getApplicationSupportDirectory();
        
        final separator = Platform.pathSeparator;
        final path = '${dir.path}${separator}biofit_pro_db';
        debugPrint('IsarService: Database path: $path');

        final dbDir = Directory(path);
        if (!await dbDir.exists()) {
          debugPrint('IsarService: Creating database directory...');
          await dbDir.create(recursive: true);
        }

        debugPrint('IsarService: Calling Isar.open()...');
        final isar = await Isar.open(
          [
            ExerciseSchema,
            WorkoutDaySchema,
            WorkoutExerciseLogSchema,
            WorkoutTemplateSchema,
            TemplateFolderSchema,
            TemplateExerciseSchema,
            UserSettingsSchema,
            FatigueStateSchema,
            TaskItemSchema,
            TaskHistorySchema,
            BodyMetricSchema,
            DailyDietSchema,
            FoodItemSchema,
            DietTemplateSchema,
            AnalyticsExperimentSchema,
            SleepSessionSchema,
            SleepSettingsSchema,
            AutoWorkoutConfigSchema,
            ChatSessionSchema,
            ChatMessageSchema,
            CoachModelSchema,
            SocialConversationSchema,
            SocialMessageSchema,
          ],
          directory: dbDir.path,
          inspector: false, // Temporarily disabled to debug Hot Restart hang
        );
        debugPrint('IsarService: Isar.open() completed successfully.');
        return isar;
      }
      debugPrint('IsarService: Using existing instance via getInstance()');
      return Isar.getInstance()!;
    } catch (e, stack) {
      debugPrint('IsarService: ERROR during initialization: $e');
      debugPrint(stack.toString());
      rethrow;
    }
  }

  // Generic Helpers
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
