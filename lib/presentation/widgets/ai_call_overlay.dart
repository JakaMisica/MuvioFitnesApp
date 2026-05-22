import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
 import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_session/audio_session.dart' as session_lib;

import '../../core/services/voice_coach_service.dart';
import '../../core/services/coach_call_service.dart';
import '../../logic/cubit/workout/workout_cubit.dart';
import '../../logic/cubit/diet/diet_cubit.dart';
import '../../logic/cubit/tasks/task_cubit.dart';
import '../../logic/cubit/evolution/evolution_cubit.dart';
import '../../data/repositories/coach_repository.dart';
import '../../data/repositories/body_repository.dart';
import '../../locator.dart';

class AiCallOverlay extends StatefulWidget {
  final bool isOutbound;
  const AiCallOverlay({super.key, this.isOutbound = false});

  @override
  State<AiCallOverlay> createState() => _AiCallOverlayState();
}

class _AiCallOverlayState extends State<AiCallOverlay> {
  final AudioPlayer _ringPlayer = AudioPlayer();
  final AudioPlayer _ttsUrlPlayer = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();
  
  final List<Map<String, String>> _messages = [];
  
  bool _isAnswered = false;
  bool _isHangingUpOptionsVisible = false;
  String _aiText = "Connecting...";
  String _coachName = "AI Coach";
  String _userSpeechText = ""; 
  bool _isAiTyping = false;
  bool _isListening = false;
  bool _isFirstMessage = true; // Track for initial sync message
  int _exchangeCount = 0; // Track number of AI responses
  Timer? _silenceTimer;

  @override
  void initState() {
    super.initState();
    _checkCallSource();
  }

