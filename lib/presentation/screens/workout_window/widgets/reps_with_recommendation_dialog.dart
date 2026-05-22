import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'dart:async';
import 'value_input_dialog.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../locator.dart';
import '../../../../data/repositories/workout_repository.dart';
import '../../../../data/repositories/fatigue_repository.dart';
import '../../../../logic/calculators/fatigue_calculator.dart';

class RepsWithRecommendationDialog extends StatefulWidget {
  final double initialValue;
  final String unit;
  final double increment;
  final int exerciseId;
  final double currentWeight;
  final String? side;
  final Function(double)? onIncrementChanged;

  const RepsWithRecommendationDialog({
    super.key,
    required this.initialValue,
    required this.unit,
    required this.increment,
    required this.exerciseId,
    required this.currentWeight,
    this.side,
    this.onIncrementChanged,
  });

  @override
  State<RepsWithRecommendationDialog> createState() =>
      _RepsWithRecommendationDialogState();
}

class _RepsWithRecommendationDialogState
    extends State<RepsWithRecommendationDialog> {
  late double _currentReps;
  final _repository = locator<WorkoutRepository>();
  late final _fatigueRepository = FatigueRepository(locator());

  bool _isLoading = true;
  double _strengthIndex = 1.0;
  double _allTimeBest1RM = 0;
  double _monthlyBest1RM = 0;
  double _currentFatigue = 0.0; // Current muscle fatigue %
  String? _primaryMuscleGroup;
  Timer? _fatigueUpdateTimer;

  bool _showAllTimePR = false; // Toggle for Row 1
  bool _showRIR = false; // Toggle for Row 2

  @override
  void initState() {
    super.initState();
    _currentReps = widget.initialValue;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Get exercise details
      final cubit = context.read<WorkoutCubit>();
      final exerciseLog = cubit.state.workoutDay?.exercises.firstWhereOrNull(
        (e) => e.exercise.value?.id == widget.exerciseId,
      );
      if (exerciseLog != null) {
        await exerciseLog.exercise.load();
      }
      final exercise = exerciseLog?.exercise.value;

      // Get exercise history
      final history = await _repository.getExerciseHistory(
        widget.exerciseId,
        DateTime(2020),
      );
      final allSets = history.values.expand((sets) => sets).toList();

      // Calculate Strength Index
      final strengthIndex = AnalyticsService.calculateStrengthIndex(allSets);

      // All time best 1RM
      final allTimeBest = AnalyticsService.getBest1RM(
        allSets,
        strengthIndex: strengthIndex,
      );

      // Monthly best 1RM (last 30 days)
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final recentSets = history.entries
          .where((entry) => entry.key.isAfter(thirtyDaysAgo))
          .expand((entry) => entry.value)
          .where((s) => s.isCompleted)
          .toList();

      final monthlyBest = AnalyticsService.getBest1RM(
        recentSets,
        strengthIndex: strengthIndex,
      );

      // Get current fatigue
      double currentFatigue = 0.0;
      if (exercise != null) {
        // Fetch fatigue specifically for TODAY'S session
        currentFatigue = await _fatigueRepository.getCurrentFatigue(
          workoutDate: cubit.state.selectedDate,
          muscleGroup: exercise.muscleGroup.name,
          subGroup: exercise.subGroup,
          side: widget.side,
        );
      }

      if (mounted) {
        setState(() {
          _strengthIndex = strengthIndex;
          _allTimeBest1RM = allTimeBest;
          _monthlyBest1RM = monthlyBest;
          _currentFatigue = currentFatigue;
          _primaryMuscleGroup =
              exercise?.subGroup ?? exercise?.muscleGroup.name;
          _isLoading = false;
        });

        // Start real-time fatigue updates
        _startFatigueUpdateTimer();
      }
    } catch (e) {
      debugPrint("Error loading reps recommendation data: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _strengthIndex = 1.0;
          _allTimeBest1RM = 0;
          _monthlyBest1RM = 0;
          _currentFatigue = 0.0;
        });
      }
    }
  }

  void _startFatigueUpdateTimer() {
    // Update fatigue every 5 seconds to show decay in real-time
    _fatigueUpdateTimer?.cancel();
    _fatigueUpdateTimer = Timer.periodic(const Duration(seconds: 5), (
      timer,
    ) async {
      if (!mounted) {
        timer.cancel();
        return;
      }

      try {
        final cubit = context.read<WorkoutCubit>();
        final exerciseLog = cubit.state.workoutDay?.exercises.firstWhereOrNull(
          (e) => e.exercise.value?.id == widget.exerciseId,
        );
        final exercise = exerciseLog?.exercise.value;

        if (exercise != null) {
          final currentFatigue = await _fatigueRepository.getCurrentFatigue(
            workoutDate: cubit.state.selectedDate,
            muscleGroup: exercise.muscleGroup.name,
            subGroup: exercise.subGroup,
            side: widget.side,
          );

          if (mounted) {
            setState(() {
              _currentFatigue = currentFatigue;
              _primaryMuscleGroup =
                  exercise.subGroup ?? exercise.muscleGroup.name;
            });
          }
        }
      } catch (e) {
        // Silently fail - fatigue update is non-critical
      }
    });
  }

  @override
  void dispose() {
    _fatigueUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black54),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Upper Window: Recommendations
                  _buildRecommendationWindow(),
                  const SizedBox(height: 12),
                  // Lower Window: Manual Input
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    width: 400,
                    child: ValueInputDialog(
                      title: 'Reps',
                      initialValue: _currentReps,
                      unit: widget.unit,
                      defaultIncrement: widget.increment,
                      onIncrementChanged: widget.onIncrementChanged,
                      showDelete: false,
                      isEmbedded: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationWindow() {
    if (_isLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: _windowDecoration(),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent),
        ),
      );
    }

    // Row 1 Logic: PR Target
    final target1RM = _showAllTimePR ? _allTimeBest1RM : _monthlyBest1RM;
    // Calculate reps needed to beat the PR (target + 0.1kg)
    final neededReps = target1RM > 0
        ? AnalyticsService.calculateRepsForTarget(
            widget.currentWeight,
            target1RM + 0.1,
            strengthIndex: _strengthIndex,
          )
        : 0;
    final prLabel = _showAllTimePR ? "ALL-TIME PR" : "MONTHLY PR";
    final prIcon = _showAllTimePR ? Icons.emoji_events : Icons.calendar_today;
    final prColor = _showAllTimePR ? Colors.amber : Colors.orangeAccent;

    // Row 2 Logic: Fatigue Adjusted / 2 RIR
    final performanceDrop = FatigueCalculator.calculatePerformanceDrop(
      _currentFatigue,
    );

    final baselineReps =
        (_monthlyBest1RM > 0 ? _monthlyBest1RM : _allTimeBest1RM) > 0
        ? AnalyticsService.calculateRepsForTarget(
            widget.currentWeight,
            (_monthlyBest1RM > 0 ? _monthlyBest1RM : _allTimeBest1RM),
            strengthIndex: _strengthIndex,
          )
        : 0;

    final fatigueAdjustedReps = FatigueCalculator.predictRepsWithFatigue(
      baselineReps,
      performanceDrop,
    );

    final displayReps = _showRIR
        ? (fatigueAdjustedReps - 2).clamp(0, 100)
        : fatigueAdjustedReps;

    final adjLabel = _showRIR ? "2 REPS IN RESERVE" : "FATIGUE ADJUSTED";
    final adjIcon = _showRIR ? Icons.bolt : Icons.whatshot;
    final adjColor = _showRIR ? Colors.lightBlueAccent : Colors.redAccent;

    if (widget.currentWeight <= 0) {
      return Container(
        width: 400,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: _windowDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.monitor_weight_outlined,
              color: Colors.white.withOpacity(0.3),
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              "PLEASE SELECT YOUR WEIGHT FIRST",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "We need a weight to accurately calculate your recommended reps.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: _windowDecoration(),
      child: Column(
        children: [
          _buildRow(
            icon: prIcon,
            label: prLabel,
            reps: neededReps,
            color: prColor,
            onTap: () => setState(() => _showAllTimePR = !_showAllTimePR),
          ),
          const Divider(color: Colors.white10, height: 24),
          _buildRow(
            icon: adjIcon,
            label: adjLabel,
            reps: displayReps,
            color: adjColor,
            onTap: () => setState(() => _showRIR = !_showRIR),
          ),
          const Divider(color: Colors.white10, height: 24),
          // Row 3: Current Fatigue %
          _buildFatigueRow(),
        ],
      ),
    );
  }

  Widget _buildFatigueRow() {
    // Determine fatigue level color
    Color fatigueColor;
    String fatigueLevel;
    if (_currentFatigue <= 20) {
      fatigueColor = Colors.green;
      fatigueLevel = "Fresh";
    } else if (_currentFatigue <= 40) {
      fatigueColor = Colors.yellow;
      fatigueLevel = "Moderate";
    } else if (_currentFatigue <= 60) {
      fatigueColor = Colors.orange;
      fatigueLevel = "Significant";
    } else {
      fatigueColor = Colors.red;
      fatigueLevel = "High";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: fatigueColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.analytics_outlined,
              color: fatigueColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CURRENT FATIGUE",
                  style: TextStyle(
                    color: fatigueColor.withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  _primaryMuscleGroup?.toUpperCase() ?? "CALCULATING",
                  style: const TextStyle(color: Colors.white38, fontSize: 8),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: fatigueColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  "${_currentFatigue.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: fatigueColor,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  fatigueLevel,
                  style: TextStyle(
                    color: fatigueColor.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required String label,
    required int reps,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color.withOpacity(0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Text(
                    "CALCULATED",
                    style: TextStyle(color: Colors.white38, fontSize: 8),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    "$reps",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "rps",
                    style: TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _windowDecoration() {
    return BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
