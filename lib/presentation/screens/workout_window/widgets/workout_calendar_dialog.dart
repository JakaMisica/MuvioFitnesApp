import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../data/repositories/workout_repository.dart';
import '../../../../data/models/enums.dart';
import '../../../../locator.dart';
import 'workout_preview_dialog.dart';

class WorkoutCalendarDialog extends StatefulWidget {
  final DateTime initialDate;
  final bool
  showPreview; // If false, just select and return. If true, show preview on tap
  final String
  mode; // 'copy' or 'navigate' - determines preview dialog button text

  const WorkoutCalendarDialog({
    super.key,
    required this.initialDate,
    this.showPreview = false,
    this.mode = 'navigate',
  });

  @override
  State<WorkoutCalendarDialog> createState() => _WorkoutCalendarDialogState();
}

class _WorkoutCalendarDialogState extends State<WorkoutCalendarDialog> {
  late DateTime _focusedDay;
  Map<DateTime, MuscleGroup> _workoutDays = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final repo = locator<WorkoutRepository>();
    final days = await repo.getDaysWithWorkouts();

    final Map<DateTime, MuscleGroup> workouts = {};
    for (final date in days) {
      // Get first exercise's muscle group
      final workout = await repo.getWorkoutForDate(date);
      if (workout != null && workout.exercises.isNotEmpty) {
        await workout.exercises.first.exercise.load();
        final muscle = workout.exercises.first.exercise.value?.muscleGroup;
        if (muscle != null) {
          workouts[DateTime(date.year, date.month, date.day)] = muscle;
        }
      }
    }

    setState(() {
      _workoutDays = workouts;
      _isLoading = false;
    });
  }

  Color _getMuscleColor(MuscleGroup group) {
    switch (group) {
      case MuscleGroup.chest:
        return Colors.blue;
      case MuscleGroup.shoulders:
        return Colors.green;
      case MuscleGroup.arms:
        return Colors.yellow;
      case MuscleGroup.back:
        return Colors.green[800]!;
      case MuscleGroup.legs:
        return Colors.purple;
      case MuscleGroup.cardio:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return AlertDialog(
        content: SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AlertDialog(
      title: Text(widget.showPreview ? "Copy Workout From..." : "Select Date"),
      content: SizedBox(
        width: 450,
        height: 480,
        child: TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          rangeSelectionMode: RangeSelectionMode.disabled,
          rowHeight: 52,
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headerPadding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          onDaySelected: (selectedDay, focusedDay) async {
            if (widget.showPreview) {
              // Smart Copy mode - show preview if there's a workout
              final normalizedDay = DateTime(
                selectedDay.year,
                selectedDay.month,
                selectedDay.day,
              );

              if (_workoutDays.containsKey(normalizedDay)) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) => WorkoutPreviewDialog(
                    date: selectedDay,
                    mode: widget.mode,
                  ),
                );

                if (confirmed == true && mounted) {
                  Navigator.pop(context, selectedDay);
                }
              } else if (widget.mode == 'navigate') {
                // Allow jumping to empty days for navigation
                Navigator.pop(context, selectedDay);
              }
            } else {
              // Normal navigation mode - just select and return
              Navigator.pop(context, selectedDay);
            }
          },
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final normalizedDay = DateTime(day.year, day.month, day.day);
              final muscle = _workoutDays[normalizedDay];

              if (muscle != null) {
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _getMuscleColor(muscle),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return null;
            },
            outsideBuilder: (context, day, focusedDay) {
              final normalizedDay = DateTime(day.year, day.month, day.day);
              final muscle = _workoutDays[normalizedDay];

              if (muscle != null) {
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _getMuscleColor(muscle).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                );
              }
              return null;
            },
            todayBuilder: (context, day, focusedDay) {
              final normalizedDay = DateTime(day.year, day.month, day.day);
              final muscle = _workoutDays[normalizedDay];

              if (muscle != null) {
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _getMuscleColor(muscle),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              return Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
