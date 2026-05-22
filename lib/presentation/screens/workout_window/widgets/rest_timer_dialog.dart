import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import '../../../../data/models/workout_day.dart';

class RestTimerDialog extends StatefulWidget {
  final int durationSeconds;
  final VoidCallback onFinished;
  final VoidCallback onSkip;
  final WorkoutSet? nextSet;
  final String? nextExerciseName;
  final int? nextSetNumber;

  const RestTimerDialog({
    super.key,
    required this.durationSeconds,
    required this.onFinished,
    required this.onSkip,
    this.nextSet,
    this.nextExerciseName,
    this.nextSetNumber,
  });

  @override
  State<RestTimerDialog> createState() => _RestTimerDialogState();

  static Future<void> show(
    BuildContext context, {
    required int durationSeconds,
    required VoidCallback onFinished,
    required VoidCallback onSkip,
    WorkoutSet? nextSet,
    String? nextExerciseName,
    int? nextSetNumber,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RestTimerDialog(
        durationSeconds: durationSeconds,
        onFinished: onFinished,
        onSkip: onSkip,
        nextSet: nextSet,
        nextExerciseName: nextExerciseName,
        nextSetNumber: nextSetNumber,
      ),
    );
  }
}

class _RestTimerDialogState extends State<RestTimerDialog>
    with SingleTickerProviderStateMixin {
  late int _remainingSeconds;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationSeconds;
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    )..forward();
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

  void _addTime() {
    setState(() {
      _remainingSeconds += 15;
      widget.durationSeconds;
    });
  }

  void _finish() async {
    _timer?.cancel();

    // Vibration
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 500);
    } else {
      HapticFeedback.heavyImpact();
    }

    // Audible alert (optional)
    try {
      // await _audioPlayer.play(AssetSource('sounds/ding.mp3'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }

    widget.onFinished();
    if (mounted) Navigator.pop(context);
  }

  void _skip() {
    _timer?.cancel();
    widget.onSkip();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remainingSeconds / widget.durationSeconds;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timer Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Title
                  const Text(
                    'REST TIMER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Circular Progress
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background circle
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: 1.0,
                            strokeWidth: 12,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        // Progress circle
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 12,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation(
                              _getTimerColor(progress),
                            ),
                          ),
                        ),
                        // Time display
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatTime(_remainingSeconds),
                              style: TextStyle(
                                color: _getTimerColor(progress),
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                            Text(
                              'REMAINING',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _addTime,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('ADD 15S'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _skip,
                          icon: const Icon(Icons.skip_next, size: 18),
                          label: const Text('SKIP'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Next Set Preview (if provided)
            if (widget.nextSet != null || widget.nextExerciseName != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.blue.withOpacity(0.7),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'UP NEXT',
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.7),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (widget.nextExerciseName != null)
                      Text(
                        widget.nextExerciseName!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (widget.nextSetNumber != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'SET ${widget.nextSetNumber}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (widget.nextSet?.weight != null) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.fitness_center,
                            size: 14,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.nextSet!.weight} kg',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                        if (widget.nextSet?.reps != null) ...[
                          const SizedBox(width: 12),
                          Icon(
                            Icons.repeat,
                            size: 14,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.nextSet!.reps} reps',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getTimerColor(double progress) {
    if (progress > 0.5) {
      return Colors.green;
    } else if (progress > 0.25) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
