import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../data/models/sleep_models.dart';
import '../../../../presentation/widgets/custom_time_picker.dart';

class AutoTrackDialog extends StatefulWidget {
  final SleepSettings settings;
  final Function(int, String) onScheduleChanged;
  final Function(bool) onToggle;

  const AutoTrackDialog({
    super.key,
    required this.settings,
    required this.onScheduleChanged,
    required this.onToggle,
  });

  @override
  State<AutoTrackDialog> createState() => _AutoTrackDialogState();
}

class _AutoTrackDialogState extends State<AutoTrackDialog> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.settings.autoTrackEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF121212),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.1)),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "AUTO TRACKING",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                Switch(
                  value: _isEnabled,
                  onChanged: (val) {
                    setState(() => _isEnabled = val);
                    widget.onToggle(val);
                  },
                  activeColor: Colors.blueAccent,
                ),
              ],
            ),
            const Gap(16),
            const Text(
              "Set separate schedules for each day. The AI will start and stop monitoring automatically.",
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
            const Gap(24),
            SizedBox(
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return _buildDayRow(index);
                },
              ),
            ),
            const Gap(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "DONE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(int index) {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final schedule = widget.settings.daySchedules[index];
    final parts = schedule.split('-');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Text(
              days[index],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Row(
              children: [
                _buildTimeButton(index, parts[0], true),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "to",
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ),
                _buildTimeButton(index, parts[1], false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton(int dayIndex, String timeStr, bool isStart) {
    return Expanded(
      child: InkWell(
        onTap: () => _pickTime(dayIndex, timeStr, isStart),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Text(
            timeStr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _pickTime(int dayIndex, String currentStr, bool isStart) async {
    final parts = currentStr.split(':');
    final initial = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final result = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) => CustomTimePickerDialog(
        initialTime: initial,
        title: isStart ? "START TIME" : "STOP TIME",
      ),
    );

    if (result != null) {
      final newTime =
          "${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";
      final currentSchedule = widget.settings.daySchedules[dayIndex];
      final parts = currentSchedule.split('-');

      String newSchedule;
      if (isStart) {
        newSchedule = "$newTime-${parts[1]}";
      } else {
        newSchedule = "${parts[0]}-$newTime";
      }

      setState(() {
        widget.onScheduleChanged(dayIndex, newSchedule);
      });
    }
  }
}
