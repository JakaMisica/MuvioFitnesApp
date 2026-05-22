import 'package:flutter/material.dart';
import 'workout_calendar_dialog.dart';

class CopyWorkoutPicker extends StatelessWidget {
  const CopyWorkoutPicker({super.key});

  @override
  Widget build(BuildContext context) {
    // Just forward to the calendar dialog with showPreview = true
    return WorkoutCalendarDialog(
      initialDate: DateTime.now(),
      showPreview: true,
      mode: 'copy',
    );
  }
}
