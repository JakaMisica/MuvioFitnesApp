import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'ai_service.dart';
import 'voice_body_services.dart';

class VoiceCoachService {
  final AiService _cloudBrain = AiService();
  final GraniteSpeechService _hearing = GraniteSpeechService();
  final PiperVoiceService _voice = PiperVoiceService();
  final AudioRecorder _recorder = AudioRecorder();
  
  static final VoiceCoachService _instance = VoiceCoachService._internal();
  factory VoiceCoachService() => _instance;
  VoiceCoachService._internal();

  /// STEP 1: HEARING (LOCAL STT)
  Future<bool> startVoiceCapture() async {
    try {
      if (await _recorder.hasPermission()) {
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/muvio_voice_input.wav';
        
        final file = File(path);
        if (await file.exists()) await file.delete();

        const config = RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          bitRate: 128000,
        );

        await _recorder.start(config, path: path);
        return true;
      }
    } catch (e) {
      debugPrint("VoiceCoachService: Start Capture Error: $e");
    }
    return false;
  }

  Future<String?> stopVoiceCapture() async {
    try {
      return await _recorder.stop();
    } catch (e) {
      debugPrint("VoiceCoachService: Stop Capture Error: $e");
    }
    return null;
  }

  Future<String> transcribeLocal(String audioPath) async {
    debugPrint("VoiceCoachService: Transcribing locally with IBM Granite...");
    try {
      final file = File(audioPath);
      if (!await file.exists()) return "";
      
      final bytes = await file.readAsBytes();
      // Simple WAV header skip (44 bytes typical)
      // For a better implementation we should use a wav decoder, 
      // but for 16k mono it's often predictable.
      final pcmBytes = bytes.sublist(44); 
      final List<double> samples = [];
      for (int i = 0; i < pcmBytes.length - 1; i += 2) {
        final int low = pcmBytes[i];
        final int high = pcmBytes[i + 1];
        // Convert 16-bit PCM to double [-1.0, 1.0]
        int sample = (high << 8) | low;
        if (sample > 32767) sample -= 65536;
        samples.add(sample / 32768.0);
      }

      final result = _hearing.transcribeFromSamples(samples);
      debugPrint("VoiceCoachService: Transcript: $result");
      return result;
    } catch (e) {
      debugPrint("VoiceCoachService: Transcription Error: $e");
      return "";
    }
  }

  /// STEP 2: THINKING (BRAIN)
  /// Fallback between Gemini Cloud and Local Emergency Brain
  Future<String> getBrainResponse(List<Map<String, String>> messages, {String? audioPath}) async {
    try {
      debugPrint("VoiceCoachService: Syncing with Cloud Brain (Gemini Flash-Lite)...");
      final response = await _cloudBrain.getResponse(messages, audioPath: audioPath);
      
      if (response.contains("exhausted") || response.contains("unavailable") || response.isEmpty) {
        return _getEmergencyResponse(messages.last['content'] ?? "");
      }
      
      return response;
    } catch (e) {
      debugPrint("VoiceCoachService: Cloud Brain sync failure: $e. Activating Emergency Brain...");
      return _getEmergencyResponse(messages.last['content'] ?? "");
    }
  }

  /// STEP 3: VOICE (LOCAL TTS)
  /// Uses Piper TTS for ultra-low latency response
  Future<void> speakLocal(String text) async {
    await _voice.speak(text);
  }

  /// FALLBACK: EMERGENCY BRAIN
  /// Local lightweight fallback logic
  Future<String> _getEmergencyResponse(String userPrompt) async {
    debugPrint("VoiceCoachService: Emergency Brain active (Local Fallback)");
    // Here as a fallback we could use a mini Gemma 2B via flutter_ai_toolkit
    // For now: Responding with context-aware bio-feedback from the Body.
    return "Neural link interrupted. Body is operating locally. Keep pushing through your session!";
  }

  /// LIVE CONNECTION STATUS
  String getConnectionStatus(bool isEmergency) {
    return isEmergency ? "EMERGENCY BRAIN ACTIVE" : "DUAL-LAYER CONNECTED";
  }
}
