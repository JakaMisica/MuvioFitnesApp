import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'dart:async';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../logic/cubit/social/social_cubit.dart';
import 'dart:convert';
import '../../../../data/models/workout_day.dart';
import '../../../../data/models/enums.dart';
import '../../../../data/repositories/workout_repository.dart';
import 'weight_with_plate_calculator_dialog.dart';
import 'reps_with_recommendation_dialog.dart';
import 'save_workout_template_dialog.dart';
import '../../../../locator.dart';
import 'add_exercise_sheet.dart';
import 'copy_workout_picker.dart';
import 'exercise_analytics_dialog.dart';
import 'exercise_management_dialog.dart';
import 'value_input_dialog.dart';
import 'set_techniques_dialog.dart';
import 'single_technique_edit_dialog.dart';
import 'rest_timer_inline.dart';
import 'tut_timer_inline.dart';
import 'saved_workouts_sheet.dart';
import 'auto_workout_dialog.dart';
import '../workout_window_screen.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../widgets/custom_reorderable_drag_listener.dart';

// Helper functions for technique badges
Widget _buildTechniqueBadge(
  BuildContext context,
  String label,
  Color color,
  WorkoutSet set,
  VoidCallback onTap,
  IconData icon,
) {
  String displayValue;
  if (label.contains(':')) {
    displayValue = label.split(':')[1];
  } else if (label.endsWith('s') && label.length > 1) {
    displayValue = label.substring(0, label.length - 1);
  } else {
    displayValue = label;
  }

  // Enforce Max 3 characters
  if (displayValue.length > 3) {
    displayValue = displayValue.substring(0, 3);
  }

  // Scale font size based on length to fit fixed box
  double fontSize = 12;
  if (displayValue.length == 2) {
    fontSize = 10;
  } else if (displayValue.length == 3) {
    fontSize = 8.5;
  }

  // For single non-numeric letters, make them uppercase
  if (displayValue.length == 1 && !RegExp(r'^[0-9]+$').hasMatch(displayValue)) {
    displayValue = displayValue.toUpperCase();
  }

  return _buildCutEdgeBox(
    context: context,
    topChild: Text(
      displayValue,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        color: color,
        height: 1.0,
      ),
    ),
    bottomChild: Icon(icon, size: 12, color: color),
    color: color,
    onTap: onTap,
  );
}

Widget _buildCutEdgeBox({
  required BuildContext context,
  required Widget topChild,
  required Widget bottomChild,
  required Color color,
  double width = 42,
  double height = 38,
  VoidCallback? onTap,
  bool isGrayLabel = false,
}) {
  final borderColor = isGrayLabel
      ? Colors.grey.withOpacity(0.4)
      : color.withOpacity(0.6);
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Subtle background tint
          Container(
            width: width,
            height: height - 8,
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Custom Painted Border with Gap
          Positioned.fill(
            bottom: 8,
            child: CustomPaint(
              painter: _CutEdgePainter(
                color: borderColor,
                gapWidth: 20, // Adjust based on content if needed
                borderRadius: 10,
              ),
            ),
          ),
          // Content
          Positioned.fill(
            bottom: 8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: topChild,
              ),
            ),
          ),
          // Bottom Element (now with transparent background)
          Positioned(bottom: 0, child: bottomChild),
        ],
      ),
    ),
  );
}

class _CutEdgePainter extends CustomPainter {
  final Color color;
  final double gapWidth;
  final double borderRadius;

