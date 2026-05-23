import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../logic/cubit/tasks/task_cubit.dart';
import '../../../logic/cubit/social/social_cubit.dart';
import 'dart:convert';
import '../../../data/models/task_item.dart';
import 'widgets/task_card.dart';
import 'widgets/task_form_dialog.dart';
import '../workout_window/widgets/celebration_particles.dart';
import '../../widgets/foggy_background.dart';
import '../../widgets/custom_reorderable_drag_listener.dart';

final GlobalKey<CelebrationParticlesState> taskCelebrationKey =
    GlobalKey<CelebrationParticlesState>();

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CelebrationParticles(
      key: taskCelebrationKey,
      child: const _TasksContent(),
    );
  }
}

class _TasksContent extends StatefulWidget {
  const _TasksContent();

  @override
  State<_TasksContent> createState() => _TasksContentState();
}

class _TasksContentState extends State<_TasksContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _calculateMoodProgress(List<TaskItem> tasks) {
    if (tasks.isEmpty) return 0.5;

    double totalPossibleWeight = 0;
    double currentMoodDelta = 0;

    for (var task in tasks) {
      if (task.isNote) continue;

      final weight = task.sentiment.abs();
      // We count all non-neutral tasks to establish a baseline for "the day"
      if (weight > 0.1) {
        totalPossibleWeight += weight;
      }

      bool isPerformed = false;
      if (task.hasCounterMetric && task.counterValue > 0) isPerformed = true;
      if (task.lastCompleted != null) {
        final now = DateTime.now();
        if (DateUtils.isSameDay(task.lastCompleted, now)) {
          isPerformed = true;
        }
      }

      // Check other activity indicators
      if (task.hasDistanceMetric && task.distanceValue > 0) isPerformed = true;
      if (task.hasDoseMetric && task.doseValue.isNotEmpty) isPerformed = true;
      if (task.hasWeightMetric && task.weightValue > 0) isPerformed = true;
      if (task.hasEnergyMetric && task.energyValue > 0) isPerformed = true;
      if (task.hasRatingMetric && task.ratingValue > 0) isPerformed = true;
      if (task.hasFinancialMetric && task.financialValue > 0)
        isPerformed = true;

      if (isPerformed) {
        // Performing a task applies its sentiment.
        // Good task (+0.8) adds to happiness.
        // Addiction task (-1.0) subtracts from happiness.
        currentMoodDelta += task.sentiment;
      }
    }

    if (totalPossibleWeight == 0) return 0.5;

    // Normalize to -1.0 to 1.0 range
    final normalized = (currentMoodDelta / totalPossibleWeight).clamp(
      -1.0,
      1.0,
    );

