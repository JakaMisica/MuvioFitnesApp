import 'package:get_it/get_it.dart';
import 'data/datasources/isar_service.dart';
import 'data/repositories/workout_repository.dart';
import 'data/repositories/task_repository.dart';
import 'data/repositories/body_repository.dart';
import 'data/repositories/diet_repository.dart';
import 'data/repositories/fatigue_repository.dart';
import 'data/repositories/analytics_repository.dart';
import 'data/repositories/sleep_repository.dart';
import 'data/repositories/chat_repository.dart';
import 'data/repositories/social_repository.dart';
import 'core/services/sleep_analysis_service.dart';
import 'core/services/ai_service.dart';
import 'core/services/biological_data_context_service.dart';
import 'core/services/referral_service.dart';
import 'core/services/step_tracker_service.dart';
import 'core/services/coach_service.dart';
import 'data/repositories/coach_repository.dart';
import 'logic/cubit/workout/workout_cubit.dart';
import 'logic/cubit/sleep/sleep_cubit.dart';
import 'logic/cubit/social/social_cubit.dart';
import 'logic/cubit/evolution/evolution_cubit.dart';
import 'logic/cubit/evolution/evolution_state.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<IsarService>(() => IsarService());
  locator.registerLazySingleton<SleepAnalysisService>(
    () => SleepAnalysisService(),
  );
  locator.registerLazySingleton<AiService>(() => AiService());
  locator.registerLazySingleton<BiologicalDataContextService>(
    () => BiologicalDataContextService(),
  );
  locator.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepository(locator<IsarService>()),
  );
  locator.registerLazySingleton(() => TaskRepository(locator<IsarService>()));
  locator.registerLazySingleton(() => BodyRepository(locator<IsarService>()));
  locator.registerLazySingleton(() => DietRepository(locator<IsarService>()));
  locator.registerLazySingleton(
    () => FatigueRepository(locator<IsarService>()),
  );
  locator.registerLazySingleton(
    () => AnalyticsRepository(
      locator<IsarService>(),
      locator<BodyRepository>(),
      locator<DietRepository>(),
      locator<TaskRepository>(),
      locator<WorkoutRepository>(),
      locator<FatigueRepository>(),
    ),
  );
  locator.registerLazySingleton(() => SleepRepository(locator<IsarService>()));
  locator.registerLazySingleton(() => ChatRepository(locator<IsarService>()));
  locator.registerLazySingleton(() => SocialRepository(locator<IsarService>()));
  locator.registerLazySingleton<ReferralService>(() => ReferralService());
  locator.registerLazySingleton<StepTrackerService>(() => StepTrackerService());
  locator.registerLazySingleton(() => CoachRepository(locator<IsarService>()));
  locator.registerLazySingleton(() => CoachService());

  // Register Cubits last to ensure all repositories are ready
  locator.registerSingleton<WorkoutCubit>(WorkoutCubit());
  locator.registerSingleton<SleepCubit>(SleepCubit());
  locator.registerSingleton<SocialCubit>(SocialCubit());
  locator.registerSingleton<EvolutionCubit>(
    EvolutionCubit(locator<BodyRepository>()),
  );
}
