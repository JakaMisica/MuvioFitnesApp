part of 'workout_cubit.dart';

class RestTimerState extends Equatable {
  final int exerciseLogId;
  final int setIndex; // Index of the next set to highlight
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;
  final int remainingSeconds;

  const RestTimerState({
    required this.exerciseLogId,
    required this.setIndex,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.remainingSeconds,
  });

  bool get isActive => remainingSeconds > 0;

  RestTimerState copyWith({
    int? exerciseLogId,
    int? setIndex,
    DateTime? startTime,
    DateTime? endTime,
    int? durationSeconds,
    int? remainingSeconds,
  }) {
    return RestTimerState(
      exerciseLogId: exerciseLogId ?? this.exerciseLogId,
      setIndex: setIndex ?? this.setIndex,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }

  @override
  List<Object?> get props => [
    exerciseLogId,
    setIndex,
    startTime,
    endTime,
    durationSeconds,
    remainingSeconds,
  ];
}

class TutTimerState extends Equatable {
  final int exerciseLogId;
  final int setIndex;
  final int elapsedSeconds;
  final bool isPreparing;
  final int prepRemainingSeconds;
  final int totalPrepSeconds; // ← NEW: to compute progress fraction correctly

  const TutTimerState({
    required this.exerciseLogId,
    required this.setIndex,
    this.elapsedSeconds = 0,
    this.isPreparing = false,
    this.prepRemainingSeconds = 0,
    this.totalPrepSeconds = 5,
  });

  TutTimerState copyWith({
    int? exerciseLogId,
    int? setIndex,
    int? elapsedSeconds,
    bool? isPreparing,
    int? prepRemainingSeconds,
    int? totalPrepSeconds,
  }) {
    return TutTimerState(
      exerciseLogId: exerciseLogId ?? this.exerciseLogId,
      setIndex: setIndex ?? this.setIndex,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isPreparing: isPreparing ?? this.isPreparing,
      prepRemainingSeconds: prepRemainingSeconds ?? this.prepRemainingSeconds,
      totalPrepSeconds: totalPrepSeconds ?? this.totalPrepSeconds,
    );
  }

  @override
  List<Object?> get props => [
    exerciseLogId,
    setIndex,
    elapsedSeconds,
    isPreparing,
    prepRemainingSeconds,
    totalPrepSeconds,
  ];
}

class WorkoutState extends Equatable {
  final DateTime selectedDate;
  final bool isLoading;
  final WorkoutDay? workoutDay;
  final double completionProgress; // 0.0 to 1.0
  final RestTimerState? restTimer;
  final TutTimerState? tutTimer;
  final AutoWorkoutConfig? autoConfig;

  final Set<int> expandedExerciseIds;
  final int? lastExpandedLogId;

  const WorkoutState({
    required this.selectedDate,
    this.isLoading = false,
    this.workoutDay,
    this.completionProgress = 0.0,
    this.restTimer,
    this.tutTimer,
    this.autoConfig,
    this.expandedExerciseIds = const {},
    this.lastExpandedLogId,
  });

  factory WorkoutState.initial() {
    return WorkoutState(selectedDate: DateTime.now());
  }

  WorkoutState copyWith({
    DateTime? selectedDate,
    bool? isLoading,
    WorkoutDay? workoutDay,
    double? completionProgress,
    RestTimerState? restTimer,
    bool clearRestTimer = false,
    TutTimerState? tutTimer,
    bool clearTutTimer = false,
    AutoWorkoutConfig? autoConfig,
    Set<int>? expandedExerciseIds,
    int? lastExpandedLogId,
    bool clearLastExpanded = false,
  }) {
    return WorkoutState(
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      workoutDay: workoutDay ?? this.workoutDay,
      completionProgress: completionProgress ?? this.completionProgress,
      restTimer: clearRestTimer ? null : (restTimer ?? this.restTimer),
      tutTimer: clearTutTimer ? null : (tutTimer ?? this.tutTimer),
      autoConfig: autoConfig ?? this.autoConfig,
      expandedExerciseIds: expandedExerciseIds ?? this.expandedExerciseIds,
      lastExpandedLogId: clearLastExpanded
          ? null
          : (lastExpandedLogId ?? this.lastExpandedLogId),
    );
  }

  @override
  List<Object?> get props => [
    selectedDate,
    isLoading,
    workoutDay,
    completionProgress,
    restTimer,
    tutTimer,
    autoConfig,
    expandedExerciseIds,
    lastExpandedLogId,
  ];
}
