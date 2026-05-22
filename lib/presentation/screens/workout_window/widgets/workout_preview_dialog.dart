import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data/repositories/workout_repository.dart';
import '../../../../locator.dart';

class WorkoutPreviewDialog extends StatelessWidget {
  final DateTime date;
  final String mode; // 'copy' or 'navigate'

  const WorkoutPreviewDialog({
    super.key,
    required this.date,
    this.mode = 'copy',
  });

  @override
  Widget build(BuildContext context) {
    final repo = locator<WorkoutRepository>();

    return AlertDialog(
      title: Text("Workout from ${DateFormat('EEEE, MMM d').format(date)}"),
      content: FutureBuilder(
        future: repo.getWorkoutForDate(date),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final workout = snapshot.data;
          if (workout == null || workout.exercises.isEmpty) {
            return const Text("No exercises found.");
          }

          final exercisesList = workout.exercises.toList();

          return SizedBox(
            width: 400,
            height: 300,
            child: ListView.builder(
              itemCount: exercisesList.length,
              itemBuilder: (context, index) {
                final log = exercisesList[index];
                // Exercise name should be loaded already, but let's ensure
                final name = log.exercise.value?.name ?? "Unknown";
                final setCount = log.sets.length;

                return ListTile(
                  leading: Icon(
                    Icons.fitness_center,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(name),
                  subtitle: Text("$setCount sets"),
                );
              },
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Close"),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(mode == 'copy' ? Icons.check : Icons.calendar_today),
          label: Text(mode == 'copy' ? "Copy This" : "Jump to Date"),
        ),
      ],
    );
  }
}
