import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// ─────────────────────────────────────────────
// API KEY CONFIGURATION
// Priority: Gemini (free) → Groq (Kimi) → Novita (fallback)
// ─────────────────────────────────────────────

class _ApiKey {
  final String provider; // 'gemini' | 'groq_kimi' | 'novita'
  final String key;
  final int dailyLimit; // estimated free-tier request limit per day

  const _ApiKey({
    required this.provider,
    required this.key,
    required this.dailyLimit,
  });
}

const List<_ApiKey> _allKeys = [
  // ── GEMINI (Primary - 4 Keys) ──────────────────────────────────────
  _ApiKey(
    provider: 'gemini',
    key: String.fromEnvironment('GEMINI_API_KEY_1'),
    dailyLimit: 1500,
  ),
  _ApiKey(
    provider: 'gemini',
    key: String.fromEnvironment('GEMINI_API_KEY_2'),
    dailyLimit: 1500,
  ),
  _ApiKey(
    provider: 'gemini',
    key: String.fromEnvironment('GEMINI_API_KEY_3'),
    dailyLimit: 1500,
  ),
  _ApiKey(
    provider: 'gemini',
    key: String.fromEnvironment('GEMINI_API_KEY_4'),
    dailyLimit: 1500,
  ),

  // ── GROQ (Secondary - 5 Keys) ──────────────────────────────────────
  _ApiKey(
    provider: 'groq_kimi',
    key: String.fromEnvironment('GROQ_API_KEY_1'),
    dailyLimit: 5000,
  ),
  _ApiKey(
    provider: 'groq_kimi',
    key: String.fromEnvironment('GROQ_API_KEY_2'),
    dailyLimit: 5000,
  ),
  _ApiKey(
    provider: 'groq_kimi',
    key: String.fromEnvironment('GROQ_API_KEY_3'),
    dailyLimit: 5000,
  ),
  _ApiKey(
    provider: 'groq_kimi',
    key: String.fromEnvironment('GROQ_API_KEY_4'),
    dailyLimit: 5000,
  ),
  _ApiKey(
    provider: 'groq_kimi',
    key: String.fromEnvironment('GROQ_API_KEY_5'),
    dailyLimit: 5000,
  ),

  // ── NOVITA (Fallback) ───────────────────────────────────────────────
  _ApiKey(
    provider: 'novita',
    key: String.fromEnvironment('NOVITA_API_KEY'),
    dailyLimit: 999,
  ),
];

// ─────────────────────────────────────────────
// SMART AI SERVICE WITH AUTO FALLBACK
// ─────────────────────────────────────────────

class AiService {
  static const String _prefPrefix = 'ai_key_usage_';
  static const String _prefDatePrefix = 'ai_key_date_';

  // ── Get today's date as a string key ──────────────────────────────
  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  // ── Get usage count for a given key index ─────────────────────────
  Future<int> _getUsage(SharedPreferences prefs, int keyIndex) async {
    final dateKey = prefs.getString('$_prefDatePrefix$keyIndex');
    final today = _todayKey();
    if (dateKey != today) {
      // New day — reset counter
      await prefs.setInt('$_prefPrefix$keyIndex', 0);
      await prefs.setString('$_prefDatePrefix$keyIndex', today);
      return 0;
    }
    return prefs.getInt('$_prefPrefix$keyIndex') ?? 0;
  }

  // ── Increment usage for a given key index ──────────────────────────
  Future<void> _incrementUsage(SharedPreferences prefs, int keyIndex) async {
    final current = await _getUsage(prefs, keyIndex);
    await prefs.setInt('$_prefPrefix$keyIndex', current + 1);
    await prefs.setString('$_prefDatePrefix$keyIndex', _todayKey());
  }

  // ── Call Gemini REST API ───────────────────────────────────────────
  Future<String?> _callGemini(
    String apiKey,
    List<Map<String, String>> messages, {
    String? audioPath,
  }) async {
    final modelsToTry = [
      'gemini-3.1-flash-lite-preview', // User Priority: Flash-Lite
      'gemini-3.1-flash-live-preview',
      'gemini-2.0-flash-exp',
      'gemini-1.5-flash',
      'gemini-1.5-pro',
    ];

    for (final modelName in modelsToTry) {
      try {
        final model = GenerativeModel(
          model: modelName,
          apiKey: apiKey,
          systemInstruction: _getSystemInstruction(messages),
        );

        final List<Content> contents = [];

        // Move system instruction into first message for maximum compatibility with all keys
        final sysInstr = _getSystemInstruction(messages);
        if (sysInstr != null) {
          contents.add(
            Content('user', [
              TextPart(
                "System Instruction: ${sysInstr.parts.whereType<TextPart>().map((p) => p.text).join("\n")}",
              ),
            ]),
          );
          contents.add(
            Content('model', [
              TextPart("Understood. I will act as the Muvio AI Coach."),
            ]),
          );
        }

        for (final msg in messages) {
          if (msg['role'] == 'system') continue;

          final parts = <Part>[TextPart(msg['content'] ?? '')];

          if (audioPath != null &&
              msg == messages.last &&
              msg['role'] == 'user') {
            final file = File(audioPath);
            if (await file.exists()) {
              final bytes = await file.readAsBytes();
              parts.add(DataPart('audio/wav', bytes));
              debugPrint(
                '[AI] Gemini: Attaching actual audio bytes (${bytes.length})',
              );
            }
          }

          contents.add(
            Content(msg['role'] == 'user' ? 'user' : 'model', parts),
          );
        }

        if (contents.isEmpty) contents.add(Content.text('Hello coach!'));

        final response = await model
            .generateContent(
              contents,
              generationConfig: GenerationConfig(
                temperature: 0.7,
                maxOutputTokens: 1024,
              ),
            )
            .timeout(const Duration(seconds: 30));

        final text = response.text;
        if (text != null && text.isNotEmpty) return text;
      } catch (e) {
        final err = e.toString();
        debugPrint('[AI] Gemini ($modelName) error detail: $err');

        final lowerErr = err.toLowerCase();
        // If it's a 404/NotFound on a specific model, try the next one
        if (lowerErr.contains('404') || lowerErr.contains('not found')) {
          continue;
        }
        // If it's a 429/Busy, try the next one
        if (lowerErr.contains('429') ||
            lowerErr.contains('quota') ||
            lowerErr.contains('busy')) {
          continue;
        }

        // If we get "generateContent is not supported", it might be a model configuration error
        if (lowerErr.contains('not supported')) {
          continue;
        }

        if (lowerErr.contains('safety') || lowerErr.contains('blocked'))
          return 'I cannot answer that for safety reasons.';
      }
    }
    return '__RATE_LIMITED__';
  }

