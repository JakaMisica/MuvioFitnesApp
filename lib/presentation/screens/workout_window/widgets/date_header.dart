import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import 'workout_calendar_dialog.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Internal Green Fog
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
                      Theme.of(context).primaryColor.withOpacity(0.12),
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
                      Theme.of(context).primaryColor.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date Display
                  Expanded(
                    child: BlocBuilder<WorkoutCubit, WorkoutState>(
                      builder: (context, state) {
                        final dayNameStr = DateFormat(
                          'EEEE',
                        ).format(state.selectedDate);
                        final isToday = DateUtils.isSameDay(
                          state.selectedDate,
                          DateTime.now(),
                        );

                        // 10-stage smiley progression
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
                        ];
                        final index =
                            (state.completionProgress * (smileys.length - 1))
                                .clamp(0, smileys.length - 1)
                                .round();
                        var smiley = smileys[index];
                        if (state.workoutDay?.isRestDay == true) smiley = "😴";

                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).primaryColor.withOpacity(0.05),
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1),
                                ),
                              ),
                              child: Text(
                                smiley,
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isToday ? "Today" : dayNameStr,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.cyanAccent,
                                      letterSpacing: 1.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    DateFormat(
                                      'E, MMM d',
                                    ).format(state.selectedDate),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Actions
                  Row(
                    children: [
                      _buildHeaderButton(
                        context,
                        icon: Icons.arrow_upward_rounded,
                        onTap: () {
                          final cubit = context.read<WorkoutCubit>();
                          cubit.selectDate(
                            cubit.state.selectedDate.subtract(
                              const Duration(days: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      _buildHeaderButton(
                        context,
                        icon: Icons.arrow_downward_rounded,
                        onTap: () {
                          final cubit = context.read<WorkoutCubit>();
                          cubit.selectDate(
                            cubit.state.selectedDate.add(
                              const Duration(days: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      _buildHeaderButton(
                        context,
                        icon: Icons.calendar_month_rounded,
                        onTap: () async {
                          final cubit = context.read<WorkoutCubit>();
                          final picked = await showDialog<DateTime>(
                            context: context,
                            builder: (_) => WorkoutCalendarDialog(
                              initialDate: cubit.state.selectedDate,
                              showPreview: true,
                              mode: 'navigate',
                            ),
                          );
                          if (picked != null) cubit.selectDate(picked);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white.withOpacity(0.7), size: 16),
        onPressed: onTap,
        padding: const EdgeInsets.all(7),
        constraints: const BoxConstraints(),
      ),
    );
  }
}
