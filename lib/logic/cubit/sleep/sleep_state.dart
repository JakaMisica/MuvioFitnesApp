part of 'sleep_cubit.dart';

class SleepState extends Equatable {
  final bool isTracking;
  final SleepSession? currentSession;
  final SleepSession? latestSession;
  final SleepSettings? settings;
  final List<SleepSession> history;
  final DateTime? smartAlarmStart;
  final DateTime? smartAlarmEnd;
  final double sensitivity;
  final bool isLoading;
  final bool isAiReady;
  final int detectedEventsCount;
  final bool alarmTriggered;
  final int snoozeDurationMinutes;
  final bool isSmartAlarmEnabled;
  final int smartAlarmWindowMinutes;

  const SleepState({
    required this.isTracking,
    this.currentSession,
    this.latestSession,
    this.settings,
    this.history = const [],
    this.smartAlarmStart,
    this.smartAlarmEnd,
    required this.sensitivity,
    required this.isLoading,
    this.isAiReady = false,
    this.detectedEventsCount = 0,
    this.alarmTriggered = false,
    this.snoozeDurationMinutes = 15,
    this.isSmartAlarmEnabled = false,
    this.smartAlarmWindowMinutes = 30,
  });

  factory SleepState.initial() => const SleepState(
    isTracking: false,
    sensitivity: 0.5,
    isLoading: false,
    isAiReady: false,
    detectedEventsCount: 0,
    alarmTriggered: false,
    snoozeDurationMinutes: 15,
    isSmartAlarmEnabled: false,
    smartAlarmWindowMinutes: 30,
  );

  SleepState copyWith({
    bool? isTracking,
    SleepSession? currentSession,
    SleepSession? latestSession,
    SleepSettings? settings,
    List<SleepSession>? history,
    DateTime? smartAlarmStart,
    DateTime? smartAlarmEnd,
    double? sensitivity,
    bool? isLoading,
    bool? isAiReady,
    int? detectedEventsCount,
    bool? alarmTriggered,
    int? snoozeDurationMinutes,
    bool? isSmartAlarmEnabled,
    int? smartAlarmWindowMinutes,
  }) {
    return SleepState(
      isTracking: isTracking ?? this.isTracking,
      currentSession: currentSession ?? this.currentSession,
      latestSession: latestSession ?? this.latestSession,
      settings: settings ?? this.settings,
      history: history ?? this.history,
      smartAlarmStart: smartAlarmStart ?? this.smartAlarmStart,
      smartAlarmEnd: smartAlarmEnd ?? this.smartAlarmEnd,
      sensitivity: sensitivity ?? this.sensitivity,
      isLoading: isLoading ?? this.isLoading,
      isAiReady: isAiReady ?? this.isAiReady,
      detectedEventsCount: detectedEventsCount ?? this.detectedEventsCount,
      alarmTriggered: alarmTriggered ?? this.alarmTriggered,
      snoozeDurationMinutes:
          snoozeDurationMinutes ?? this.snoozeDurationMinutes,
      isSmartAlarmEnabled: isSmartAlarmEnabled ?? this.isSmartAlarmEnabled,
      smartAlarmWindowMinutes:
          smartAlarmWindowMinutes ?? this.smartAlarmWindowMinutes,
    );
  }

  @override
  List<Object?> get props => [
    isTracking,
    currentSession,
    latestSession,
    settings,
    history,
    smartAlarmStart,
    smartAlarmEnd,
    sensitivity,
    isLoading,
    isAiReady,
    detectedEventsCount,
    alarmTriggered,
    snoozeDurationMinutes,
    isSmartAlarmEnabled,
    smartAlarmWindowMinutes,
  ];
}
