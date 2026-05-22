import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/task_item.dart';
import '../../../../logic/cubit/tasks/task_cubit.dart';

class AlarmTriggerDialog extends StatefulWidget {
  final TaskItem task;

  const AlarmTriggerDialog({super.key, required this.task});

  @override
  State<AlarmTriggerDialog> createState() => _AlarmTriggerDialogState();
}

class _AlarmTriggerDialogState extends State<AlarmTriggerDialog> {
  int _selectedSnoozeMinutes = 15;
  final List<int> _snoozeOptions = [5, 10, 15, 20, 30, 60, 90];

  @override
  Widget build(BuildContext context) {
    // Increase width to be nearly edge-to-edge
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 500 ? 450.0 : screenWidth * 0.92;

    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: Colors.cyanAccent.withOpacity(0.2), width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with Glow
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.alarm_on_rounded,
                color: Colors.cyanAccent,
                size: 64, // Bigger icon
              ),
            ),
            const SizedBox(height: 32),

            // Task Name
            Text(
              widget.task.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26, // Bigger font
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "ALARM TRIGGERED",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),

            const SizedBox(height: 48),

            // Snooze Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Snooze Duration:",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _selectedSnoozeMinutes,
                      dropdownColor: const Color(0xFF2A2A2A),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.cyanAccent,
                      ),
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedSnoozeMinutes = val);
                        }
                      },
                      items: _snoozeOptions.map((min) {
                        return DropdownMenuItem(
                          value: min,
                          child: Text("${min}m"),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Column(
              children: [
                // Snooze Button
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskCubit>().snoozeTask(
                      widget.task.id,
                      _selectedSnoozeMinutes,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.05),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                  child: Text(
                    "SNOOZE (${_selectedSnoozeMinutes} MIN)",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Done Button
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskCubit>().clearTriggeredTask();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "DONE",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
