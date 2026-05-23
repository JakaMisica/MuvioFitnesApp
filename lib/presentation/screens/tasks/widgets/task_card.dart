import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/task_item.dart';
import '../../../../logic/cubit/tasks/task_cubit.dart';
import '../tasks_screen.dart';
import 'task_form_dialog.dart';
import 'task_analytics_dialog.dart';

class TaskCard extends StatelessWidget {
  final TaskItem task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final sentimentColor = task.getSentimentColor();

    final absSentiment = task.sentiment.abs();
    final isNeutral = absSentiment < 0.3;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF030303),
        borderRadius: BorderRadius.circular(24),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 2.5,
          colors: [
            Colors.white.withOpacity(0.01), // Subtle atmospheric fog
            Colors.transparent,
          ],
        ),
        border: Border.all(
          color: sentimentColor.withOpacity(isNeutral ? 0.08 : 0.4),
          width: isNeutral ? 0.8 : 1.5,
        ),
        boxShadow: [
          if (!isNeutral)
            BoxShadow(
              color: sentimentColor.withOpacity(0.03),
              blurRadius: 24,
              spreadRadius: 4,
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Subtle sentiment glow in the corner
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      sentimentColor.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: task.isNote
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.sticky_note_2_outlined,
                              size: 14,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                task.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _showEditDialog(context),
                              icon: const Icon(Icons.edit, size: 12),
                              color: Colors.white24,
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _confirmDelete(context),
                              icon: const Icon(Icons.delete_outline, size: 12),
                              color: Colors.redAccent.withOpacity(0.3),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTopActionRow(context),
                        const SizedBox(height: 8),
                        _buildCenteredTitle(),
                        if (task.timerType > 0) ...[
                          const SizedBox(height: 8),
                          _buildTimer(context),
                        ],
                        if (_hasAnyMetrics()) ...[
                          const SizedBox(height: 12),
                          _buildMetrics(context),
                        ],
                        if (task.notes.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _buildNotes(),
                        ],
                        if (task.imagePaths.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _buildPhotoPreviews(),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Checkmark
        Builder(
          builder: (ctx) {
            final isCompleted =
                task.lastCompleted != null &&
                DateUtils.isSameDay(task.lastCompleted, DateTime.now());

            IconData icon = Icons.circle_outlined;
            Color color = Colors.white24;

            if (isCompleted) {
              if (task.sentiment < -0.3) {
                icon = Icons.close_rounded;
                color = Colors.redAccent;
              } else if (task.sentiment > 0.3) {
                icon = Icons.check_circle;
                color = Colors.green;
              } else {
                icon = Icons.remove_rounded;
                color = Colors.grey;
              }
            }

            return IconButton(
              icon: Icon(icon, color: color, size: 18),
              onPressed: () {
                context.read<TaskCubit>().completeTask(task.id);
                if (!isCompleted) {
                  _triggerCheckmark(ctx);
                }
              },
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            );
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
            Icons.analytics_outlined,
            color: Colors.white.withOpacity(0.25),
            size: 14,
          ),
          onPressed: () => _showAnalyticsDialog(context),
          tooltip: 'Analytics',
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Colors.white.withOpacity(0.25),
            size: 14,
          ),
          onPressed: () => _showEditDialog(context),
          tooltip: 'Edit',
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.white.withOpacity(0.2),
            size: 14,
          ),
          onPressed: () => _confirmDelete(context),
          tooltip: 'Delete',
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildCenteredTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          task.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
        if (task.recurrenceType > 0) ...[
          const SizedBox(height: 4),
          Text(
            _getRecurrenceLabel(),
            style: TextStyle(
              fontSize: 10,
              color: Colors.cyanAccent.withOpacity(0.6),
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTimer(BuildContext context) {
    final cubit = context.read<TaskCubit>();
    final minutes = task.currentSeconds ~/ 60;
    final seconds = task.currentSeconds % 60;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        children: [
          Text(
            task.isDoubleTimer
                ? (task.isWorkPeriod
                      ? 'FOCUS / WORK PHASE'
                      : 'REST / BREAK PHASE')
                : (task.timerType == 1
                      ? 'Countdown Timer'
                      : (task.timerType == 2
                            ? 'Stopwatch'
                            : 'Scheduled Alarm')),
            style: TextStyle(
              fontSize: 10,
              color: task.isDoubleTimer
                  ? (task.isWorkPeriod
                        ? Colors.orangeAccent
                        : Colors.tealAccent)
                  : Colors.grey.shade500,
              fontWeight: task.isDoubleTimer
                  ? FontWeight.bold
                  : FontWeight.normal,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          if (task.timerType == 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.alarm, color: Colors.cyanAccent, size: 24),
                const SizedBox(width: 8),
                Text(
                  task.alarmTime ?? '--:--',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
              ],
            )
          else
            Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: task.isDoubleTimer
                    ? (task.isWorkPeriod
                          ? Colors.orangeAccent
                          : Colors.tealAccent)
                    : Colors.cyanAccent,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          const SizedBox(height: 8),
          if (task.timerType != 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!task.isTimerRunning) ...[
                  ElevatedButton.icon(
                    onPressed: () => cubit.startTimer(task.id),
                    icon: const Icon(Icons.play_arrow, size: 16),
                    label: const Text('Start', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      minimumSize: const Size(0, 32),
                    ),
                  ),
                ] else ...[
                  ElevatedButton.icon(
                    onPressed: () => cubit.stopTimer(task.id),
                    icon: const Icon(Icons.pause, size: 16),
                    label: const Text('Stop', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      minimumSize: const Size(0, 32),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => cubit.resetTimer(task.id),
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Reset', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 0,
                    ),
                    minimumSize: const Size(0, 32),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notes, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 6),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            task.notes,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade300),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPreviews() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: task.imagePaths.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(task.imagePaths[index]),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetrics(BuildContext context) {
    final cubit = context.read<TaskCubit>();

    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            if (task.hasCounterMetric)
              Builder(
                builder: (btnContext) {
                  final label = task.counterMax > 0
                      ? 'Counter: ${task.counterValue}/${task.counterMax}'
                      : 'Counter: ${task.counterValue}';
                  final isMaxReached =
                      task.counterMax > 0 &&
                      task.counterValue >= task.counterMax;

                  return _buildMetricChip(
                    icon: Icons.add_circle_outline,
                    label: label,
                    isHighlight: isMaxReached,
                    onTap: () {
                      cubit.incrementCounter(task.id);
                      _triggerCheckmark(btnContext);
                    },
                  );
                },
              ),
            if (task.hasDistanceMetric)
              Builder(
                builder: (btnContext) => _buildMetricChip(
                  icon: Icons.directions_run,
                  label: '${task.distanceValue.toStringAsFixed(1)} km',
                  onTap: () => _showUpdateDistance(context, cubit, btnContext),
                ),
              ),
            if (task.hasDoseMetric)
              Builder(
                builder: (btnContext) => _buildMetricChip(
                  icon: Icons.medication,
                  label: task.doseValue.isEmpty ? 'Set Dose' : task.doseValue,
                  onTap: () => _showUpdateDose(context, cubit, btnContext),
                ),
              ),
            if (task.hasWeightMetric)
              Builder(
                builder: (btnContext) => _buildMetricChip(
                  icon: Icons.scale,
                  label: '${task.weightValue.toStringAsFixed(1)} kg',
                  onTap: () => _showUpdateValue(
                    context,
                    cubit,
                    'Weight',
                    'kg',
                    task.weightValue,
                    (v) {
                      cubit.updateWeight(task.id, v);
                      _triggerCheckmark(btnContext);
                    },
                  ),
                ),
              ),
            if (task.hasEnergyMetric)
              Builder(
                builder: (btnContext) => _buildMetricChip(
                  icon: Icons.local_fire_department,
                  label: '${task.energyValue.toInt()} cal',
                  onTap: () => _showUpdateValue(
                    context,
                    cubit,
                    'Energy',
                    'cal',
                    task.energyValue,
                    (v) {
                      cubit.updateEnergy(task.id, v);
                      _triggerCheckmark(btnContext);
                    },
                  ),
                ),
              ),
            if (task.hasPercentageMetric)
              Builder(
                builder: (btnContext) => _buildMetricChip(
                  icon: Icons.percent,
                  label: '${task.percentageValue.toStringAsFixed(1)}%',
                  onTap: () => _showUpdateValue(
                    context,
                    cubit,
                    'Percentage',
                    '%',
                    task.percentageValue,
                    (v) {
                      cubit.updatePercentage(task.id, v);
                      _triggerCheckmark(btnContext);
                    },
                  ),
                ),
              ),
            if (task.hasFinancialMetric)
              Builder(
                builder: (btnContext) => _buildMetricChip(
                  icon: Icons.attach_money,
                  label:
                      '${task.currency} ${task.financialValue.toStringAsFixed(2)}',
                  onTap: () => _showUpdateValue(
                    context,
                    cubit,
                    'Financial',
                    task.currency,
                    task.financialValue,
                    (v) {
                      cubit.updateFinancial(task.id, v);
                      _triggerCheckmark(btnContext);
                    },
                  ),
                ),
              ),
          ],
        ),
        if (task.hasRatingMetric) ...[
          const SizedBox(height: 16),
          _buildInlineRating(context, cubit),
        ],
      ],
    );
  }

  Widget _buildInlineRating(BuildContext context, TaskCubit cubit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: List.generate(10, (index) {
            final rating = index + 1;
            final isSelected = task.ratingValue == rating;
            return GestureDetector(
              onTap: () {
                cubit.updateRating(task.id, rating);
                _triggerCheckmark(context);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.cyanAccent
                      : Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.cyanAccent
                        : Colors.white.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.cyanAccent.withOpacity(0.3),
                            blurRadius: 6,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    "$rating",
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMetricChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isHighlight = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isHighlight
              ? Colors.green.withOpacity(0.3)
              : Colors.cyanAccent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHighlight
                ? Colors.green
                : Colors.cyanAccent.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isHighlight ? Colors.greenAccent : Colors.cyanAccent,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasAnyMetrics() {
    return task.hasCounterMetric ||
        task.hasDistanceMetric ||
        task.hasDoseMetric ||
        task.hasWeightMetric ||
        task.hasEnergyMetric ||
        task.hasRatingMetric ||
        task.hasPercentageMetric ||
        task.hasFinancialMetric;
  }

  String _getRecurrenceLabel() {
    switch (task.recurrenceType) {
      case 1:
        return 'Daily';
      case 2:
        return 'Weekly';
      case 3:
        return 'Custom';
      case 4:
        return 'Monthly';
      default:
        return '';
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskCubit>().deleteTask(task.id);
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showUpdateDistance(
    BuildContext context,
    TaskCubit cubit,
    BuildContext btnContext,
  ) {
    final controller = TextEditingController(
      text: task.distanceValue.toString(),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Distance'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Distance (km)',
            suffixText: 'km',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final distance = double.tryParse(controller.text) ?? 0.0;
              cubit.updateDistance(task.id, distance);
              _triggerCheckmark(btnContext);
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showUpdateDose(
    BuildContext context,
    TaskCubit cubit,
    BuildContext btnContext,
  ) {
    final controller = TextEditingController(text: task.doseValue);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Dose'),
        backgroundColor: Colors.grey.shade900,
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Dose',
            labelStyle: TextStyle(color: Colors.grey),
            hintText: 'e.g., 10mg, 2 pills',
            hintStyle: TextStyle(color: Colors.white24),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              cubit.updateDose(task.id, controller.text);
              _triggerCheckmark(btnContext);
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showUpdateValue(
    BuildContext context,
    TaskCubit cubit,
    String title,
    String unit,
    double current,
    Function(double) onSave,
  ) {
    final controller = TextEditingController(text: current.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text('Update $title'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: '$title ($unit)',
            labelStyle: const TextStyle(color: Colors.grey),
            suffixText: unit,
            suffixStyle: const TextStyle(color: Colors.cyanAccent),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final val = double.tryParse(controller.text) ?? 0.0;
              onSave(val);
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<TaskCubit>(),
        child: TaskFormDialog(task: task),
      ),
    );
  }

  void _showAnalyticsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => TaskAnalyticsDialog(task: task),
    );
  }

  void _triggerCheckmark(BuildContext context) {
    if (task.sentiment < 0) return; // Don't celebrate addiction

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(
        Offset(renderBox.size.width / 2, renderBox.size.height / 2),
      );
      taskCelebrationKey.currentState?.popCheckmark(position);
    }
  }
}
