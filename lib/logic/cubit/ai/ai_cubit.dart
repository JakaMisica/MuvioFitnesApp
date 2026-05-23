import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../core/services/ai_service.dart';
import '../../../locator.dart';
import '../../../core/services/biological_data_context_service.dart';
import '../../../data/repositories/body_repository.dart';
import '../../../data/models/enums.dart';
import '../../../data/repositories/chat_repository.dart';
import '../../../data/models/chat_models.dart';
import '../../../data/repositories/coach_repository.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  final AiService _aiService = locator<AiService>();
  final _bioContextService = locator<BiologicalDataContextService>();
  final _bodyRepository = locator<BodyRepository>();
  final _chatRepo = locator<ChatRepository>();
  final _coachRepository = locator<CoachRepository>();

  StreamSubscription? _userSettingsSubscription;

  AiCubit() : super(AiState.initial()) {
    _init();
  }

  void _init() async {
    await loadUserContext();
    await loadSessions();
    await _loadQuota();

    // Listen for setting changes (coach rename etc)
    _userSettingsSubscription = _bodyRepository.watchUserSettings().listen((
      settings,
    ) {
      if (settings != null) {
        _loadCoachIdentity();
      }
    });

    _loadCoachIdentity();
  }

  void _loadCoachIdentity() async {
    final settings = await _bodyRepository.getUserSettings();
    if (settings.activeCoachId != null) {
      final coach = await _coachRepository.getCoach(settings.activeCoachId!);
      if (coach != null) {
        emit(state.copyWith(activeCoachName: coach.name));
      }
    }
  }

  Future<void> _loadQuota() async {
    final settings = await _bodyRepository.getUserSettings();
    final total = settings.totalFreeAiMessages >= 100
        ? settings.totalFreeAiMessages
        : 100;
    final used = settings.usedAiMessages.clamp(0, total);

    if (settings.totalFreeAiMessages != total ||
        settings.usedAiMessages != used) {
      settings.totalFreeAiMessages = total;
      settings.usedAiMessages = used;
      await _bodyRepository.saveUserSettings(settings);
    }

    emit(
      state.copyWith(
        usedAiMessages: used,
        totalFreeAiMessages: total,
        isPremium: settings.isPremium,
      ),
    );
  }

  Future<void> grantFreeMessages(int count) async {
    final settings = await _bodyRepository.getUserSettings();
    settings.totalFreeAiMessages = settings.totalFreeAiMessages + count;
    await _bodyRepository.saveUserSettings(settings);
    emit(
      state.copyWith(
        totalFreeAiMessages: settings.totalFreeAiMessages,
        showPaywall: false,
      ),
    );
  }

  Future<void> activatePremium() async {
    final settings = await _bodyRepository.getUserSettings();
    settings.isPremium = true;
    await _bodyRepository.saveUserSettings(settings);
    emit(state.copyWith(isPremium: true, showPaywall: false));
  }

  void dismissPaywall() {
    emit(state.copyWith(showPaywall: false));
  }

  Future<void> loadSessions() async {
    final sessions = await _chatRepo.getAllSessions();
    emit(state.copyWith(sessions: sessions));
  }

  Future<void> switchToSession(int sessionId) async {
    final session = await _chatRepo.getSession(sessionId);
    if (session != null) {
      final msgs = session.messages
          .map((m) => {'role': m.role, 'content': m.content})
          .toList();
      emit(
        state.copyWith(
          messages: msgs,
          activeSessionId: session.id,
          mode: session.mode,
        ),
      );
    }
  }

  Future<void> deleteSession(int sessionId) async {
    await _chatRepo.deleteSession(sessionId);
    if (state.activeSessionId == sessionId) {
      clearChat();
    }
    loadSessions();
  }

  Future<void> loadUserContext() async {
    final settings = await _bodyRepository.getUserSettings();
    final latestMetric = await _bodyRepository.getLatestMetric();

    String coachName = "Biological Optimization Engine";
    if (settings.activeCoachId != null) {
      final coach = await _coachRepository.getCoach(settings.activeCoachId!);
      if (coach != null) coachName = coach.name;
    }

    emit(
      state.copyWith(
        gender: settings.gender,
        age: settings.age,
        height: settings.heightCm,
        weight: latestMetric?.weight ?? 75.0,
        goal: settings.goal,
        activeCoachName: coachName,
      ),
    );
  }

  void toggleCoT(bool value) {
    emit(state.copyWith(useCoT: value));
  }

  void toggleBioData(bool value) {
    emit(state.copyWith(useBioData: value));
  }

  void setMode(AiMode mode) {
    emit(state.copyWith(mode: mode, error: null));
  }

  Future<void> addBotMessage(String text) async {
    if (state.activeSessionId == null) {
      final session = await _chatRepo.createSession(
        state.mode,
        title: "AI Assistant",
      );
      emit(state.copyWith(activeSessionId: session.id));
      loadSessions();
    }

    await _chatRepo.saveMessage(state.activeSessionId!, 'assistant', text);
    final updatedMessages = List<Map<String, String>>.from(state.messages);
    updatedMessages.add({'role': 'assistant', 'content': text});
    emit(state.copyWith(messages: updatedMessages));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    if (!state.isPremium && state.usedAiMessages >= state.totalFreeAiMessages) {
      emit(state.copyWith(showPaywall: true));
      return;
    }

    if (state.activeSessionId == null) {
      String title = text.trim();
      if (title.length > 60) title = "${title.substring(0, 57)}...";
      final session = await _chatRepo.createSession(state.mode, title: title);
      emit(state.copyWith(activeSessionId: session.id));
      loadSessions();
    }

    await _chatRepo.saveMessage(state.activeSessionId!, 'user', text);
    final updatedMessages = List<Map<String, String>>.from(state.messages);
    updatedMessages.add({'role': 'user', 'content': text});

    emit(
      state.copyWith(messages: updatedMessages, isLoading: true, error: null),
    );

    final apiMessages = List<Map<String, String>>.from(updatedMessages);

    String modeInstructions = '';
    if (state.mode == AiMode.diet) {
      modeInstructions =
          'STRICT RULE: Only generate Diet/Nutrition plans. IGNORE WORKOUT REQUESTS. Use <diet> tags.';
    } else if (state.mode == AiMode.workout) {
      modeInstructions =
          'STRICT RULE: Only generate Exercise/Workout plans. IGNORE DIET REQUESTS. Use <exercise> tags.';
    }

    String dataContext =
        "User Profile: ${state.gender}, ${state.age}yo, ${state.height}cm, ${state.weight}kg. Goal: ${state.goal}.";
    if (state.useBioData) {
      try {
        final bioData = await _bioContextService.getAIPromptContext();
        dataContext += "\n\nDETAILED BIOLOGICAL TRENDS:\n$bioData";
      } catch (e) {
        if (kDebugMode) print("Error gathering bio context: $e");
      }
    }

    String recommendationInstructions = '';
    if (state.mode == AiMode.workout) {
      recommendationInstructions =
          'Suggest exercises using <exercise> tags: {"type": "exercise_recommendation", "name": "Exercise Name", "muscleGroup": "chest", "sets": 3, "reps": 10, "weight": 20.0, "notes": "Tip", "isIsolate": false, "hasCablePosition": false, "hasBenchPosition": false}.';
    } else if (state.mode == AiMode.diet) {
      recommendationInstructions =
          'Suggest DIET plans using <diet> tags: {"type": "diet_recommendation", "name": "Plan Name", "meals": [{"name": "Meal Name", "time": "HH:mm", "items": [{"name": "Food Name", "amount": 100, "unit": "g", "calories": 200, "protein": 20, "carbs": 10, "fat": 5}]}], "supplements": [{"name": "Name", "amount": 5, "unit": "g", "calories": 0, "protein": 0, "carbs": 0, "fat": 0}]}.';
    }

    final String baseSystemPrompt =
        'You are a professional fitness and health assistant called AI COACH. CONTEXT: $dataContext $modeInstructions $recommendationInstructions';
    final finalPrompt = state.useCoT
        ? '$baseSystemPrompt Use Chain of Thought reasoning.'
        : baseSystemPrompt;

    apiMessages.insert(0, {'role': 'system', 'content': finalPrompt});
    final response = await _aiService.getResponse(apiMessages);

    if (response.startsWith('Error:')) {
      emit(state.copyWith(isLoading: false, error: response));
    } else {
      if (state.activeSessionId != null) {
        await _chatRepo.saveMessage(
          state.activeSessionId!,
          'assistant',
          response,
        );
      }
      updatedMessages.add({'role': 'assistant', 'content': response});
      if (!state.isPremium) {
        final settings = await _bodyRepository.getUserSettings();
        settings.usedAiMessages = settings.usedAiMessages + 1;
        await _bodyRepository.saveUserSettings(settings);
        emit(
          state.copyWith(
            messages: updatedMessages,
            isLoading: false,
            usedAiMessages: settings.usedAiMessages,
          ),
        );
      } else {
        emit(state.copyWith(messages: updatedMessages, isLoading: false));
      }
    }
  }

  void clearChat() {
    emit(
      AiState.initial().copyWith(
        useCoT: state.useCoT,
        mode: AiMode.general,
        gender: state.gender,
        age: state.age,
        height: state.height,
        weight: state.weight,
        goal: state.goal,
        sessions: state.sessions,
      ),
    );
  }

  @override
  Future<void> close() {
    _userSettingsSubscription?.cancel();
    return super.close();
  }
}
