import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa;
import 'package:piper_tts_plugin/piper_tts_plugin.dart';
import 'package:piper_tts_plugin/enums/piper_voice_pack.dart';
import 'package:audioplayers/audioplayers.dart';

// ── LOCAL HEARING: IBM Granite 4.0 1B ───────────────────────────────
class GraniteSpeechService {
  sherpa.OnlineRecognizer? _recognizer;
  static final GraniteSpeechService _instance = GraniteSpeechService._internal();
  factory GraniteSpeechService() => _instance;
  GraniteSpeechService._internal();

  Future<void> initGranite() async {
    // Only init if platform supports sherpa_onnx
    if (!Platform.isAndroid && !Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return;

    debugPrint("GraniteSpeechService: Initializing Local AI Hearing...");
    try {
      final config = sherpa.OnlineRecognizerConfig(
        model: sherpa.OnlineModelConfig(
          transducer: sherpa.OnlineTransducerModelConfig(
            encoder: 'assets/models/granite-encoder.onnx',
            decoder: 'assets/models/granite-decoder.onnx',
            joiner: 'assets/models/granite-joiner.onnx',
          ),
          tokens: 'assets/models/tokens.txt',
          numThreads: 4,
          debug: false,
        ),
      );
      _recognizer = sherpa.OnlineRecognizer(config);
    } catch (e) {
      debugPrint("GraniteSpeechService: Initialization Error: $e");
    }
  }

  String transcribeFromSamples(List<double> samples) {
    if (_recognizer == null) return "Hearing offline...";
    
    try {
      final stream = _recognizer!.createStream();
      final floatSamples = Float32List.fromList(samples);
      stream.acceptWaveform(samples: floatSamples, sampleRate: 16000);
      
      _recognizer!.decode(stream);
      final result = _recognizer!.getResult(stream);
      return result.text;
    } catch (e) {
      return "Hearing offline...";
    }
  }
}

// ── LOCAL VOICE: Piper TTS ───────────────────────────────────────────
class PiperVoiceService {
  PiperTtsPlugin? _piper;
  final AudioPlayer _player = AudioPlayer();
  
  static final PiperVoiceService _instance = PiperVoiceService._internal();
  factory PiperVoiceService() => _instance;
  PiperVoiceService._internal() {
    // Safe initialization: Only attempt Piper if on Android (until Windows bridge is fixed)
    if (Platform.isAndroid) {
      try {
        _piper = PiperTtsPlugin();
      } catch (e) {
        debugPrint("PiperVoiceService: Plugin init failed (ESpeakBridge context): $e");
      }
    }
  }

  Future<void> speak(String text) async {
    if (_piper == null) {
      debugPrint("PiperVoiceService: Local Piper unavailable. Falling back to Cloud Voice Stream...");
      final url = "https://translate.google.com/translate_tts?ie=UTF-8&q=${Uri.encodeComponent(text)}&tl=en&client=tw-ob";
      await _player.stop();
      await _player.play(UrlSource(url));
      return;
    }

    debugPrint("PiperVoiceService: Generating local voice for: $text");
    try {
      final tempDir = await getTemporaryDirectory();
      final String path = "${tempDir.path}/coach_voice.wav";
      
      await _piper!.loadViaVoicePack(PiperVoicePack.norman);
      final result = await _piper!.synthesizeToFile(
        text: text,
        outputPath: path,
      );

      if (result != null) {
        await _player.stop();
        await _player.play(DeviceFileSource(result.path));
      }
    } catch (e) {
      debugPrint("PiperVoiceService: Synthesis error: $e. Using fallback stream...");
      final url = "https://translate.google.com/translate_tts?ie=UTF-8&q=${Uri.encodeComponent(text)}&tl=en&client=tw-ob";
      await _player.stop();
      await _player.play(UrlSource(url));
    }
  }
}