  _CutEdgePainter({
    required this.color,
    required this.gapWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();

    // Calculate gap points at the bottom center
    final centerX = size.width / 2;
    final gapLeft = centerX - (gapWidth / 2);
    final gapRight = centerX + (gapWidth / 2);

    // Draw the rounded rect but skip the gap at the bottom
    path.moveTo(gapRight, size.height);
    path.lineTo(size.width - borderRadius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(size.width, borderRadius);
    path.arcToPoint(
      Offset(size.width - borderRadius, 0),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(borderRadius, 0);
    path.arcToPoint(
      Offset(0, borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(0, size.height - borderRadius);
    path.arcToPoint(
      Offset(borderRadius, size.height),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(gapLeft, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

bool _hasAnyTechniques(WorkoutSet set) {
  return set.rir != null ||
      set.isFailure ||
      set.spotReps != null ||
      set.myoReps != null ||
      set.partialReps != null ||
      set.isDropSet ||
      set.isWarmUp ||
      set.eccentricSeconds != null ||
      set.concentricSeconds != null ||
      set.isometricSeconds != null;
}

class VerticalDayView extends StatefulWidget {
  const VerticalDayView({super.key});

  @override
  State<VerticalDayView> createState() => _VerticalDayViewState();
}

class _VerticalDayViewState extends State<VerticalDayView> {
  // Use a large index to allow scrolling back in time
  static const int _initialPage = 10000;
  late PageController _pageController;
  late DateTime _anchorDate; // The date representing index 10000

  @override
  void initState() {
    super.initState();
    _anchorDate = DateTime.now();

    // Initialize controller based on current state's difference from anchor
    final initialState = context.read<WorkoutCubit>().state;
    final diffDays = _daysBetween(_anchorDate, initialState.selectedDate);
    _pageController = PageController(initialPage: _initialPage + diffDays);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _daysBetween(DateTime from, DateTime to) {
    return DateUtils.dateOnly(to).difference(DateUtils.dateOnly(from)).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutCubit, WorkoutState>(
      listenWhen: (previous, current) =>
          !DateUtils.isSameDay(previous.selectedDate, current.selectedDate),
      listener: (context, state) {
        // If date changed externally (e.g. calendar/today button), scroll to it
        final diff = _daysBetween(_anchorDate, state.selectedDate);
        final targetPage = _initialPage + diff;

        if (_pageController.hasClients &&
            _pageController.page?.round() != targetPage) {
          _pageController.jumpToPage(targetPage);
        }
      },
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        onPageChanged: (index) {
          final diff = index - _initialPage;
          final newDate = _anchorDate.add(Duration(days: diff));
          context.read<WorkoutCubit>().selectDate(newDate);
        },
        itemBuilder: (context, index) {
          final diff = index - _initialPage;
          final date = _anchorDate.add(Duration(days: diff));

          return _DayContent(date: date);
        },
      ),
    );
  }
}

class _DayContent extends StatefulWidget {
  final DateTime date;

  const _DayContent({required this.date});

  @override
  State<_DayContent> createState() => _DayContentState();
}

class _DayContentState extends State<_DayContent> {
  late Stream<List<LogViewModel>> _stream;
  int? _draggingIndex;
  List<LogViewModel>? _localExercises;
  late ScrollController _scrollController;
  final ValueNotifier<bool> _isPreDragging = ValueNotifier<bool>(false);
  Timer? _collapseTimer;
  final Map<int, GlobalKey> _exerciseKeys = {};
  bool _hasAutoScrolled = false;

  @override
  void initState() {
    super.initState();
    _registerKeys();
    _scrollController = ScrollController();
    _stream = locator<WorkoutRepository>().watchWorkoutForDate(widget.date);
  }

  @override
  void dispose() {
    _collapseTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DayContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _localExercises = null;
      _hasAutoScrolled = false;
      _stream = locator<WorkoutRepository>().watchWorkoutForDate(widget.date);
    }
  }

  // Scroll to the first exercise that has uncompleted sets (or last exercise if all done)
  void _autoScrollToActiveExercise(List<LogViewModel> exercises) {
    // Disabled as per user request to prevent unwanted auto-scrolling
    return;
    /*
    if (!_scrollController.hasClients) return;
    // Find first exercise with any uncompleted sets
    int targetIndex = exercises.indexWhere(
      (vm) => vm.sets.any((s) => !s.isCompleted),
    );
    // Fallback: go to end if all done
    if (targetIndex == -1) targetIndex = exercises.length - 1;
    if (targetIndex < 0) return;

    // Approximate card height: ~200px per card + 24px margin
    const estimatedCardHeight = 224.0;
    final targetOffset = (targetIndex * estimatedCardHeight)
        .clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
    */
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutCubit, WorkoutState>(
      listener: (context, state) {
        // Disabled auto-scroll to latest expanded exercise as per user request
        /*
        if (state.lastExpandedLogId != null) {
          _scrollToExercise(state.lastExpandedLogId!);
        }
        */
      },
      child: StreamBuilder<List<LogViewModel>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        // Wait for data if we don't have local data yet
        if (!snapshot.hasData && _localExercises == null) {
          return _buildEmptyState(context);
        }

        final remoteExercises = snapshot.data ?? [];

        // Update local exercises if structurally different or first time
        if (_localExercises == null ||
            _localExercises!.length != remoteExercises.length ||
            !_areIdsMatching(_localExercises!, remoteExercises)) {
          _localExercises = List.from(remoteExercises);
        } else {
          // Sync content (sets, tags, etc.) while keeping the current local order
          _localExercises = _localExercises!.map((local) {
            return remoteExercises.firstWhere(
              (remote) => remote.id == local.id,
              orElse: () => local,
            );
          }).toList();
        }

        if (_localExercises!.isEmpty) {
          return _buildEmptyState(context);
        }

        // Auto-scroll to the first incomplete exercise on initial load
        if (!_hasAutoScrolled) {
          _hasAutoScrolled = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_localExercises!.isNotEmpty) {
              _autoScrollToActiveExercise(_localExercises!);
            }
          });
        }

        return ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(
              Colors.cyanAccent.withOpacity(0.55),
            ),
            trackColor: WidgetStateProperty.all(
              Colors.white.withOpacity(0.04),
            ),
            trackBorderColor: WidgetStateProperty.all(Colors.transparent),
            thickness: WidgetStateProperty.all(5),
            radius: const Radius.circular(10),
            crossAxisMargin: 4,
            mainAxisMargin: 80.0,
            thumbVisibility: WidgetStateProperty.all(true),
            trackVisibility: WidgetStateProperty.all(true),
          ),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            child: CustomScrollView(
              controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 8),
              sliver: SliverReorderableList(
                itemCount: _localExercises!.length,
                onReorderStart: (index) {
                  setState(() {
                    _draggingIndex = index;
                    // Collapse everything immediately when the drag starts
                    context.read<WorkoutCubit>().collapseAllExercises();
                  });
                },
                onReorderEnd: (index) {
                  setState(() {
                    _draggingIndex = null;
                  });
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _localExercises!.removeAt(oldIndex);
                    _localExercises!.insert(newIndex, item);
                    
                    // After the move, scroll to its new position so the user doesn't lose track
                    // Simple scroll estimate for collapsed items: ~72px per item (60 height + 12 margin)
                    final targetOffset = newIndex * 72.0;
                    _scrollController.animateTo(
                      targetOffset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                  // Persist to DB
                  context.read<WorkoutCubit>().reorderExercises(
                    _localExercises!.map((e) => e.id).toList(),
                  );
                },
                proxyDecorator: (child, index, animation) {
                  final cubit = context.read<WorkoutCubit>();
                  final vm = _localExercises![index];
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) => BlocProvider.value(
                      value: cubit,
                      child: Material(
                        elevation: 6,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 60),
                          child: Opacity(
                            opacity: 0.8,
                            child: _buildExerciseCard(
                              context,
                              vm,
                              index: index,
                              dragCollapsed: true,
                              isProxy: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  final vm = _localExercises![index];
                  return ValueListenableBuilder<bool>(
                    key: ValueKey(vm.id),
                    valueListenable: _isPreDragging,
                    builder: (context, isPreDragging, _) {
                      return _buildExerciseCard(
                        context,
                        vm,
                        index: index,
                        dragCollapsed: _draggingIndex != null || isPreDragging,
                      );
                    },
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: _draggingIndex != null ? 1000 : 120, // Huge padding during drag to prevent viewport size issues
                  top: 8,
                ),
                child: Column(
                  children: [
                    if (_localExercises != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          _calculateTotalWorkoutTime(_localExercises!),
                          style: TextStyle(
                            color: Colors.cyanAccent.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    _buildAddAnotherExerciseButton(context),
                    const SizedBox(height: 12),
                    _buildBottomActions(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
),
);
  }

  String _calculateTotalExerciseTime(List<WorkoutSet> sets) {
    if (sets.isEmpty) return "";
    final completedSets = sets.where((s) => s.timeCompleted != null).toList();
    if (completedSets.isEmpty) return "";

    // Sort by time completed
    completedSets.sort((a, b) => a.timeCompleted!.compareTo(b.timeCompleted!));

    // Assume the exercise started (prep + TUT) before the first completion
    final firstSet = completedSets.first;
    final lastSet = completedSets.last;

    // Start time = firstSet completion - TUT - ~10s prep
    final startTime = firstSet.timeCompleted!.subtract(
      Duration(seconds: (firstSet.tutSeconds ?? 20) + 10),
    );
    final endTime = lastSet.timeCompleted!;

    final duration = endTime.difference(startTime);
    final mins = duration.inMinutes;
    final secs = duration.inSeconds % 60;

    return "total time for this exercise ${mins}:${secs.toString().padLeft(2, '0')} min";
  }

  String _calculateTotalWorkoutTime(List<LogViewModel> exercises) {
    if (exercises.isEmpty) return "";
    
    DateTime? firstStart;
    DateTime? lastEnd;

    for (final vm in exercises) {
      final completedSets = vm.sets.where((s) => s.timeCompleted != null).toList();
      if (completedSets.isEmpty) continue;
      
      completedSets.sort((a, b) => a.timeCompleted!.compareTo(b.timeCompleted!));
      
      final firstSet = completedSets.first;
      final lastSet = completedSets.last;
      
      final startTime = firstSet.timeCompleted!.subtract(
        Duration(seconds: (firstSet.tutSeconds ?? 20) + 10),
      );
      final endTime = lastSet.timeCompleted!;
      
      if (firstStart == null || startTime.isBefore(firstStart)) firstStart = startTime;
      if (lastEnd == null || endTime.isAfter(lastEnd)) lastEnd = endTime;
    }

    if (firstStart == null || lastEnd == null) return "";

    final duration = lastEnd.difference(firstStart);
    final hours = duration.inHours;
    final mins = duration.inMinutes % 60;

    if (hours > 0) {
      return "total time of workout $hours:${mins.toString().padLeft(2, '0')} h";
    }
    return "total time of workout $mins min";
  }

  void _registerKeys() {
    final service = TutorialService();
    // These keys are persistent as they are assigned to static or first-instance elements
    service.registerKey(TutorialStep.startWorkout, GlobalKey(debugLabel: 'startWorkout'));
    service.registerKey(TutorialStep.firstExercise, GlobalKey(debugLabel: 'firstExercise'));
    service.registerKey(TutorialStep.addExerciseToDay, GlobalKey(debugLabel: 'addExerciseToDay'));
    service.registerKey(TutorialStep.restTimerTag, GlobalKey(debugLabel: 'restTimerTag'));
    service.registerKey(TutorialStep.tutTag, GlobalKey(debugLabel: 'tutTag'));
    service.registerKey(TutorialStep.prepTimeTag, GlobalKey(debugLabel: 'prepTimeTag'));
    service.registerKey(TutorialStep.exerciseOptions, GlobalKey(debugLabel: 'exerciseOptions'));
    service.registerKey(TutorialStep.addSet, GlobalKey(debugLabel: 'addSet'));
    service.registerKey(TutorialStep.logSet, GlobalKey(debugLabel: 'logSet'));
    service.registerKey(TutorialStep.exerciseGraph, GlobalKey(debugLabel: 'exerciseGraph'));
  }

  bool _areIdsMatching(List<LogViewModel> a, List<LogViewModel> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }

  Widget _applyKeyIfFirstSet(int exerciseIndex, int setIndex, TutorialStep step, Widget child) {
    if (exerciseIndex == 0 && setIndex == 0) {
      return KeyedSubtree(
        key: TutorialService().getKeyForStep(step),
        child: child,
      );
    }
    return child;
  }

  Widget _applyKeyIfFirst(int index, TutorialStep step, Widget child) {
    if (index == 0) {
      return KeyedSubtree(
        key: TutorialService().getKeyForStep(step),
        child: child,
      );
    }
    return child;
  }

  Widget _buildExerciseCard(
    BuildContext context,
    LogViewModel vm, {
    required int index,
    bool dragCollapsed = false,
    bool isProxy = false,
  }) {
    final workoutState = context.watch<WorkoutCubit>().state;
    // An exercise is expanded if its ID matches the expandedExerciseId in state,
    // OR if no ID is stored (initial/fallback). 
    // BUT the user says: "all of the other ones will colapse".
    // AND "when we add new exercise it will be in default state" (expanded).
    // An exercise is expanded if its ID is in the expandedExerciseIds set
    final isActuallyExpanded = workoutState.expandedExerciseIds.contains(vm.id);

    // Completely simplified view for collapsed state
    if (!isActuallyExpanded || dragCollapsed) {
      return GestureDetector(
        onTap: () =>
            context.read<WorkoutCubit>().toggleExerciseExpansion(vm.id),
        child: Container(
          height: (dragCollapsed || isProxy) ? 60 : null, // FORCE HEIGHT to fix hitbox
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: (dragCollapsed || isProxy) ? 0 : 6,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(isProxy ? 0.9 : 0.5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: (dragCollapsed ? Colors.purpleAccent : Colors.cyanAccent)
                  .withOpacity(0.25),
              width: 1,
            ),
          ),
          child: _applyKeyIfFirst(index, TutorialStep.firstExercise, Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                FastReorderableDelayedDragStartListener(
                  index: index,
                  dragDelay: const Duration(milliseconds: 250),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.drag_indicator,
                      color: Colors.white30,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    vm.name,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                IconButton(
                  key: index == 0 ? TutorialService().getKeyForStep(TutorialStep.exerciseGraph) : null,
                  icon: const Icon(Icons.show_chart,
                      color: Colors.white30, size: 18),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => ExerciseAnalyticsDialog(
                        exerciseId: vm.originalLog.exercise.value!.id,
                        exerciseName: vm.name,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white30, size: 16),
                  onPressed: () {
                    final cubit = context.read<WorkoutCubit>();
                    showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: ExerciseManagementDialog(
                          exercise: vm.originalLog.exercise.value!,
                          onAfterDelete: () {
                            cubit.deleteLog(vm.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: Colors.white30, size: 18),
                  onPressed: () =>
                      context.read<WorkoutCubit>().deleteLog(vm.id),
                ),
              ],
            ),
          )),
        ),
      );
    }

    return Container(
      key: _exerciseKeys[vm.id] ??= GlobalKey(),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.03),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Foggy Highlight - Top Right
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.12),
                      Theme.of(context).primaryColor.withOpacity(0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            // Foggy Highlight - Bottom Left
            Positioned(
              bottom: -100,
              left: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.08),
                      Theme.of(context).primaryColor.withOpacity(0.02),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),
            // Central Ambient Fog
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.2, 0.0),
                    radius: 1.8,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => context.read<WorkoutCubit>().toggleExerciseExpansion(vm.id),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            vm.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.show_chart, color: Colors.white70, size: 19),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ExerciseAnalyticsDialog(
                                exerciseId: vm.originalLog.exercise.value!.id,
                                exerciseName: vm.name,
                              ),
                            );
                          },
                          tooltip: 'View Analytics',
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white70, size: 16),
                          onPressed: () {
                            final cubit = context.read<WorkoutCubit>();
                            showDialog(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: cubit,
                                child: ExerciseManagementDialog(
                                  exercise: vm.originalLog.exercise.value!,
                                  onAfterDelete: () {
                                    cubit.deleteLog(vm.id);
                                  },
                                ),
                              ),
                            );
                          },
                          tooltip: 'Edit Exercise Template',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.white70, size: 19),
                          onPressed: () {
                            context.read<WorkoutCubit>().deleteLog(vm.id);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (vm.sets.isEmpty)
                    Column(
                      children: [
                        Text(
                          "No sets logged yet.",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            context.read<WorkoutCubit>().addSet(vm.id, 20.0, 10);
                          },
                          child: const Text("Add Set"),
                        ),
                      ],
                    ),
                  if (vm.sets.isNotEmpty) ...[
                    ...vm.sets.asMap().entries.map((entry) {
                      final i = entry.key;
                      final s = entry.value;

                      return BlocBuilder<WorkoutCubit, WorkoutState>(
                        builder: (context, state) {
                          final isHighlighted = state.restTimer != null &&
                              state.restTimer!.exerciseLogId == vm.id &&
                              state.restTimer!.setIndex == i;

                          final isTutActive = state.tutTimer != null &&
                              state.tutTimer!.exerciseLogId == vm.id &&
                              state.tutTimer!.setIndex == i;

                          return Column(
                            children: [
                              if (isHighlighted) const RestTimerInline(),
                              if (isTutActive) const TutTimerInline(),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: isHighlighted
                                      ? Theme.of(context).primaryColor.withOpacity(0.08)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: isHighlighted
                                      ? Border.all(
                                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                                          width: 1,
                                        )
                                      : null,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 1. Set Number Box
                                        _buildCutEdgeBox(
                                          context: context,
                                          width: 30,
                                          height: 38,
                                          color: s.isPr
                                              ? Colors.amber
                                              : (s.isTodayPr ? Colors.orangeAccent : Colors.white),
                                          isGrayLabel: !s.isPr && !s.isTodayPr,
                                          topChild: s.isPr
                                              ? const Icon(Icons.emoji_events, size: 16, color: Colors.amber)
                                              : (s.isTodayPr
                                                  ? const Icon(Icons.military_tech, size: 16, color: Colors.orangeAccent)
                                                  : Text("${i + 1}", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12))),
                                          bottomChild: Text(
                                            s.isPr ? "PR" : (s.isTodayPr ? "BEST" : "SET"),
                                            style: TextStyle(
                                              fontSize: 6.5,
                                              color: s.isPr
                                                  ? Colors.amber
                                                  : (s.isTodayPr
                                                      ? Colors.orangeAccent
                                                      : Theme.of(context).primaryColor.withOpacity(0.5)),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        // 2. Flexible Tags
                                        Flexible(
                                          flex: 1,
                                          child: _buildBalancedTags([
                                            if (s.isRestTimerEnabled)
                                              _applyKeyIfFirstSet(index, i, TutorialStep.restTimerTag, _buildTechniqueBadge(
                                                context,
                                                s.restDuration.toString(),
                                                Colors.greenAccent,
                                                s,
                                                () async {
                                                  final result = await showDialog<double>(
                                                    context: context,
                                                    builder: (_) => ValueInputDialog(
                                                      title: 'Rest Duration',
                                                      initialValue: (s.restDuration ?? 90).toDouble(),
                                                      unit: 's',
                                                      defaultIncrement: 15,
                                                      showDelete: true,
                                                    ),
                                                  );
                                                  if (result != null) {
                                                    final updated = s.copyWith(
                                                      isRestTimerEnabled: result != double.infinity,
                                                      restDuration: result == double.infinity ? null : result.toInt(),
                                                    );
                                                    context.read<WorkoutCubit>().updateSet(vm.id, i, updated);
                                                  }
                                                },
                                                Icons.timer,
                                              )),
                                            if (s.isWarmUp)
                                              _buildTechniqueBadge(
                                                context,
                                                'W',
                                                const Color(0xFFB0B0B0),
                                                s,
                                                () => _showTechniqueEdit(context, vm.id, i, s, 'Warm Up', (set) => set..isWarmUp = false),
                                                Icons.wb_sunny_outlined,
                                              ),
                                            if (s.isDropSet)
                                              _buildTechniqueBadge(
                                                context,
                                                'DS',
                                                Colors.purpleAccent,
                                                s,
                                                () => _showTechniqueEdit(context, vm.id, i, s, 'Drop Set', (set) => set..isDropSet = false),
                                                Icons.arrow_downward,
                                              ),
                                            if (s.isFailure)
                                              _buildTechniqueBadge(
                                                context,
                                                'F',
                                                Colors.redAccent,
                                                s,
                                                () => _showTechniqueEdit(context, vm.id, i, s, 'Failure', (set) => set..isFailure = false),
                                                Icons.dangerous,
                                              ),
                                            if (s.rir != null)
                                              _buildTechniqueBadge(
                                                context,
                                                s.rir.toString(),
                                                Colors.blueGrey,
                                                s,
                                                () => _showNumericEdit(context, vm.id, i, s, 'RIR', s.rir!.toDouble(), (set, val) => set..rir = val == double.infinity ? null : val.toInt()),
                                                Icons.hourglass_empty,
                                              ),
                                            if (s.myoReps != null)
                                              _buildTechniqueBadge(
                                                context,
                                                s.myoReps.toString(),
                                                Colors.deepOrangeAccent,
                                                s,
                                                () => _showNumericEdit(context, vm.id, i, s, 'Myo Reps', s.myoReps!.toDouble(), (set, val) => set..myoReps = val == double.infinity ? null : val.toInt()),
                                                Icons.bolt,
                                              ),
                                            if (s.spotReps != null)
                                              _buildTechniqueBadge(
                                                context,
                                                s.spotReps.toString(),
                                                const Color(0xFFFF6B6B),
                                                s,
                                                () => _showNumericEdit(context, vm.id, i, s, 'Spot Reps', s.spotReps!.toDouble(), (set, val) => set..spotReps = val == double.infinity ? null : val.toInt()),
                                                Icons.people,
                                              ),
                                            if (s.partialReps != null)
                                              _buildTechniqueBadge(
                                                context,
                                                s.partialReps.toString(),
                                                const Color(0xFF6FAAFF),
                                                s,
                                                () => _showNumericEdit(context, vm.id, i, s, 'Partial Reps', s.partialReps!.toDouble(), (set, val) => set..partialReps = val == double.infinity ? null : val.toInt()),
                                                Icons.straighten,
                                              ),
                                            if (vm.isIsolate)
                                              _buildSideBox(
                                                context: context,
                                                side: s.side ?? "R",
                                                onTap: () {
                                                  final updated = s.copyWith(side: s.side == "L" ? "R" : "L");
                                                  context.read<WorkoutCubit>().updateSet(vm.id, i, updated);
                                                },
                                              ),
                                            if (vm.hasCablePosition)
                                              _buildEquipmentBox(
                                                context: context,
                                                label: "Cable",
                                                value: s.cablePosition?.toString() ?? "-",
                                                icon: Icons.settings_input_component,
                                                onTap: () => _showNumericEdit(context, vm.id, i, s, 'Cable Position', (s.cablePosition ?? 1).toDouble(), (set, val) => set..cablePosition = val == double.infinity ? null : val.toInt()),
                                              ),
                                            if (vm.hasBenchPosition)
                                              _buildEquipmentBox(
                                                context: context,
                                                label: "Bench",
                                                value: s.benchPosition?.toString() ?? "-",
                                                icon: Icons.chair,
                                                onTap: () => _showNumericEdit(context, vm.id, i, s, 'Bench Position', (s.benchPosition ?? 1).toDouble(), (set, val) => set..benchPosition = val == double.infinity ? null : val.toInt()),
                                              ),
                                              _applyKeyIfFirstSet(index, i, TutorialStep.tutTag, _buildTechniqueBadge(
                                                context,
                                                s.isTutEnabled
                                                    ? (s.tutSeconds != null
                                                        ? '${s.tutSeconds}s'
                                                        : 'TUT·${s.tutPrepSeconds}s')
                                                    : 'NO TUT',
                                                s.isTutEnabled ? Colors.blueAccent : Colors.grey,
                                                s,
                                                () async {
                                                  if (s.isTutEnabled) {
                                                    // Options: Change Prep Time or Delete
                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) => AlertDialog(
                                                        backgroundColor: const Color(0xFF1a1a1a),
                                                        title: const Text('TUT Settings', style: TextStyle(color: Colors.white)),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            ListTile(
                                                              leading: const Icon(Icons.timer_outlined, color: Colors.blueAccent),
                                                              title: const Text('Prep Time', style: TextStyle(color: Colors.white)),
                                                              key: TutorialService().getKeyForStep(TutorialStep.prepTimeTag),
                                                              subtitle: Text('${s.tutPrepSeconds} seconds', style: const TextStyle(color: Colors.white70)),
                                                              onTap: () async {
                                                                Navigator.pop(ctx);
                                                                final result = await showDialog<double>(
                                                                  context: context,
                                                                  builder: (_) => ValueInputDialog(
                                                                    title: 'Preparation Time',
                                                                    initialValue: s.tutPrepSeconds.toDouble(),
                                                                    unit: 's',
                                                                    defaultIncrement: 1,
                                                                  ),
                                                                );
                                                                if (result != null) {
                                                                  final updated = s.copyWith(tutPrepSeconds: result.toInt());
                                                                  context.read<WorkoutCubit>().updateSet(vm.id, i, updated);
                                                                }
                                                              },
                                                            ),
                                                            ListTile(
                                                              leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                                              title: const Text('Remove TUT Tag', style: TextStyle(color: Colors.white)),
                                                              onTap: () {
                                                                final updated = s.copyWith(isTutEnabled: false);
                                                                context.read<WorkoutCubit>().updateSet(vm.id, i, updated);
                                                                Navigator.pop(ctx);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    // Enable it
                                                    final updated = s.copyWith(isTutEnabled: true);
                                                    context.read<WorkoutCubit>().updateSet(vm.id, i, updated);
                                                  }
                                                },
                                                Icons.av_timer,
                                              )),
                                          ]),
                                        ),
                                        const SizedBox(width: 4),
                                        // 3. Dynamic Tracking Column
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (vm.trackWeightReps) ...[
                                              _buildValueBox(
                                                context, vm.id, i, s, vm.originalLog.exercise.value?.id ?? 0,
                                                'Weight', s.weight ?? 0.0, vm.defaultUnit == WeightUnit.lbs ? 'lbs' : 'kg',
                                                vm.weightIncrement, 40, (val) => val, (set, val) => set..weight = val,
                                                onIncrementUpdate: (newVal) => context.read<WorkoutCubit>().updateExerciseIncrement(logId: vm.id, weightIncrement: newVal),
                                              ),
                                              const SizedBox(height: 4),
                                              _buildValueBox(
                                                context, vm.id, i, s, vm.originalLog.exercise.value?.id ?? 0,
                                                'Reps', (s.reps ?? 0).toDouble(), 'rps',
                                                vm.repsIncrement, 40, (val) => val.toInt(), (set, val) => set..reps = val.toInt(),
                                                onIncrementUpdate: (newVal) => context.read<WorkoutCubit>().updateExerciseIncrement(logId: vm.id, repsIncrement: newVal),
                                              ),
                                            ],
                                            if (vm.trackDistance) ...[
                                              if (vm.trackWeightReps) const SizedBox(height: 4),
                                              _buildValueBox(context, vm.id, i, s, vm.originalLog.exercise.value?.id ?? 0, 'Distance', s.distance ?? 0.0, vm.distanceUnit ?? 'km', 1.0, 40, (val) => val, (set, val) => set..distance = val),
                                            ],
                                            if (vm.trackSpeed) ...[
                                              if (vm.trackWeightReps || vm.trackDistance) const SizedBox(height: 4),
                                              _buildValueBox(context, vm.id, i, s, vm.originalLog.exercise.value?.id ?? 0, 'Speed', s.speed ?? 0.0, vm.speedUnit ?? 'km/h', 0.5, 40, (val) => val, (set, val) => set..speed = val),
                                            ],
                                            if (vm.trackCalories) ...[
                                              if (vm.trackWeightReps || vm.trackDistance || vm.trackSpeed) const SizedBox(height: 4),
                                              _buildValueBox(context, vm.id, i, s, vm.originalLog.exercise.value?.id ?? 0, 'Calories', s.calories ?? 0.0, vm.caloriesUnit ?? 'kcal', 10.0, 40, (val) => val, (set, val) => set..calories = val),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(width: 4),
                                        // 4. Actions
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Builder(
                                                  builder: (btnContext) {
                                                    return _applyKeyIfFirstSet(index, i, TutorialStep.logSet, IconButton(
                                                      icon: Icon(
                                                        s.isCompleted ? Icons.check_circle : (isTutActive ? Icons.play_circle : Icons.circle_outlined),
                                                        size: 20,
                                                        color: s.isCompleted ? const Color(0xFF00E676) : (isTutActive ? Colors.blue : Colors.grey),
                                                      ),
                                                      onPressed: () {
                                                        final wasAlreadyCompleted = s.isCompleted;
                                                        context.read<WorkoutCubit>().toggleSetCompletion(vm.id, i, s);
                                                        if (!wasAlreadyCompleted) {
                                                          final box = btnContext.findRenderObject() as RenderBox;
                                                          celebrationKey.currentState?.popCheckmark(box.localToGlobal(Offset(box.size.width / 2, box.size.height / 2)));
                                                        }
                                                      },
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                                    ));
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            SizedBox(
                                              height: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: IconButton(
                                                  icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                                                  onPressed: () => showDialog(context: context, builder: (_) => TechniqueSelectionDialog(currentSet: s, onSave: (updated) => context.read<WorkoutCubit>().updateSet(vm.id, i, updated), onDelete: () => context.read<WorkoutCubit>().deleteSet(vm.id, i))),
                                                  padding: EdgeInsets.zero,
                                                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    if (s.isDropSet) _buildDropSetSection(context, vm, i, s),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => context.read<WorkoutCubit>().toggleExerciseExpansion(vm.id),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            _calculateTotalExerciseTime(vm.sets),
                            style: const TextStyle(color: Colors.white24, fontSize: 11, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: GestureDetector(
                            onTap: () {}, // Consume tap to prevent accidental collapse
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  final lastSet = vm.sets.isNotEmpty ? vm.sets.last : null;
                                  context.read<WorkoutCubit>().addSet(vm.id, lastSet?.weight ?? 20.0, lastSet?.reps ?? 10);
                                },
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text("Add Set"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  side: const BorderSide(color: Colors.white24),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('EEEE, MMM d').format(widget.date),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.white24),
          ),
          const SizedBox(height: 20),
          const Icon(Icons.fitness_center, size: 120, color: Colors.white12),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            key: TutorialService().getKeyForStep(TutorialStep.startWorkout),
            onPressed: () => _showAddSheet(context),
            icon: const Icon(Icons.add),
            label: const Text("Start Workout"),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _showAutoWorkoutDialog(context),
            icon: const Icon(Icons.auto_awesome),
            label: const Text("Auto Workout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => _showSmartCopy(context),
            icon: const Icon(Icons.copy),
            label: const Text("Smart Copy from Past"),
          ),
          TextButton.icon(
            onPressed: () => _showSavedWorkoutsSheet(context),
            icon: const Icon(Icons.folder_special),
            label: const Text("Add from Saved Workouts"),
          ),
          TextButton.icon(
            onPressed: () => context.read<WorkoutCubit>().toggleRestDay(),
            icon: const Icon(Icons.bed),
            label: BlocBuilder<WorkoutCubit, WorkoutState>(
              builder: (context, state) {
                final isRestDay = state.workoutDay?.isRestDay ?? false;
                return Text(isRestDay ? "Unmark Rest Day" : "Rest Day");
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSavedWorkoutsSheet(BuildContext context) {
    final cubit = context.read<WorkoutCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          BlocProvider.value(value: cubit, child: const SavedWorkoutsSheet()),
    );
  }

  void _showAutoWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AutoWorkoutDialog(),
    );
  }

  void _showSaveAsTemplateDialog(BuildContext context) {
    final cubit = context.read<WorkoutCubit>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: const SaveWorkoutTemplateDialog(),
      ),
    );
  }

  void _showSmartCopy(BuildContext context) async {
    final date = await showDialog<DateTime>(
      context: context,
      builder: (_) => const CopyWorkoutPicker(),
    );

    if (date != null && context.mounted) {
      context.read<WorkoutCubit>().copyWorkoutFromDate(date);
    }
  }

  void _showAddSheet(BuildContext context) {
    // Capture the cubit from the current context
    final cubit = context.read<WorkoutCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const AddExerciseSheet()),
    );
  }

  Widget _buildAddAnotherExerciseButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.03),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          onTap: () => _showAddSheet(context),
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Foggy Highlight - Top Right
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.12),
                        Theme.of(context).primaryColor.withOpacity(0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Foggy Highlight - Bottom Left
              Positioned(
                bottom: -50,
                left: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.08),
                        Theme.of(context).primaryColor.withOpacity(0.02),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Colors.cyanAccent),
                    const SizedBox(width: 12),
                    const Text(
                      "Add Another Exercise",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        _buildSaveWorkoutButton(context),
        _buildShareWorkoutButton(context),
      ],
    );
  }

  Widget _buildShareWorkoutButton(BuildContext context) {
    const color = Colors.cyanAccent;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.03),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => _showSharePicker(context),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.share_outlined,
                  color: color.withOpacity(0.8),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "Share Workout",
                  style: TextStyle(
                    color: color.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSharePicker(BuildContext context) {
    final workoutCubit = context.read<WorkoutCubit>();
    final workout = workoutCubit.state.workoutDay;
    if (workout == null || workout.exercises.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No exercises to share!")));
      return;
    }

    // Serialize workout
    final data = {
      'date': workout.date.toIso8601String(),
      'exercises': workout.exercises.map((log) {
        return {
          'name': log.exercise.value?.name ?? 'Unknown',
          'muscleGroup': log.exercise.value?.muscleGroup.name ?? 'chest',
          'subGroup': log.exercise.value?.subGroup,
          'isIsolate': log.exercise.value?.isIsolate ?? false,
          'hasCablePosition': log.exercise.value?.hasCablePosition ?? false,
          'hasBenchPosition': log.exercise.value?.hasBenchPosition ?? false,
          'sets': log.sets
              .map(
                (s) => {
                  'weight': s.weight,
                  'reps': s.reps,
                  'isCompleted': s.isCompleted,
                  'restDuration': s.restDuration,
                  'cablePosition': s.cablePosition,
                  'benchPosition': s.benchPosition,
                },
              )
              .toList(),
          'notes': log.notes,
        };
      }).toList(),
    };

    final socialCubit = context.read<SocialCubit>();
    final dateStr = DateFormat('EEEE, MMM d').format(workout.date);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SHARE WORKOUT TO',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'FOR: $dateStr',
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...socialCubit.state.conversations.map((conv) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: conv.isGroup ? Colors.purple : Colors.cyan,
                  child: Icon(
                    conv.isGroup ? Icons.groups : Icons.person,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                title: Text(
                  conv.name,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  socialCubit.shareContent(
                    conv.remoteId,
                    "Shared a workout with you.",
                    'workout',
                    jsonEncode(data),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Shared with ${conv.name}")),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveWorkoutButton(BuildContext context) {
    const color = Colors.blueAccent;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.03),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => _showSaveAsTemplateDialog(context),
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Foggy Highlight - Top Right
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.12),
                        color.withOpacity(0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Foggy Highlight - Bottom Left
              Positioned(
                bottom: -40,
                left: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.08),
                        color.withOpacity(0.02),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.save_rounded,
                      color: color.withOpacity(0.8),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Save as Workout",
                      style: TextStyle(
                        color: color.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueBox(
    BuildContext context,
    int logId,
    int setIndex,
    WorkoutSet set,
    int exerciseId, // Added direct ID
    String title,
    double value,
    String label,
    double increment,
    double width,
    dynamic Function(double) onDisplayConvert,
    WorkoutSet Function(WorkoutSet, double) onUpdate, {
    void Function(double)? onIncrementUpdate,
  }) {
    return _buildCutEdgeBox(
      context: context,
      width: width,
      height: 40,
      color: Colors.white,
      isGrayLabel: true,
      onTap: () async {
        if (title.toLowerCase() == 'weight') {
          // Weight with Plate Calculator (Dual Window)
          final cubit = context.read<WorkoutCubit>();
          final result = await Navigator.push<double>(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => BlocProvider.value(
                value: cubit,
                child: WeightWithPlateCalculatorDialog(
                  initialValue: value,
                  unit: label,
                  increment: increment,
                  exerciseId: exerciseId, // Use direct ID
                  onIncrementChanged: onIncrementUpdate,
                ),
              ),
            ),
          );

          if (result != null) {
            final updated = onUpdate(set.copyWith(), result);
            context.read<WorkoutCubit>().updateSet(logId, setIndex, updated);
          }
          return;
        }

        if (title.toLowerCase().contains('rep')) {
          // Reps with Recommendation (Dual Window)
          final cubit = context.read<WorkoutCubit>();
          final result = await Navigator.push<double>(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => BlocProvider.value(
                value: cubit,
                child: RepsWithRecommendationDialog(
                  initialValue: value,
                  unit: label,
                  increment: increment,
                  exerciseId: exerciseId, // Use direct ID
                  currentWeight: set.weight ?? 0,
                  side: set.side, // Passed for isolation
                  onIncrementChanged: onIncrementUpdate,
                ),
              ),
            ),
          );

          if (result != null) {
            final updated = onUpdate(set.copyWith(), result);
            context.read<WorkoutCubit>().updateSet(logId, setIndex, updated);
          }
          return;
        }

        final result = await showDialog<double>(
          context: context,
          builder: (_) => ValueInputDialog(
            title: title,
            initialValue: value,
            unit: label,
            defaultIncrement: increment,
            onIncrementChanged: onIncrementUpdate,
            showDelete: false,
          ),
        );
        if (result != null) {
          final updated = onUpdate(set.copyWith(), result);
          context.read<WorkoutCubit>().updateSet(logId, setIndex, updated);
        }
      },
      topChild: Text(
        (() {
          final val = onDisplayConvert(value).toDouble();
          if (val == 0) return "0";
          // 3 significant digits as requested (e.g. 150, 10.5, 5.25)
          String s = val.toStringAsPrecision(3);
          // Safeguard against scientific notation for very large weights
          if (s.contains('e')) {
            s = val.toInt().toString();
          } else if (s.contains('.')) {
            // Remove trailing zeros and possible decimal point if it's an integer
            s = s.replaceAll(RegExp(r'0*$'), '');
            s = s.replaceAll(RegExp(r'\.$'), '');
          }
          return s;
        })(),
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
      ),
      bottomChild: Text(
        label.toLowerCase() == "weights" ? "" : (label.isEmpty ? "rps" : label),
        style: const TextStyle(
          fontSize: 8,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEquipmentBox({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.cyanAccent,
  }) {
    return _buildCutEdgeBox(
      context: context,
      topChild: Text(
        value,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
      bottomChild: Icon(icon, size: 14, color: color),
      color: color,
      onTap: onTap,
    );
  }

  Widget _buildSideBox({
    required BuildContext context,
    required String side,
    required VoidCallback onTap,
  }) {
    final color = side == "R" ? Colors.blue : Colors.orange;
    return _buildCutEdgeBox(
      context: context,
      topChild: Text(
        side,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
      bottomChild: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateY(side == "L" ? math.pi : 0), // Mirror for Left
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: const Text("💪", style: TextStyle(fontSize: 12)),
        ),
      ),
      color: color,
      onTap: onTap,
    );
  }

  Widget _buildBalancedTags(List<Widget> tags) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Approximate width: each tag is ~42px wide + 4px spacing
        const itemWidth = 46.0;
        final maxInRow = (constraints.maxWidth / itemWidth).floor();

        if (maxInRow <= 0) return const SizedBox.shrink();

        // If they fit in one row, use a single Wrap
        if (tags.length <= maxInRow) {
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            runSpacing: 4,
            children: tags,
          );
        }

        // Determine optimal number of rows
        final int numRows = (tags.length / maxInRow).ceil();

        // Distribute tags as evenly as possible across numRows
        final int countPerRow = tags.length ~/ numRows;
        int extras = tags.length % numRows;

        final List<List<Widget>> rows = [];
        int currentIndex = 0;

        for (int i = 0; i < numRows; i++) {
          int take = countPerRow + (extras > 0 ? 1 : 0);
          if (extras > 0) extras--;

          if (currentIndex < tags.length) {
            final end = (currentIndex + take).clamp(0, tags.length);
            rows.add(tags.sublist(currentIndex, end));
            currentIndex = end;
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: rows.asMap().entries.map((entry) {
            final isLast = entry.key == rows.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 4),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: isLast ? WrapAlignment.center : WrapAlignment.end,
                spacing: 4,
                runSpacing: 4,
                children: entry.value,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _showTechniqueEdit(
    BuildContext context,
    int logId,
    int setIndex,
    WorkoutSet set,
    String techniqueName,
    void Function(WorkoutSet) onToggleOff,
  ) {
    showDialog(
      context: context,
      builder: (_) => SingleTechniqueEditDialog(
        techniqueName: techniqueName,
        isBoolean: true,
        onDelete: () {
          final updated = set.copyWith();
          onToggleOff(updated);
          context.read<WorkoutCubit>().updateSet(logId, setIndex, updated);
        },
      ),
    );
  }

  void _showNumericEdit(
    BuildContext context,
    int logId,
    int setIndex,
    WorkoutSet set,
    String title,
    double initialValue,
    void Function(WorkoutSet, double) onUpdate,
  ) async {
    final result = await showDialog<double>(
      context: context,
      builder: (_) => ValueInputDialog(
        title: title,
        initialValue: initialValue,
        unit: '',
        defaultIncrement: 1,
        showDelete: true,
      ),
    );
    if (result != null) {
      final updated = set.copyWith();
      onUpdate(updated, result);
      context.read<WorkoutCubit>().updateSet(logId, setIndex, updated);
    }
  }

  Widget _buildDropSetSection(
    BuildContext context,
    LogViewModel vm,
    int setIndex,
    WorkoutSet set,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.purpleAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.trending_down,
                color: Colors.purpleAccent,
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                "DROP SETS",
                style: TextStyle(
                  color: Colors.purpleAccent.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...set.dropSetItems.asMap().entries.map((entry) {
            final dropIndex = entry.key;
            final ds = entry.value;

            // Calculate percentage drop from either main set (if D1) or previous drop set
            double baseWeight = 0;
            if (dropIndex == 0) {
              baseWeight = set.weight ?? 0;
            } else {
              baseWeight = set.dropSetItems[dropIndex - 1].weight ?? 0;
            }

            double weightDropPercent = 0;
            if (baseWeight > 0 && ds.weight != null) {
              weightDropPercent = ((baseWeight - ds.weight!) / baseWeight) * 100;
            }

            // Calculate 1RM Drop
            // Epley: weight * (1 + 0.0333 * reps)
            double baseReps = (dropIndex == 0) ? (set.reps?.toDouble() ?? 0) : (set.dropSetItems[dropIndex - 1].reps?.toDouble() ?? 0);
            double base1RM = baseWeight * (1 + 0.0333 * baseReps);
            double current1RM = (ds.weight ?? 0) * (1 + 0.0333 * (ds.reps ?? 0));
            double oneRmDropPercent = 0;
            if (base1RM > 0) {
              oneRmDropPercent = ((base1RM - current1RM) / base1RM) * 100;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                   // Efficiency Column
                  Container(
                    width: 45,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "-${weightDropPercent.toInt()}% KG",
                          style: const TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "-${oneRmDropPercent.toInt()}% 1RM",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.35),
                            fontSize: 7,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Weight Box
                  SizedBox(
                    width: 65,
                    child: _buildDropSetValueBox(
                      context: context,
                      value: ds.weight ?? 0.0,
                      label: vm.defaultUnit == WeightUnit.lbs ? 'lbs' : 'kg',
                      onTap: () => _updateDropSetWeight(
                        context,
                        vm.id,
                        setIndex,
                        dropIndex,
                        ds,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Reps Box
                  SizedBox(
                    width: 55,
                    child: _buildDropSetValueBox(
                      context: context,
                      value: (ds.reps ?? 0).toDouble(),
                      label: 'rps',
                      onTap: () => _updateDropSetReps(
                        context,
                        vm.id,
                        setIndex,
                        dropIndex,
                        ds,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Calculated TUT Tag for Drop Set Item
                  if (ds.tutSeconds != null && set.isCompleted)
                    _buildTechniqueBadge(
                      context,
                      '${ds.tutSeconds}',
                      Colors.blueAccent,
                      set,
                      () {},
                      Icons.av_timer,
                    ),

                  const Spacer(),

                  // Delete Button
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white.withOpacity(0.25),
                    ),
                    onPressed: () => context
                        .read<WorkoutCubit>()
                        .deleteDropSetItem(vm.id, setIndex, dropIndex),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),

          // Add Drop Set Button
          Center(
            child: InkWell(
              onTap: () =>
                  context.read<WorkoutCubit>().addDropSetItem(vm.id, setIndex),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.purpleAccent.withOpacity(0.2),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.purpleAccent, size: 14),
                    SizedBox(width: 6),
                    Text(
                      "Add Drop Set",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropSetValueBox({
    required BuildContext context,
    required double value,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 34, // Shortened for premium feel
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                value % 1 == 0
                    ? value.toInt().toString()
                    : value.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white24,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateDropSetWeight(
    BuildContext context,
    int logId,
    int setIndex,
    int dropIndex,
    DropSetItem ds,
  ) async {
    final result = await showDialog<double>(
      context: context,
      builder: (_) => ValueInputDialog(
        title: 'Drop Set Weight',
        initialValue: ds.weight ?? 0.0,
        unit: ds.weight != null ? '' : '', // Unit label handles it
        defaultIncrement: 2.5,
      ),
    );

    if (result != null) {
      final updated = DropSetItem()
        ..weight = result
        ..reps = ds.reps
        ..isCompleted = ds.isCompleted
        ..tutSeconds = ds.tutSeconds;
      context.read<WorkoutCubit>().updateDropSetItem(
        logId,
        setIndex,
        dropIndex,
        updated,
      );
    }
  }

  Future<void> _updateDropSetReps(
    BuildContext context,
    int logId,
    int setIndex,
    int dropIndex,
    DropSetItem ds,
  ) async {
    final result = await showDialog<double>(
      context: context,
      builder: (_) => ValueInputDialog(
        title: 'Drop Set Reps',
        initialValue: (ds.reps ?? 10).toDouble(),
        unit: 'rps',
        defaultIncrement: 1,
      ),
    );

    if (result != null) {
      final updated = DropSetItem()
        ..weight = ds.weight
        ..reps = result.toInt()
        ..isCompleted = ds.isCompleted
        ..tutSeconds = ds.tutSeconds;
      context.read<WorkoutCubit>().updateDropSetItem(
        logId,
        setIndex,
        dropIndex,
        updated,
      );
    }
  }
}
