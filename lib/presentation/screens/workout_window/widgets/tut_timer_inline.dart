import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import 'dart:ui';

class TutTimerInline extends StatelessWidget {
  const TutTimerInline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final timer = state.tutTimer;
        if (timer == null) return const SizedBox.shrink();

        final isPrep = timer.isPreparing;
        final color = isPrep ? Colors.orangeAccent : Colors.blueAccent;
        final title = isPrep ? 'PREPARING' : 'TIME UNDER TENSION';
        final displayTime =
            isPrep ? timer.prepRemainingSeconds : timer.elapsedSeconds;

        return TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 1),
          tween: Tween(begin: 0.98, end: 1.0),
          curve: Curves.easeInOutSine,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: isPrep ? scale : 1.0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.4), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.15),
                      blurRadius: 15,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: color.withOpacity(0.9),
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.read<WorkoutCubit>().stopTutTimer(),
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Timer Text
                        Text(
                          _formatTime(displayTime),
                          style: TextStyle(
                            color: color,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFeatures: const [FontFeature.tabularFigures()],
                            height: 1.0,
                            shadows: [
                              Shadow(
                                color: color.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Action Buttons Layer
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Restart Button
                            SizedBox(
                              height: 34,
                              width: 34,
                              child: IconButton(
                                onPressed: () => context
                                    .read<WorkoutCubit>()
                                    .restartTutTimer(),
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white70,
                                  size: 18,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Restart (${timer.totalPrepSeconds}s prep)',
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.08),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isPrep)
                              // Skip Prep Button
                              SizedBox(
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () => context
                                      .read<WorkoutCubit>()
                                      .skipTutTimer(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation: 2,
                                    shadowColor:
                                    Colors.blueAccent.withOpacity(0.3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'START',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              )
                            else ...[
                              // Skip Timer & Auto-calc Button
                              SizedBox(
                                height: 32,
                                child: OutlinedButton(
                                  onPressed: () {
                                    final cubit = context.read<WorkoutCubit>();
                                    final logId = timer.exerciseLogId;
                                    final setIdx = timer.setIndex;
                                    final set = state.workoutDay?.exercises
                                        .firstWhereOrNull((e) => e.id == logId)
                                        ?.sets[setIdx];
                                    if (set != null) {
                                      cubit.skipTutAndFinishSet(
                                          logId, setIdx, set);
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white70,
                                    side: const BorderSide(
                                        color: Colors.white10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'SKIP',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Finish Button
                              SizedBox(
                                height: 32,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final cubit = context.read<WorkoutCubit>();
                                    final logId = timer.exerciseLogId;
                                    final setIdx = timer.setIndex;
                                    final set = state.workoutDay?.exercises
                                        .firstWhere((e) => e.id == logId)
                                        .sets[setIdx];
                                    if (set != null) {
                                      cubit.finishTutSet(logId, setIdx, set);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00E676),
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    elevation: 2,
                                    shadowColor: const Color(0xFF00E676)
                                        .withOpacity(0.3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'FINISH',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Simulating an indeterminate bar or just a static line since it counts up
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                         value: isPrep
                            ? (timer.prepRemainingSeconds /
                                (timer.totalPrepSeconds > 0 ? timer.totalPrepSeconds : 1))
                            : null,
                        backgroundColor: Colors.white.withOpacity(0.05),
                        valueColor: AlwaysStoppedAnimation(color),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins}:${secs.toString().padLeft(2, '0')}';
  }
}
