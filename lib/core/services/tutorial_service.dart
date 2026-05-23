import 'package:flutter/material.dart';
import 'dart:async';

enum TutorialStep {
  welcome,
  rewardMetrics,
  measurements,
  gainsAnalytics,
  gainsBox,
  weightBox,
  bodyFatBox,
  expandMetrics,
  gripBox,
  swipeToWorkout,
  startWorkout,
  firstExercise,
  addExerciseToDay,
  restTimerTag,
  increaseRestTime,
  saveRestTime,
  tutTag,
  prepTimeTag,
  savePrepTime,
  exerciseOptions,
  rirOption,
  typeRir,
  saveRir,
  addSet,
  logSet,
  startRestTimer,
  finishRestTimer,
  exerciseGraph,
  skipRestTimer,
  swipeToCoach,
  coachWait,
  swipeToSocial,
  squadItem,
  squadDetailsIcon,
  workoutPlanButton,
  swipeToFinish,
  completed,
}

class TutorialService {
  static final TutorialService _instance = TutorialService._internal();
  factory TutorialService() => _instance;
  TutorialService._internal();

  // BehaviorSubject-style: replays current value to new subscribers
  final _stepController = StreamController<TutorialStep?>.broadcast();
  TutorialStep? _currentStep;

  TutorialStep? get currentStep => _currentStep;

  /// Stream that always emits the current step to new subscribers (BehaviorSubject pattern)
  Stream<TutorialStep?> get stepStream {
    return Stream<TutorialStep?>.multi((controller) {
      // Immediately emit current value to this new subscriber
      controller.add(_currentStep);
      // Then forward all future events
      final sub = _stepController.stream.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
      controller.onCancel = sub.cancel;
    });
  }

  final Map<TutorialStep, GlobalKey> _registeredKeys = {};

  void registerKey(TutorialStep step, GlobalKey key) {
    _registeredKeys[step] = key;
  }

  GlobalKey? getKeyForStep(TutorialStep step) {
    return _registeredKeys[step];
  }

  void start() {
    _currentStep = TutorialStep.welcome;
    _stepController.add(_currentStep);
    debugPrint('[TUTORIAL] Started — step: ${_currentStep?.name}');
  }

  void next() {
    if (_currentStep == null) return;

    final nextIndex = _currentStep!.index + 1;
    if (nextIndex < TutorialStep.values.length) {
      _currentStep = TutorialStep.values[nextIndex];
      _stepController.add(_currentStep);
      debugPrint('[TUTORIAL] Next step: ${_currentStep?.name}');
    } else {
      finish();
    }
  }

  void finish() {
    _currentStep = null;
    _stepController.add(null);
    debugPrint('[TUTORIAL] Finished.');
  }

  bool get isActive => _currentStep != null;
}