  void _checkCallSource() async {
    // Determine if this is an AI prompt or manual user call
    final settings = await locator<BodyRepository>().getUserSettings();
    final coachRepo = locator<CoachRepository>();
    
    if (settings.activeCoachId != null) {
      final coach = await coachRepo.getCoach(settings.activeCoachId!);
      if (coach != null) {
        if (mounted) setState(() => _coachName = coach.name);
      }
    }
    
    if (widget.isOutbound) {
      if (mounted) {
        setState(() {
          _isAnswered = false; 
          _aiText = "Dialing Neural Link...";
        });
      }
      // Skip ringing, simulate dialing
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) _answerCall(); // Coach "picks up"
      });
    } else {
      if (settings.isInjured) {
         if (mounted) setState(() => _aiText = "I see you are injured. Please rest.");
      }
      _startRinging();
    }
  }

  void _startRinging() async {
    debugPrint("CoachCallCall: Configuring Audio Session for ALARM...");
    try {
      final session = await session_lib.AudioSession.instance;
      await session.configure(session_lib.AudioSessionConfiguration(
        avAudioSessionCategory: session_lib.AVAudioSessionCategory.playback,
        avAudioSessionMode: session_lib.AVAudioSessionMode.defaultMode,
        avAudioSessionRouteSharingPolicy:
            session_lib.AVAudioSessionRouteSharingPolicy.defaultPolicy,
        androidAudioAttributes: const session_lib.AndroidAudioAttributes(
          contentType: session_lib.AndroidAudioContentType.music,
          flags: session_lib.AndroidAudioFlags.none,
          usage: session_lib.AndroidAudioUsage.alarm, // CRITICAL: Use the alarm stream
        ),
        androidAudioFocusGainType:
            session_lib.AndroidAudioFocusGainType.gainTransientMayDuck,
      ));
      
      debugPrint("CoachCallCall: Starting Ringtone (coach_ringtone)...");
      await _ringPlayer.setReleaseMode(ReleaseMode.loop);
      await _ringPlayer.play(AssetSource('audio/alarms/coach_ringtone.mp3'));
    } catch (e) {
      debugPrint("CoachCallCall: Ringtone/Session start failed: $e");
    }
  }

  void _stopRinging() async {
    debugPrint("CoachCallCall: Stopping Ringtone.");
    await _ringPlayer.stop();
  }

  void _answerCall() {
    debugPrint("CoachCallCall: Answering...");
    _stopRinging();
    if (mounted) {
      setState(() {
        _isAnswered = true;
        _aiText = "Neural link established...";
      });
      CoachCallService().handlePickUp();
      _startAiConversation();
    }
  }

  void _startAiConversation({String? userPrompt}) async {
    if (!mounted) return;
    debugPrint("CoachCallCall: Starting AI Turn (${userPrompt ?? 'Initial Greeting'})...");
    
    if (mounted) {
      setState(() {
        _isAiTyping = true;
        if (userPrompt != null) {
           _aiText = "Analysing bio-feedback...";
        } else if (_isFirstMessage) {
           _aiText = "Synchronizing neural link...";
        }
        _isListening = false;
      });
    }

    // STEP 1: LOCAL HEARING (IBM Granite)
    if (userPrompt != null && File(userPrompt).existsSync()) {
      final localTranscript = await VoiceCoachService().transcribeLocal(userPrompt);
      if (mounted) {
        setState(() {
          _userSpeechText = localTranscript;
        });
      }
      _messages.add({"role": "user", "content": localTranscript});
    }

    // STEP 2: THINKING (Gemini Flash-Lite with Local Fallback)
    try {
      // Build full context with system prompt first
      final coachService = CoachCallService();
      final systemPrompt = await coachService.buildSystemPrompt(
        workout: context.read<WorkoutCubit>().state,
        diet: context.read<DietCubit>().state,
        weightHistory: context.read<EvolutionCubit>().state.chartHistory.map((e) => e.value).toList(),
        tasks: context.read<TaskCubit>().state,
      );

      final fullMessages = [
        {'role': 'system', 'content': systemPrompt},
        ..._messages,
      ];

      // Dynamic instructions based on exchange count
      if (_exchangeCount < 2) {
        fullMessages.add({
          'role': 'system', 
          'content': 'You MUST continue the conversation. Do NOT use the [END_CALL] token yet.'
        });
      } else if (_exchangeCount >= 14) {
        fullMessages.add({
          'role': 'system', 
          'content': 'LIMIT REACHED: You MUST end the call now using the [END_CALL] token.'
        });
      } else {
        fullMessages.add({
          'role': 'system', 
          'content': 'You have the option to end the call if all information is gathered by using [END_CALL].'
        });
      }

      final response = await VoiceCoachService().getBrainResponse(
        fullMessages,
        audioPath: userPrompt,
      );
      
      String cleanResponse = response.replaceAll("[END_CALL]", "").trim();
      bool shouldEnd = response.contains("[END_CALL]");

      // Logic adjustments for MIN 3, MAX 15 messages
      if (_exchangeCount < 2) { // Less than 3 messages (0, 1, 2)
        shouldEnd = false; // Block early termination
      }
      if (_exchangeCount >= 14) { // 15th message
        shouldEnd = true; // Force termination
      }

      _messages.add({"role": "assistant", "content": cleanResponse});
      
      if (mounted) {
        setState(() {
          _isAiTyping = false;
          _isFirstMessage = false; // Reset first message flag
          _userSpeechText = ""; 
          _aiText = cleanResponse; 
          _exchangeCount++; 
        });
        
        // STEP 3: VOICE (Handled by the Dual-Layer Strategy)
        await VoiceCoachService().speakLocal(cleanResponse);
        
        final speechDuration = (cleanResponse.length * 52) + 800;
        Future.delayed(Duration(milliseconds: speechDuration.clamp(2000, 15000)), () {
          if (mounted && _isAnswered && !_isAiTyping) {
            if (shouldEnd) {
              CoachCallService().handleHangUp('end');
            } else {
              _startListening();
            }
          }
        });
      }
    } catch (e) {
      debugPrint("CoachCallCall: AI Error: $e");
      if (mounted) {
        setState(() {
          _isAiTyping = false;
          _aiText = "Neural link unstable. Re-syncing...";
        });
        _startListening();
      }
    }
  }

  void _startListening() async {
    if (_isListening || !mounted || !_isAnswered) return;
    debugPrint("CoachCallCall: Starting Voice Capture...");
    
    try {
      if (await _recorder.hasPermission()) {
        final tempDir = await getTemporaryDirectory();
        final path = '${tempDir.path}/muvio_voice_input.wav';
        
        // Remove old file
        final file = File(path);
        if (await file.exists()) await file.delete();

        const config = RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          bitRate: 128000,
        );

        await _recorder.start(config, path: path);
        if (mounted) {
          setState(() {
            _isListening = true;
            _userSpeechText = "Listening...";
          });
        }

        // Logic: Record for 4 seconds then send (Simple hands-free for now)
        // Later we can add a "Silence detection" or "Stop button"
        _silenceTimer?.cancel();
        _silenceTimer = Timer(const Duration(seconds: 4), () {
          _stopAndSendRecording(path);
        });
      }
    } catch (e) {
      debugPrint("CoachCallCall: Recording Error: $e");
    }
  }

  void _stopAndSendRecording(String path) async {
    if (!_isListening) return;
    debugPrint("CoachCallCall: Stopping Capture & Sending to Gemini...");
    
    try {
      await _recorder.stop();
      if (mounted) {
        setState(() {
          _isListening = false;
          _userSpeechText = "Transmitting...";
        });
        _startAiConversation(userPrompt: path); // Sending path to audio instead of text
      }
    } catch (e) {
      debugPrint("CoachCallCall: Recording Stop/Send Error: $e");
    }
  }




  @override
  void dispose() {
    _silenceTimer?.cancel();
    _stopRinging();
    _recorder.dispose();
    _ringPlayer.dispose();
    _ttsUrlPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(color: Colors.black.withOpacity(0.9)),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Coach Avatar / Name
                  _buildCoachAvatar(),
                  const SizedBox(height: 20),
                  // NAME
                  Text(
                    _coachName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  Text(
                    _isAnswered ? VoiceCoachService().getConnectionStatus(false) : "EXPECTING INCOMING CALL",
                    style: TextStyle(
                      color: _isAnswered ? Colors.cyanAccent : Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Text Area (Scrollable to prevent overflow)
                  if (_isAnswered)
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: _buildAiSubtitles(),
                      ),
                    )
                  else
                    const Spacer(),
                  
                  const SizedBox(height: 20),
                  
                  if (!_isAnswered && !_isHangingUpOptionsVisible) _buildCallActions(),
                  if (_isAnswered) _buildActiveCallUI(),
                  if (_isHangingUpOptionsVisible) _buildHangUpOptions(),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoachAvatar() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isAnswered)
              ...List.generate(3, (index) => _buildVoiceRing(index)),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.cyanAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.3),
                    blurRadius: 25,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Icon(Icons.psychology, size: 45, color: Colors.cyanAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceRing(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 1200 + (index * 400)),
      builder: (context, value, child) {
        return Container(
          width: 90 + (value * 60),
          height: 90 + (value * 60),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.cyanAccent.withOpacity(0.4 * (1.0 - value)),
              width: 1.5,
            ),
          ),
        );
      },
      // Re-trigger animation without global setState to avoid defunct element errors
      onEnd: () { }, 
    );
  }

  Widget _buildAiSubtitles() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isAiTyping || _isListening)
          SizedBox(
            width: 40,
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              color: _isListening ? Colors.redAccent : Colors.cyanAccent,
              minHeight: 2.0,
            ),
          ),
        const SizedBox(height: 12),
        
        // MAIN TEXT AREA
        Text(
          _isListening ? "“$_userSpeechText”" : _aiText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _isListening ? Colors.white70 : Colors.white.withOpacity(0.95),
            fontSize: _isListening ? 22 : 16,
            fontWeight: _isListening ? FontWeight.w900 : FontWeight.w400,
            fontStyle: FontStyle.italic,
            height: 1.6,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 24),
        
        Text(
          _isListening 
            ? "NEURAL LINK: TRANSCRIBING..." 
            : (_isAiTyping ? "NEURAL LINK: THINKING..." : "NEURAL LINK: TRANSMITTING..."),
          style: TextStyle(
            color: _isListening ? Colors.redAccent : Colors.cyanAccent,
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCallActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircleButton(
          icon: Icons.call_end,
          color: Colors.redAccent,
          label: "DECLINE",
          onTap: () => setState(() => _isHangingUpOptionsVisible = true),
        ),
        _buildCircleButton(
          icon: Icons.call,
          color: Colors.greenAccent,
          label: "ANSWER",
          onTap: _answerCall,
        ),
      ],
    );
  }

  Widget _buildActiveCallUI() {
    return _buildCircleButton(
      icon: Icons.call_end,
      color: Colors.redAccent,
      label: "END TRANSMISSION",
      onTap: () {
        CoachCallService().handleHangUp('end');
      },
    );
  }

  Widget _buildHangUpOptions() {
    return Column(
      children: [
        const Text(
          "RE-SCHEDULE CALL?",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _buildOptionButton("IN 15 MIN", () => CoachCallService().handleHangUp('15m')),
            _buildOptionButton("IN 30 MIN", () => CoachCallService().handleHangUp('30m')),
            _buildOptionButton("GET LOST", () => CoachCallService().handleHangUp('get_lost'), isNegative: true),
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => setState(() => _isHangingUpOptionsVisible = false),
          child: const Text("BACK", style: TextStyle(color: Colors.white24)),
        ),
      ],
    );
  }

  Widget _buildOptionButton(String text, VoidCallback onTap, {bool isNegative = false}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isNegative ? Colors.red.withOpacity(0.1) : Colors.white10,
        foregroundColor: isNegative ? Colors.redAccent : Colors.white70,
        side: BorderSide(color: isNegative ? Colors.redAccent.withOpacity(0.3) : Colors.white10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.4), blurRadius: 15, spreadRadius: 2),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
