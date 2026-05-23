import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';
import 'dart:ui';

class RestTimerInline extends StatelessWidget {
  const RestTimerInline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvolutionCubit, EvolutionState>(
      builder: (context, evolutionState) {
        return BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            final timer = state.restTimer;
            if (timer == null || !timer.isActive)
              return const SizedBox.shrink();

            final progress = timer.remainingSeconds / timer.durationSeconds;
            final color = _getTimerColor(progress);
            final isBreathingEnabled =
                evolutionState.settings?.isGuidedBreathingEnabled ?? false;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a1a),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'REST TIMER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      Text(
                        _formatTime(timer.remainingSeconds),
                        style: TextStyle(
                          color: color,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const [FontFeature.tabularFigures()],
                          height: 1.0,
                        ),
                      ),
                      const Spacer(flex: 2),
                      SizedBox(
                        height: 42,
                        width: 42,
                        child: IconButton(
                          onPressed: () =>
                              context.read<WorkoutCubit>().addRestTime(15),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white70,
                            size: 26,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          tooltip: '+15s',
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.08),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          key: TutorialService().getKeyForStep(
                            TutorialStep.increaseRestTime,
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      SizedBox(
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () =>
                              context.read<WorkoutCubit>().cancelRestTimer(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'SKIP',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          key: TutorialService().getKeyForStep(
                            TutorialStep.skipRestTimer,
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withOpacity(0.05),
                      valueColor: AlwaysStoppedAnimation(color),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'GUIDED BREATHING',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 40,
                        child: Switch(
                          value: isBreathingEnabled,
                          onChanged: (val) => context
                              .read<EvolutionCubit>()
                              .toggleGuidedBreathing(),
                          activeColor: Colors.cyanAccent,
                          activeTrackColor: Colors.cyanAccent.withOpacity(0.2),
                          inactiveThumbColor: Colors.white24,
                          inactiveTrackColor: Colors.white10,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                  if (isBreathingEnabled) ...[
                    const SizedBox(height: 16),
                    Center(
                      child: _BreathingGuideView(
                        currentElapsed:
                            timer.durationSeconds - timer.remainingSeconds,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Color _getTimerColor(double progress) {
    if (progress > 0.5) return Colors.greenAccent;
    if (progress > 0.25) return Colors.orangeAccent;
    return Colors.redAccent;
  }
}

class _BreathingGuideView extends StatefulWidget {
  final int currentElapsed;

  const _BreathingGuideView({required this.currentElapsed});

  @override
  State<_BreathingGuideView> createState() => _BreathingGuideViewState();
}

class _BreathingGuideViewState extends State<_BreathingGuideView> {
  int? _initialElapsed;

  @override
  void initState() {
    super.initState();
    _initialElapsed = widget.currentElapsed;
  }

  @override
  Widget build(BuildContext context) {
    // If the widget is rebuilt, we keep the same initial offset for this session
    final elapsed =
        widget.currentElapsed - (_initialElapsed ?? widget.currentElapsed);
    final cycleTime = elapsed % 19;

    String instruction;
    int phaseRemaining;
    Color color;

    if (cycleTime < 4) {
      instruction = "DEEP BREATH IN";
      phaseRemaining = 4 - cycleTime;
      color = Colors.cyanAccent;
    } else if (cycleTime < 11) {
      instruction = "HOLD";
      phaseRemaining = 11 - cycleTime;
      color = Colors.orangeAccent;
    } else {
      instruction = "EXHALE";
      phaseRemaining = 19 - cycleTime;
      color = Colors.blueAccent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            instruction,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 6,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 10,
                color: color.withOpacity(0.5),
              ),
              const SizedBox(width: 4),
              Text(
                "${phaseRemaining}s",
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
