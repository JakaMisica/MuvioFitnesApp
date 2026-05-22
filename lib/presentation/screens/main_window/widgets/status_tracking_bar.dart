import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../logic/cubit/tasks/task_cubit.dart';
import '../../../../logic/cubit/sleep/sleep_cubit.dart';

class StatusTrackingBar extends StatelessWidget {
  const StatusTrackingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Row(
          children: [
            // Exercises
            Expanded(
              child: BlocBuilder<WorkoutCubit, WorkoutState>(
                builder: (context, state) {
                  final total = state.workoutDay?.exercises.length ?? 0;
                  final finished = state.workoutDay?.exercises
                          .where((e) => e.sets.isNotEmpty && e.sets.every((s) => s.isCompleted))
                          .length ??
                      0;
                  return _buildSegment(
                    context,
                    icon: Icons.fitness_center_rounded,
                    label: 'EXERCISES',
                    value: '$finished/$total',
                    progress: total > 0 ? finished / total : 0,
                    color: Colors.cyanAccent,
                  );
                },
              ),
            ),
            _buildDivider(),
            // Tasks
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  final total = state.tasks.length;
                  final finished = state.tasks.where((t) {
                    if (t.lastCompleted == null) return false;
                    return DateUtils.isSameDay(t.lastCompleted, DateTime.now());
                  }).length;
                  return _buildSegment(
                    context,
                    icon: Icons.checklist_rtl_rounded,
                    label: 'TASKS',
                    value: '$finished/$total',
                    progress: total > 0 ? finished / total : 0,
                    color: Colors.orangeAccent,
                  );
                },
              ),
            ),
            _buildDivider(),
            // Sleep
            Expanded(
              child: BlocBuilder<SleepCubit, SleepState>(
                builder: (context, state) {
                  final score = state.latestSession?.qualityScore ?? 0.0;
                  return _buildSegment(
                    context,
                    icon: Icons.nights_stay_rounded,
                    label: 'SLEEP',
                    value: '${score.toInt()}%',
                    progress: score / 100,
                    color: Colors.purpleAccent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: color.withOpacity(0.8)),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 4,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Stack(
              children: [
                AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withOpacity(0.6), color],
                      ),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 7,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.white.withOpacity(0.05),
    );
  }
}
