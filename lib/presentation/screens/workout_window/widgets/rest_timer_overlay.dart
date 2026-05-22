import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class RestTimerOverlay extends StatefulWidget {
  final int durationSeconds;
  final VoidCallback onFinished;
  final VoidCallback onSkip;

  const RestTimerOverlay({
    super.key,
    required this.durationSeconds,
    required this.onFinished,
    required this.onSkip,
  });

  @override
  State<RestTimerOverlay> createState() => _RestTimerOverlayState();

  static void show(
    BuildContext context, {
    required int durationSeconds,
    required VoidCallback onFinished,
    required VoidCallback onSkip,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => RestTimerOverlay(
        durationSeconds: durationSeconds,
        onFinished: onFinished,
        onSkip: onSkip,
      ),
    );
  }
}

class _RestTimerOverlayState extends State<RestTimerOverlay> {
  late int _remainingSeconds;
  Timer? _timer;
  final double _strokeWidth = 12.0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
        if (_remainingSeconds == 0) {
          _finish();
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  void _finish() async {
    _timer?.cancel();

    // Vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500);
    } else {
      HapticFeedback.vibrate();
    }

    // Audible alert
    try {
      // await _audioPlayer.play(AssetSource('sounds/ding.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }

    widget.onFinished();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remainingSeconds / widget.durationSeconds;
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'REST TIME',
            style: theme.textTheme.titleMedium?.copyWith(
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          // Timer Circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: _strokeWidth,
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(_remainingSeconds),
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'remaining',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _remainingSeconds += 30;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Colors.grey[800]!),
                  ),
                  child: const Text(
                    '+30s',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    _timer?.cancel();
                    widget.onSkip();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'SKIP REST',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
