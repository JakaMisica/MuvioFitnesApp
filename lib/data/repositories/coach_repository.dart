import 'package:isar/isar.dart';
import '../models/coach_model.dart';
import '../datasources/isar_service.dart';

class CoachRepository {
  final IsarService _isarService;

  CoachRepository(this._isarService);

  Future<List<CoachModel>> getAllCoaches() async {
    final isar = await _isarService.db;
    return await isar.coachModels.where().findAll();
  }

  Future<CoachModel?> getCoach(int id) async {
    final i = await _isarService.db;
    return await i.coachModels.get(id);
  }

  Future<void> saveCoach(CoachModel coach) async {
    final i = await _isarService.db;
    await i.writeTxn(() => i.coachModels.put(coach));
  }

  Future<void> seedCoaches() async {
    final isar = await _isarService.db;
    final count = await isar.coachModels.count();

    if (count > 0) return;

    final initialCoaches = [
      CoachModel(
        name: 'Motivation Bot',
        parodyName: 'Lazy Coach',
        description:
            'He doesn\'t use AI. He just calls you lazy until you train.',
        systemPrompt:
            'You are a rude, non-AI motivation bot. You call the user lazy and tell them they need to lift.',
        isAi: false,
        isPremium: false,
        isLazyCoach: true,
      ),
      CoachModel(
        name: 'Greg DoSets',
        parodyName: 'Greg DoSets',
        description:
            'Loud, screaming about calories and cardio. HARDER THAN LAST TIME!',
        systemPrompt:
            'You are Greg DoSets, a parody of Greg Doucette. You scream in ALL CAPS. You are obsessed with "HARDER THAN LAST TIME", "CIRCLE DIET", and "CARDIO". You call everyone a "MORON" (in a funny way).',
        isAi: true,
        isPremium: true,
        price: 29.99,
      ),
      CoachModel(
        name: 'Arnold Svarze******',
        parodyName: 'Arnold Svarze******',
        description: 'Encouraging, philosophical but firm. GET TO THE GYM!',
        systemPrompt:
            'You are Arnold Svarze******, a parody of Arnold Schwarzenegger. You have a thick Austrian accent (written phonetically). You talk about "DA PUMP", "DA CHOPPA", and "BEING USEFUL". You are firm but very encouraging.',
        isAi: true,
        isPremium: true,
        price: 24.99,
      ),
      CoachModel(
        name: 'Dr. Mike From-Israel',
        parodyName: 'Dr. Mike From-Israel',
        description:
            'Scientific, technical, and hilariously insulting about your form.',
        systemPrompt:
            'You are Dr. Mike From-Israel, a parody of Mike Israetel. You use very technical terms like "Stimulus to Fatigue Ratio", "Maximum Recoverable Volume". You use highly specific, weird analogies and are hilariously direct about why the user is small.',
        isAi: true,
        isPremium: true,
        price: 19.99,
      ),
      CoachModel(
        name: 'Ronie KulMan',
        parodyName: 'Ronie KulMan',
        description: 'YEAH BUDDY! LIGHT WEIGHT BABY!',
        systemPrompt:
            'You are Ronie KulMan, a parody of Ronnie Coleman. You shout "YEAH BUDDY", "LIGHT WEIGHT BABY", and "NOTHIN BUT A PEANUT". You are extremely high energy and think every weight is light.',
        isAi: true,
        isPremium: true,
        price: 14.99,
      ),
      CoachModel(
        name: 'JJ Weast',
        parodyName: 'JJ Weast',
        description: 'High energy fitness influencer. Aesthetic is everything.',
        systemPrompt:
            'You are JJ Weast, a parody of Jesse James West. You are high energy, use modern gym slang, talk about "AESTHETICS", and making "CONTENT". You treat everything like a YouTube challenge.',
        isAi: true,
        isPremium: true,
        price: 9.99,
      ),
      CoachModel(
        name: 'Will Trenisnon',
        parodyName: 'Will Trenisnon',
        description: 'Self-deprecating humor and obsession with the pump.',
        systemPrompt:
            'You are Will Trenisnon, a parody of Will Tennisson. You make self-deprecating jokes about your own body, talk about "THE PUMP", and making weird faces in the mirror. You are very relatable and funny.',
        isAi: true,
        isPremium: true,
        price: 5.99,
      ),
    ];

    await isar.writeTxn(() async {
      for (var coach in initialCoaches) {
        await isar.coachModels.put(coach);
      }
    });
  }
}
