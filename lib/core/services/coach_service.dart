import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/coach_model.dart';
import '../../data/repositories/coach_repository.dart';
import '../../data/repositories/body_repository.dart';
import '../../locator.dart';
import '../../logic/cubit/social/social_cubit.dart';
import 'ai_service.dart';

class CoachService {
  final _coachRepo = locator<CoachRepository>();
  final _bodyRepo = locator<BodyRepository>();
  final _aiService = locator<AiService>();

  static const String COACH_CONV_ID_PREFIX = 'coach_';

  /// Check for inactivity and send messages if needed.
  /// Should be called on app startup — runs at most once per day.
  Future<void> checkInactivity(SocialCubit socialCubit) async {
    // ── Daily guard: skip if already ran today ──────────────────────
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10); // "2026-04-13"
    final lastChecked = prefs.getString('coach_inactivity_last_check');
    if (lastChecked == today) return; // Already ran today, skip
    await prefs.setString('coach_inactivity_last_check', today);
    // ────────────────────────────────────────────────────────────────

    final settings = await _bodyRepo.getUserSettings();
    if (settings.activeCoachId == null) return;

    final coach = await _coachRepo.getCoach(settings.activeCoachId!);
    if (coach == null) return;

    final now = DateTime.now();
    final lastOpen = settings.lastAppOpenDate ?? now;
    // We update lastWorkoutDate whenever a workout is saved. 
    // If null, we assume they haven't trained since install or tracking started.
    // final lastWorkout = settings.lastWorkoutDate ?? now.subtract(const Duration(days: 1));

    final daysSinceOpen = now.difference(lastOpen).inDays;
    final daysSinceWorkout = settings.lastWorkoutDate == null ? 3 : now.difference(settings.lastWorkoutDate!).inDays;

    String? message;

    // 1. Check training inactivity (3 days)
    if (daysSinceWorkout >= 3) {
      // User specified prompt: "user hasn't trained for 3 days now can you msg him something short and impactful so that he will have motivation to train again."
      message = await _generateMessage(coach, "The user hasn't trained for $daysSinceWorkout days. Give them a short, impactful, and motivating message to get them back to training immediately. No fluff.");
    } 
    // 2. Check app inactivity (2 days)
    if (daysSinceOpen >= 2) {
      message = await _generateMessage(coach, "User hasn't opened the app for $daysSinceOpen days. They might be getting lazy.");
    }
    // 3. Random funny message (3-5 days interval)
    // We can use a random seed or store a 'lastRandomMessageDate' in settings
    else {
      final rand = Random();
      // 10% chance to send a random funny message if they opened today
      if (rand.nextDouble() < 0.1) {
        message = await _generateMessage(coach, "Send a funny, random motivational thought or tip in your characteristic style.");
      }
    }

    if (message != null) {
      final convId = '${COACH_CONV_ID_PREFIX}${coach.id}';
      
      // Ensure conversation exists in SocialCubit
      _sendToSocial(socialCubit, coach, message, convId);
    }

    // Update last open date
    settings.lastAppOpenDate = now;
    await _bodyRepo.saveUserSettings(settings);
  }

  Future<String> _generateMessage(CoachModel coach, String promptContext) async {
    if (!coach.isAi) {
      // Non-AI "Lazy Coach" messages
      final lazyMessages = [
        "YOU ARE LAZY! GET TO THE GYM NOW!",
        "I SEE YOU SITTING THERE. DO 50 PUSHUPS!",
        "PATHETIC. YOUR MUSCLES ARE WITHERING AWAY.",
        "GO LIFT SOMETHING HEAVY. NOW.",
        "WHY ARE YOU STILL HERE? GO TRAIN!",
      ];
      return lazyMessages[Random().nextInt(lazyMessages.length)];
    }

    // AI Coach
    try {
      final response = await _aiService.getResponse([
        {'role': 'system', 'content': '${coach.systemPrompt} Respond to this context: $promptContext. Keep it short (1-2 sentences).'},
      ]);
      return response;
    } catch (e) {
      return "YEAH BUDDY! (Error generating message)";
    }
  }

  void _sendToSocial(SocialCubit cubit, CoachModel coach, String text, String convId) {
    // Inject this message into the state
    cubit.receiveMessage(
      convId, 
      coach.name, 
      text, 
      senderId: 'coach_${coach.id}',
    );
  }

  Future<String> generateCoachChatResponse(CoachModel coach, String userText) async {
    return _generateMessage(coach, "The user just said: '$userText'. Respond in your characteristic style.");
  }
}