  Content? _getSystemInstruction(List<Map<String, String>> messages) {
    for (final m in messages) {
      if (m['role'] == 'system' && m['content'] != null) {
        return Content.system(m['content']!);
      }
    }
    return null;
  }

  // ── Call Groq (Kimi) ───────────────────────────────────────────────

  // ── MAIN ENTRY POINT: Smart fallback chain ─────────────────────────
  Future<String> getResponse(
    List<Map<String, String>> messages, {
    String? audioPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // ── Auto-recovery: if ALL Gemini keys look burned, reset them
    await _autoRecoverIfStuck(prefs);

    for (int i = 0; i < _allKeys.length; i++) {
      final keyConfig = _allKeys[i];
      if (keyConfig.key.isEmpty) continue;

      final usage = await _getUsage(prefs, i);

      // Skip exhausted keys
      if (usage >= keyConfig.dailyLimit) continue;

      debugPrint(
        '[AI] Trying key #$i (${keyConfig.provider}) — usage $usage/${keyConfig.dailyLimit}',
      );

      String? result;

      // STRICT MODE: ONLY GEMINI FOR VOICE CALLS
      if (keyConfig.provider == 'gemini') {
        result = await _callGemini(
          keyConfig.key,
          messages,
          audioPath: audioPath,
        );
      } else {
        // Skip fallbacks for voice calls as requested
        continue;
      }

      if (result != null && result.isNotEmpty) {
        if (result == '__RATE_LIMITED__') {
          debugPrint(
            '[AI] Key #$i (${keyConfig.provider}) rate-limited/busy, trying next key...',
          );
          continue;
        }
        await _incrementUsage(prefs, i);
        debugPrint('[AI] ✅ Success with key #$i (${keyConfig.provider})');
        return result;
      } else {
        // Null = real failure (quota/auth error) — burn this key for today
        await prefs.setInt('$_prefPrefix$i', keyConfig.dailyLimit);
        await prefs.setString('$_prefDatePrefix$i', _todayKey());
        debugPrint(
          '[AI] 🔴 Key #$i (${keyConfig.provider}) failed, marking exhausted.',
        );
      }
    }

    // All keys exhausted
    return "AI unavailable — all API keys exhausted for today. Try again tomorrow!";
  }

  /// Auto-reset Gemini keys if they all appear burned
  Future<void> _autoRecoverIfStuck(SharedPreferences prefs) async {
    // Count how many of the GEMINI keys (indices 0-3) are marked burned
    int burnedGemini = 0;
    for (int i = 0; i <= 3; i++) {
      final usage = await _getUsage(prefs, i);
      if (usage >= _allKeys[i].dailyLimit) burnedGemini++;
    }
    if (burnedGemini == 4) {
      debugPrint('[AI] ⚠️ All Gemini keys appear burned — auto-resetting');
      for (int i = 0; i <= 3; i++) {
        await prefs.setInt('$_prefPrefix$i', 0);
        await prefs.setString('$_prefDatePrefix$i', _todayKey());
      }
    }
  }

  /// Reset all daily counters (useful for testing)
  Future<void> resetAllCounters() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _allKeys.length; i++) {
      await prefs.setInt('$_prefPrefix$i', 0);
    }
    debugPrint('[AI] All usage counters reset.');
  }

  /// Get current usage summary for debugging
  Future<String> getUsageSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final buffer = StringBuffer('=== AI Key Usage ===\n');
    for (int i = 0; i < _allKeys.length; i++) {
      final k = _allKeys[i];
      final usage = await _getUsage(prefs, i);
      final status = usage >= k.dailyLimit ? '🔴 EXHAUSTED' : '🟢 OK';
      buffer.writeln(
        'Key #$i [${k.provider.toUpperCase()}]: $usage/${k.dailyLimit} $status',
      );
    }
    return buffer.toString();
  }
}
