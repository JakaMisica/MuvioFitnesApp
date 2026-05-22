import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/services/tutorial_service.dart';

class TutorialOverlay extends StatefulWidget {
  final Widget child;
  const TutorialOverlay({super.key, required this.child});

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  final TutorialService _service = TutorialService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TutorialStep?>(
      stream: _service.stepStream,
      builder: (context, snapshot) {
        final step = snapshot.data;
        if (step == null || step == TutorialStep.completed) {
          return widget.child;
        }

        return Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: _TutorialOverlayContent(step: step),
            ),
          ],
        );
      },
    );
  }
}

class _TutorialOverlayContent extends StatefulWidget {
  final TutorialStep step;
  const _TutorialOverlayContent({required this.step});

  @override
  State<_TutorialOverlayContent> createState() => _TutorialOverlayContentState();
}

class _TutorialOverlayContentState extends State<_TutorialOverlayContent> {
  final TutorialService _service = TutorialService();
  Rect? _targetRect;
  double _brightnessOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateRect();
    _handleSpecialSteps();
  }

  @override
  void didUpdateWidget(_TutorialOverlayContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step != widget.step) {
      _calculateRect();
      _handleSpecialSteps();
    }
  }

  void _handleSpecialSteps() {
    if (widget.step == TutorialStep.swipeToWorkout) {
      _triggerSwipe(5);
    } else if (widget.step == TutorialStep.swipeToCoach) {
      _triggerSwipe(6);
    } else if (widget.step == TutorialStep.swipeToSocial) {
      _triggerSwipe(7);
    } else if (widget.step == TutorialStep.coachWait) {
      _triggerCoachAnimation();
    } else if (widget.step == TutorialStep.swipeToFinish) {
      _triggerSwipe(0);
    }
  }

  void _triggerSwipe(int page) {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      try {
        final pc = context.read<PageController>();
        pc.animateToPage(
          page,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutQuart,
        ).then((_) {
          if (mounted) _service.next();
        });
      } catch (e) {
        _service.next();
      }
    });
  }

  void _triggerCoachAnimation() async {
    // 1. Reveal (Opacity 0)
    setState(() => _brightnessOpacity = 0.0);
    
    // 2. Wait 5s
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;

    // 3. Slowly dim again
    for (int i = 0; i <= 20; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return;
      setState(() {
        _brightnessOpacity = (i / 20.0) * 0.8;
      });
    }

    // 4. Proceed
    if (mounted) _service.next();
  }

  Widget _buildBrightnessOverlay() {
    if (widget.step != TutorialStep.coachWait) return const SizedBox.shrink();
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _brightnessOpacity,
          child: Container(color: Colors.black),
        ),
      ),
    );
  }

  void _calculateRect() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final key = _service.getKeyForStep(widget.step);
      if (key != null && key.currentContext != null) {
        final RenderBox? box = key.currentContext!.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          // MATH: Calculate position relative to the root overlay (this Stack)
          final RenderBox overlayBox = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero, ancestor: overlayBox);
          setState(() {
            _targetRect = position & box.size;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isInteractive = false;
    bool showWhiteBorder = false;

    switch (widget.step) {
      case TutorialStep.expandMetrics:
        isInteractive = true;
        showWhiteBorder = true;
        break;
      case TutorialStep.gainsBox:
      case TutorialStep.weightBox:
      case TutorialStep.bodyFatBox:
      case TutorialStep.gripBox:
      case TutorialStep.startWorkout:
      case TutorialStep.firstExercise:
      case TutorialStep.addExerciseToDay:
      case TutorialStep.restTimerTag:
      case TutorialStep.increaseRestTime:
      case TutorialStep.saveRestTime:
      case TutorialStep.tutTag:
      case TutorialStep.prepTimeTag:
      case TutorialStep.savePrepTime:
      case TutorialStep.exerciseOptions:
      case TutorialStep.rirOption:
      case TutorialStep.typeRir:
      case TutorialStep.saveRir:
      case TutorialStep.addSet:
      case TutorialStep.logSet:
      case TutorialStep.startRestTimer:
      case TutorialStep.finishRestTimer:
      case TutorialStep.exerciseGraph:
      case TutorialStep.skipRestTimer:
      case TutorialStep.squadItem:
      case TutorialStep.squadDetailsIcon:
      case TutorialStep.workoutPlanButton:
        isInteractive = true;
        break;
      case TutorialStep.swipeToWorkout:
      case TutorialStep.swipeToCoach:
      case TutorialStep.swipeToSocial:
      case TutorialStep.swipeToFinish:
      case TutorialStep.coachWait:
        isInteractive = false;
        break;
      default:
        isInteractive = false;
        break;
    }

    double brightnessOpacity = 0.0;
    if (widget.step == TutorialStep.coachWait) {
       // Calculation for brightness reveal will be handled by state
    }

    return Stack(
      children: [
        // 1. Hole Puncher Mask
        if (_targetRect != null)
          Positioned.fill(
            child: IgnorePointer(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.85), BlendMode.srcOut),
                child: Stack(
                  children: [
                    Container(decoration: const BoxDecoration(color: Colors.white, backgroundBlendMode: BlendMode.dstOut)),
                    Positioned(
                      top: _targetRect!.top - 4,
                      left: _targetRect!.left - 4,
                      width: _targetRect!.width + 8,
                      height: _targetRect!.height + 8,
                      child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16))),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          Positioned.fill(child: IgnorePointer(child: Container(color: Colors.black.withOpacity(0.85)))),

        // 2. Brightness Overlay (for AI Coach reveal)
        _buildBrightnessOverlay(),

        // 3. White Border
        if (_targetRect != null && showWhiteBorder)
          Positioned(
            top: _targetRect!.top - 4,
            left: _targetRect!.left - 4,
            width: _targetRect!.width + 8,
            height: _targetRect!.height + 8,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 3.5),
                  boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 15)],
                ),
              ),
            ),
          ),

        // 4. Selective Hit-Testing
        if (_targetRect != null) ..._buildBlockingLayers(_targetRect!),

        // 4. Instructions
        _buildStepContent(widget.step, _targetRect, isInteractive),
      ],
    );
  }

  List<Widget> _buildBlockingLayers(Rect target) {
    final size = MediaQuery.of(context).size;
    return [
      Positioned(top: 0, left: 0, right: 0, height: target.top, child: GestureDetector(onTap: () {}, behavior: HitTestBehavior.opaque, child: Container(color: Colors.transparent))),
      Positioned(top: target.bottom, left: 0, right: 0, bottom: 0, child: GestureDetector(onTap: () {}, behavior: HitTestBehavior.opaque, child: Container(color: Colors.transparent))),
      Positioned(top: target.top, bottom: size.height - target.bottom, left: 0, width: target.left, child: GestureDetector(onTap: () {}, behavior: HitTestBehavior.opaque, child: Container(color: Colors.transparent))),
      Positioned(top: target.top, bottom: size.height - target.bottom, left: target.right, right: 0, child: GestureDetector(onTap: () {}, behavior: HitTestBehavior.opaque, child: Container(color: Colors.transparent))),
    ];
  }

  Widget _buildStepContent(TutorialStep step, Rect? targetRect, bool isInteractive) {
    String title = "";
    String description = "";
    
    switch (step) {
      case TutorialStep.welcome: title = "WELCOME CITIZEN"; description = "Welcome to your Muvio dashboard."; break;
      case TutorialStep.rewardMetrics: title = "YOUR REWARDS"; description = "Track Muscle Points and Coins."; break;
      case TutorialStep.measurements: title = "METRIC LOG"; description = "Log measurements to track changes."; break;
      case TutorialStep.gainsAnalytics: title = "VOLUME ANALYTICS"; description = "Track session volume trends."; break;
      case TutorialStep.gainsBox: title = "MUSCLE GAINS"; description = "Click to see gains distribution."; break;
      case TutorialStep.weightBox: title = "WEIGHT LOGGING"; description = "Log weight daily in the morning!"; break;
      case TutorialStep.bodyFatBox: title = "BODY FAT %"; description = "Monitor body composition changes."; break;
      case TutorialStep.expandMetrics: title = "REVEAL MORE"; description = "Click this button to see Grip Strength."; break;
      case TutorialStep.gripBox: title = "GRIP STRENGTH"; description = "Indicator of overall vitality."; break;
      case TutorialStep.swipeToWorkout: title = "HEADING TO WORKOUT"; description = "Hold tight, shifting environments..."; break;
      case TutorialStep.startWorkout: title = "BEGIN PROTOCOL"; description = "Press Start Workout to begin your session."; break;
      case TutorialStep.firstExercise: title = "SELECT DRILL"; description = "Choose your first exercise to log."; break;
      case TutorialStep.addExerciseToDay: title = "LOG ACTIVITY"; description = "Click again to add it to your schedule."; break;
      case TutorialStep.restTimerTag: title = "REST MANAGEMENT"; description = "Tap the rest timer to adjust your recovery."; break;
      case TutorialStep.increaseRestTime: title = "EXTEND RECOVERY"; description = "Add seconds to your rest window."; break;
      case TutorialStep.saveRestTime: title = "SAVE SETTINGS"; description = "Confirm your new rest duration."; break;
      case TutorialStep.tutTag: title = "TEMPO TRACKING"; description = "Adjust Time Under Tension if needed."; break;
      case TutorialStep.prepTimeTag: title = "PREP WINDOW"; description = "Adjust preparation time before sets."; break;
      case TutorialStep.exerciseOptions: title = "LOG OPTIONS"; description = "More tools for precise logging."; break;
      case TutorialStep.rirOption: title = "EXERTION LEVEL"; description = "Tap RIR to log Reps in Reserve."; break;
      case TutorialStep.typeRir: title = "NEURAL INPUT"; description = "Type '2' to set your target intensity."; break;
      case TutorialStep.saveRir: title = "INTENSITY SAVED"; description = "Confirm and proceed."; break;
      case TutorialStep.addSet: title = "VOLUME EXPANSION"; description = "Add a new set to your workout."; break;
      case TutorialStep.logSet: title = "SECURE LOG"; description = "Click the checkmark to record this set."; break;
      case TutorialStep.startRestTimer: title = "IGNITE RECOVERY"; description = "Press Start to begin the rest countdown."; break;
      case TutorialStep.finishRestTimer: title = "RECOVERY COMPLETE"; description = "Finish the timer and move to next set."; break;
      case TutorialStep.exerciseGraph: title = "PERFORMANCE CHART"; description = "Analyze your strength trends."; break;
      case TutorialStep.skipRestTimer: title = "BYPASS REST"; description = "Skip the rest timer to proceed faster."; break;
      case TutorialStep.swipeToCoach: title = "CONSULTING COACH"; description = "Transitioning to AI advisory mode..."; break;
      case TutorialStep.coachWait: title = "NEURAL ANALYSIS"; description = "The AI Coach is optimizing your protocol..."; break;
      case TutorialStep.swipeToSocial: title = "ENTERING HUB"; description = "Sychronizing with the social network..."; break;
      case TutorialStep.squadItem: title = "THE SQUAD"; description = "Select the Hypertrophy Squad to view activity."; break;
      case TutorialStep.squadDetailsIcon: title = "SQUAD PORTAL"; description = "Tap for shared knowledge and tools."; break;
      case TutorialStep.workoutPlanButton: title = "COLLECTIVE PLAN"; description = "Access shared training protocols."; break;
      case TutorialStep.swipeToFinish: title = "PROTOCOL COMPLETE"; description = "Returning to dashboard. Training initiated."; break;
      case TutorialStep.completed: title = "YOU ARE READY"; description = "Proceed to maximum performance."; break;
      default: break;
    }

    final screenHeight = MediaQuery.of(context).size.height;
    double? top;
    double? bottom;

    if (targetRect != null) {
      if (targetRect.center.dy < screenHeight * 0.45) {
        top = targetRect.bottom + 65;
      } else {
        bottom = screenHeight - targetRect.top + 65;
      }
    } else {
      top = screenHeight / 2 - 100;
    }

    return Positioned(
      top: top,
      bottom: bottom,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 40)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 2)),
              const SizedBox(height: 12),
              Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5)),
              if (!isInteractive) ...[
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () => _service.finish(), child: const Text("SKIP", style: TextStyle(color: Colors.white24, fontSize: 11))),
                    ElevatedButton(onPressed: () => _service.next(), style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1), foregroundColor: Colors.white), child: const Text("NEXT")),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _triggerSwipeToWorkout() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_service.currentStep == TutorialStep.swipeToWorkout) {
         try {
           final pc = context.read<PageController>();
           pc.animateToPage(5, duration: 1200.ms, curve: Curves.easeInOutCubic).then((_) => _service.finish());
         } catch (e) { _service.finish(); }
      }
    });
  }
}