    // Convert to 0.0 (Sad) to 1.0 (Happy)
    return (normalized * 0.5) + 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listenWhen: (prev, curr) {
        final prevMood = _calculateMoodProgress(prev.tasks);
        final currMood = _calculateMoodProgress(curr.tasks);
        // Only trigger celebration on happiness INCREASE
        return (currMood * 10).floor() > (prevMood * 10).floor() &&
            currMood > 0.5;
      },
      listener: (context, state) {
        taskCelebrationKey.currentState?.explodeConfetti();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: FoggyBackground(
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(
                Colors.cyanAccent.withOpacity(0.55),
              ),
              trackColor: WidgetStateProperty.all(
                Colors.white.withOpacity(0.04),
              ),
              trackBorderColor: WidgetStateProperty.all(Colors.transparent),
              thickness: WidgetStateProperty.all(5),
              radius: const Radius.circular(10),
              crossAxisMargin: 4,
              mainAxisMargin: 80.0,
              thumbVisibility: WidgetStateProperty.all(true),
              trackVisibility: WidgetStateProperty.all(true),
            ),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              interactive: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildHeader(context),
                    BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.cyanAccent,
                              ),
                            ),
                          );
                        }

                        if (state.tasks.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60),
                            child: _buildEmptyState(context),
                          );
                        }

                        return ReorderableListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          buildDefaultDragHandles: false,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          proxyDecorator: (child, index, animation) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (context, child) {
                                return Material(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: Opacity(opacity: 0.7, child: child),
                                );
                              },
                              child: child,
                            );
                          },
                          itemCount: state.tasks.length,
                          onReorder: (oldIndex, newIndex) {
                            context.read<TaskCubit>().reorderTasks(
                              oldIndex,
                              newIndex,
                            );
                          },
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return FastReorderableDelayedDragStartListener(
                              key: ValueKey(task.id),
                              index: index,
                              dragDelay: const Duration(milliseconds: 250),
                              child: TaskCard(task: task),
                            );
                          },
                        );
                      },
                    ),
                    // Action Buttons at BOTTOM
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildBottomActionButton(
                              onPressed: () =>
                                  _showAddTaskDialog(context, isNote: true),
                              icon: Icons.note_add_outlined,
                              label: 'Add Note',
                              color: Colors.white.withOpacity(0.05),
                              borderColor: Colors.white.withOpacity(0.1),
                              textColor: Colors.white.withOpacity(0.7),
                              iconColor: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildBottomActionButton(
                              onPressed: () => _showAddTaskDialog(context),
                              icon: Icons.add_rounded,
                              label: 'New Task',
                              color: Colors.cyanAccent.withOpacity(0.1),
                              borderColor: Colors.cyanAccent.withOpacity(0.3),
                              textColor: Colors.cyanAccent,
                              iconColor: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                      child: _buildBottomActionButton(
                        onPressed: () => _showTaskSharePicker(context),
                        icon: Icons.share_outlined,
                        label: 'Share All Tasks',
                        color: Colors.purpleAccent.withOpacity(0.1),
                        borderColor: Colors.purpleAccent.withOpacity(0.3),
                        textColor: Colors.purpleAccent,
                        iconColor: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
    required Color borderColor,
    required Color textColor,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final moodProgress = _calculateMoodProgress(state.tasks);

        final smileys = [
          "😞",
          "😟",
          "😐",
          "🙂",
          "😊",
          "😁",
          "😆",
          "🥳",
          "😎",
          "🤩",
          "🎆",
        ];
        final smileyIndex = (moodProgress * (smileys.length - 1)).round().clamp(
          0,
          smileys.length - 1,
        );
        final smiley = smileys[smileyIndex];

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.blueAccent.withOpacity(0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.05),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Internal Blue Fog
                Positioned(
                  top: -30,
                  left: -30,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  right: 20,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.05),
                          border: Border.all(
                            color: Colors.blueAccent.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          smiley,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tasks & Habits',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w900,
                                color: Colors.cyanAccent,
                                letterSpacing: 0.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.cyanAccent.withOpacity(0.3),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              DateFormat('E, MMM d').format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.read<TaskCubit>().createDefaultTasks(),
                        icon: Icon(
                          Icons.sync_rounded,
                          color: Colors.blueAccent.withOpacity(0.6),
                          size: 20,
                        ),
                        tooltip: 'Restore Defaults',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 100, color: Colors.grey.shade800),
          const SizedBox(height: 24),
          Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first task',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, {bool isNote = false}) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<TaskCubit>(),
        child: TaskFormDialog(
          task: isNote ? TaskItem(name: '', isNote: true) : null,
          isNote: isNote,
        ),
      ),
    );
  }

  void _showTaskSharePicker(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    final tasks = taskCubit.state.tasks;
    if (tasks.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No tasks to share!")));
      return;
    }

    // Serialize tasks
    final data = {
      'tasks': tasks.map((t) {
        return {
          'name': t.name,
          'sentiment': t.sentiment,
          'isNote': t.isNote,
          'recurrenceType': t.recurrenceType,
        };
      }).toList(),
    };

    final socialCubit = context.read<SocialCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'SHARE TASK LIST TO',
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...socialCubit.state.conversations.map((conv) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: conv.isGroup
                      ? Colors.purple
                      : Colors.purpleAccent,
                  child: Icon(
                    conv.isGroup ? Icons.groups : Icons.checklist,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                title: Text(
                  conv.name,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  socialCubit.shareContent(
                    conv.remoteId,
                    "Shared a task list with you.",
                    'task',
                    jsonEncode(data),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Shared with ${conv.name}")),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
