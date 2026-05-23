import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_cubit.dart';
import '../../../../logic/cubit/evolution/evolution_state.dart';

class GuidedBreathingOverlay extends StatefulWidget {
  const GuidedBreathingOverlay({super.key});

  @override
  State<GuidedBreathingOverlay> createState() => _GuidedBreathingOverlayState();
}

class _GuidedBreathingOverlayState extends State<GuidedBreathingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _brightnessAnimation;
  late Animation<double> _fogAnimation;
  int _lastCycleTime = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _brightnessAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    _fogAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _wasEnabled = false;
  int _offset = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvolutionCubit, EvolutionState>(
      builder: (context, evolutionState) {
        return BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, workoutState) {
            final timer = workoutState.restTimer;
            final isEnabled =
                evolutionState.settings?.isGuidedBreathingEnabled ?? false;

            if (timer == null || !timer.isActive || !isEnabled) {
              if (_controller.value != 0) _controller.value = 0;
              _wasEnabled = false;
              _lastCycleTime = -1;
              return const SizedBox.shrink();
            }

            final rawElapsed = timer.durationSeconds - timer.remainingSeconds;

            // Capture offset when first enabled to always start with INHALE (phase 0)
            if (!_wasEnabled) {
              _offset = rawElapsed;
              _wasEnabled = true;
            }

            final adjustedElapsed = rawElapsed - _offset;
            final cycleTime = adjustedElapsed % 19;

            if (cycleTime != _lastCycleTime) {
              _lastCycleTime = cycleTime;
              _updateAnimation(cycleTime);
            }

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // Extremely subtle brightness - reduced by 10x from 0.08
                final brightness = _brightnessAnimation.value * 0.008;
                final fogIntensity = (1.0 - _fogAnimation.value) * 0.6;

                return Stack(
                  children: [
                    // Brightness Overlay (Inhale makes it brighter)
                    IgnorePointer(
                      child: Container(
                        color: Colors.white.withOpacity(brightness),
                      ),
                    ),
                    // Fog Boundary (Exhale makes it darker/foggier at edges)
                    IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 1.4,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(fogIntensity),
                            ],
                            stops: const [0.4, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _updateAnimation(int cycleTime) {
    if (cycleTime == 0) {
      // Start of Inhale
      _controller.animateTo(1.0, duration: const Duration(seconds: 4));
    } else if (cycleTime == 11) {
      // Start of Exhale
      _controller.animateBack(0.0, duration: const Duration(seconds: 8));
    }
  }
}
