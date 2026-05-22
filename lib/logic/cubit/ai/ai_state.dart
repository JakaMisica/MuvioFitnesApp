part of 'ai_cubit.dart';

class AiState extends Equatable {
  final List<Map<String, String>> messages;
  final bool isLoading;
  final bool useCoT;
  final bool useBioData;
  final AiMode mode;
  final String? error;
  final List<ChatSession> sessions;
  final int? activeSessionId;
  final bool showPaywall;

  // AI Quota
  final int usedAiMessages;
  final int totalFreeAiMessages;
  final bool isPremium;
  final String? activeCoachName;

  // Profile Context
  final String gender;
  final int age;
  final double height;
  final double weight;
  final String goal;

  const AiState({
    required this.messages,
    required this.isLoading,
    required this.useCoT,
    this.useBioData = false,
    this.mode = AiMode.general,
    this.error,
    this.gender = "male",
    this.age = 25,
    this.height = 175.0,
    this.weight = 75.0,
    this.goal = "Build Muscle",
    this.sessions = const [],
    this.activeSessionId,
    this.showPaywall = false,
    this.usedAiMessages = 0,
    this.totalFreeAiMessages = 5,
    this.isPremium = false,
    this.activeCoachName,
  });

  factory AiState.initial() => const AiState(
    messages: [],
    isLoading: false,
    useCoT: false,
    useBioData: false,
    mode: AiMode.general,
    // TESTING: set usedAiMessages = totalFreeAiMessages to trigger paywall immediately.
    // Change usedAiMessages back to 0 when done testing.
    usedAiMessages: 5,
    totalFreeAiMessages: 5,
    activeCoachName: "Biological Optimization Engine",
  );

  AiState copyWith({
    List<Map<String, String>>? messages,
    bool? isLoading,
    bool? useCoT,
    bool? useBioData,
    AiMode? mode,
    String? error,
    String? gender,
    int? age,
    double? height,
    double? weight,
    String? goal,
    List<ChatSession>? sessions,
    int? activeSessionId,
    bool? showPaywall,
    int? usedAiMessages,
    int? totalFreeAiMessages,
    bool? isPremium,
    String? activeCoachName,
  }) {
    return AiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      useCoT: useCoT ?? this.useCoT,
      useBioData: useBioData ?? this.useBioData,
      mode: mode ?? this.mode,
      error: error,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      sessions: sessions ?? this.sessions,
      activeSessionId: activeSessionId ?? this.activeSessionId,
      showPaywall: showPaywall ?? this.showPaywall,
      usedAiMessages: usedAiMessages ?? this.usedAiMessages,
      totalFreeAiMessages: totalFreeAiMessages ?? this.totalFreeAiMessages,
      isPremium: isPremium ?? this.isPremium,
      activeCoachName: activeCoachName ?? this.activeCoachName,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    isLoading,
    useCoT,
    useBioData,
    mode,
    error,
    gender,
    age,
    height,
    weight,
    goal,
    sessions,
    activeSessionId,
    showPaywall,
    usedAiMessages,
    totalFreeAiMessages,
    isPremium,
    activeCoachName,
  ];
}
