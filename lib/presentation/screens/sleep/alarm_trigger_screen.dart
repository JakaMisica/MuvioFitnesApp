import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:vibration/vibration.dart';
import '../../../logic/cubit/sleep/sleep_cubit.dart';

class AlarmTriggerScreen extends StatefulWidget {
  const AlarmTriggerScreen({super.key});

  @override
  State<AlarmTriggerScreen> createState() => _AlarmTriggerScreenState();
}

class _AlarmTriggerScreenState extends State<AlarmTriggerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int? _tempSnoozeMinutes;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SleepCubit, SleepState>(
      listenWhen: (prev, curr) => prev.alarmTriggered && !curr.alarmTriggered,
      listener: (context, state) {
        if (!state.alarmTriggered) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<SleepCubit, SleepState>(
        builder: (context, state) {
          final snoozeDuration =
              _tempSnoozeMinutes ?? state.snoozeDurationMinutes;

          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                // Ambient Glowing Background
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [
                          Colors.cyanAccent.withOpacity(0.08),
                          Colors.purpleAccent.withOpacity(0.05),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ),

                // Animated Particles or Scanline effect could go here
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 48,
                    ),
                    child: Column(
                      children: [
                        const Spacer(),

                        // Pulsing Central Icon
                        Center(
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.cyanAccent.withOpacity(0.05),
                                  border: Border.all(
                                    color: Colors.cyanAccent.withOpacity(
                                      0.3 + (0.4 * _pulseController.value),
                                    ),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyanAccent.withOpacity(
                                        0.15 * _pulseController.value,
                                      ),
                                      blurRadius: 40,
                                      spreadRadius:
                                          10 + (20 * _pulseController.value),
                                    ),
                                    BoxShadow(
                                      color: Colors.purpleAccent.withOpacity(
                                        0.1 * (1 - _pulseController.value),
                                      ),
                                      blurRadius: 60,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.alarm_rounded,
                                  color: Colors.white,
                                  size: 80 + (10 * _pulseController.value),
                                ),
                              );
                            },
                          ),
                        ),

                        const Gap(40),

                        const Text(
                          "WAKE UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 10,
                            shadows: [
                              Shadow(color: Colors.cyanAccent, blurRadius: 20),
                            ],
                          ),
                        ),

                        Text(
                          "RECOVERY OPTIMIZED",
                          style: TextStyle(
                            color: Colors.cyanAccent.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),

                        const Spacer(),

                        // Snooze Duration Selector (Premium Touch)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "SNOOZE DURATION",
                                style: TextStyle(
                                  color: Colors.white24,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const Gap(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [5, 10, 15, 30, 45].map((m) {
                                  final isSelected = snoozeDuration == m;
                                  return GestureDetector(
                                    onTap: () =>
                                        setState(() => _tempSnoozeMinutes = m),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.cyanAccent
                                            : Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: isSelected
                                            ? [
                                                BoxShadow(
                                                  color: Colors.cyanAccent
                                                      .withOpacity(0.3),
                                                  blurRadius: 10,
                                                ),
                                              ]
                                            : [],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${m}m",
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.white38,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        const Gap(32),

                        // Main Actions
                        _buildButton(
                          label: "SNOOZE ($snoozeDuration MIN)",
                          color: Colors.cyanAccent,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.cyanAccent.withOpacity(0.5),
                          onTap: () {
                            debugPrint("SNOOZE button tapped!");
                            Vibration.vibrate(duration: 50);
                            context.read<SleepCubit>().snooze(snoozeDuration);
                          },
                        ),
                        const Gap(16),
                        _buildButton(
                          label: "DISMISS ALARM",
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          onTap: () {
                            debugPrint("DISMISS button tapped!");
                            Vibration.vibrate(duration: 100);
                            context.read<SleepCubit>().stopAlarm();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required Color backgroundColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: backgroundColor != Colors.transparent
            ? [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 2)
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
