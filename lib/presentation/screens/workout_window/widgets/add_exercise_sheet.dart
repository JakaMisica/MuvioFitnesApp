import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../data/models/exercise.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import 'exercise_creator_dialog.dart';
import 'exercise_management_dialog.dart';

import '../../../../data/models/enums.dart';
import '../../../../data/models/muscle_metadata.dart';
import '../../../widgets/flip_image_carousel.dart';

class AddExerciseSheet extends StatefulWidget {
  const AddExerciseSheet({super.key});

  @override
  State<AddExerciseSheet> createState() => _AddExerciseSheetState();
}

class _AddExerciseSheetState extends State<AddExerciseSheet> {
  String _searchQuery = "";
  MuscleGroup? _filterGroup;
  bool? _isCustomFilter; // null = all, true = custom, false = default

  Exercise? _previewExercise;
  List<Exercise>? _cachedExercises;
  List<Exercise>? _recentExercises;
  bool _isLoading = false;
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    setState(() => _isLoading = true);
    final cubit = context.read<WorkoutCubit>();
    final exercises = await cubit.getAllExercises();
    final recent = await cubit.getRecentlyUsedExercises();
    if (mounted) {
      setState(() {
        _cachedExercises = exercises;
        _recentExercises = recent;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Exercise",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton.icon(
                  onPressed: () => _openCreator(context),
                  icon: const Icon(Icons.add),
                  label: const Text("Create New"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: "Search exercises...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[900],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(
                  label: const Text("All"),
                  selected: _isCustomFilter == null,
                  onSelected: (s) => setState(() => _isCustomFilter = null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Default"),
                  selected: _isCustomFilter == false,
                  onSelected: (s) => setState(() => _isCustomFilter = false),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Custom"),
                  selected: _isCustomFilter == true,
                  onSelected: (s) => setState(() => _isCustomFilter = true),
                ),
                const VerticalDivider(),
                ...MuscleGroup.values.map((g) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(g.name.toUpperCase()),
                      selected: _filterGroup == g,
                      onSelected: (s) =>
                          setState(() => _filterGroup = s ? g : null),
                    ),
                  );
                }),
              ],
            ),
          ),
          const Divider(),

          // Preview Area (Hotspot)
          if (_previewExercise != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () async {
                  final cubit = context.read<WorkoutCubit>();
                  await cubit.addExerciseToCurrentDay(_previewExercise!);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _previewExercise!.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${_previewExercise!.muscleGroup.name.toUpperCase()} > ${_previewExercise!.subGroup ?? 'Target'}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Click to add to workout",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlipImageCarousel(
                        imagePath: MuscleMetadata.getMuscleImagePath(
                          _previewExercise!.muscleGroup,
                          _previewExercise!.subGroup,
                        ),
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _cachedExercises == null
                ? const Center(child: Text("Error loading exercises"))
                : () {
                    var exercises = List<Exercise>.from(_cachedExercises!);
                    final isSearching =
                        _searchQuery.isNotEmpty ||
                        _filterGroup != null ||
                        _isCustomFilter != null;

                    // Filter
                    if (_searchQuery.isNotEmpty) {
                      exercises = exercises
                          .where(
                            (e) => e.name.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            ),
                          )
                          .toList();
                    }
                    if (_filterGroup != null) {
                      exercises = exercises
                          .where((e) => e.muscleGroup == _filterGroup)
                          .toList();
                    }
                    if (_isCustomFilter != null) {
                      exercises = exercises
                          .where((e) => e.isCustom == _isCustomFilter)
                          .toList();
                    }

                    final showRecents =
                        !isSearching &&
                        _recentExercises != null &&
                        _recentExercises!.isNotEmpty;
                    final int recentHeaderCount = showRecents ? 1 : 0;
                    final int recentItemsCount = showRecents
                        ? _recentExercises!.length
                        : 0;

                    if (exercises.isEmpty && !showRecents) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("No exercises found."),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => _openCreator(context),
                              child: const Text("Create One"),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount:
                          recentHeaderCount +
                          recentItemsCount +
                          (exercises.isNotEmpty ? 1 : 0) +
                          exercises.length,
                      itemBuilder: (context, index) {
                        // 1. Recent Header
                        if (showRecents && index == 0) {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Text(
                              "RECENTS",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                          );
                        }

                        // 2. Recent Items
                        if (showRecents &&
                            index > 0 &&
                            index <= recentItemsCount) {
                          final ex = _recentExercises![index - 1];
                          return _buildExerciseTile(ex);
                        }

                        // 3. All Header
                        final int allHeaderIndex =
                            recentHeaderCount + recentItemsCount;
                        if (exercises.isNotEmpty && index == allHeaderIndex) {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Text(
                              "ALL EXERCISES",
                              style: TextStyle(
                                color: Colors.white24,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                          );
                        }

                        // 4. All Items
                        final int exercisesStartIndex = allHeaderIndex + 1;
                        if (index >= exercisesStartIndex) {
                          final ex = exercises[index - exercisesStartIndex];
                          return _buildExerciseTile(ex);
                        }

                        return const SizedBox();
                      },
                    );
                  }(),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseTile(Exercise ex) {
    final isPreviewed = _previewExercise?.id == ex.id;

    return ListTile(
      selected: isPreviewed,
      title: Text(ex.name),
      subtitle: Text(
        "${ex.muscleGroup.name.toUpperCase()} ${ex.subGroup ?? ''}",
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () async {
              final cubit = context.read<WorkoutCubit>();
              await showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: ExerciseManagementDialog(exercise: ex),
                ),
              );
              _loadExercises(); // Refresh after edit/delete
            },
          ),
          IconButton(
            key: ex.id == _cachedExercises?.first.id ? TutorialService().getKeyForStep(TutorialStep.addExerciseToDay) : null,
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _isAdding
                ? null
                : () async {
                    setState(() => _isAdding = true);
                    try {
                      final cubit = context.read<WorkoutCubit>();
                      await cubit.addExerciseToCurrentDay(ex);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } finally {
                      if (mounted) {
                        setState(() => _isAdding = false);
                      }
                    }
                  },
          ),
        ],
      ),
      onTap: () {
        setState(() => _previewExercise = ex);
      },
    );
  }

  Future<void> _openCreator(BuildContext context) async {
    final cubit = context.read<WorkoutCubit>();
    // Capitalize the first letter of each word for a clean exercise name
    final suggestedName = _searchQuery
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
    final result = await showDialog<Map>(
      context: context,
      builder: (_) => ExerciseCreatorDialog(initialName: suggestedName),
    );

    if (result != null && context.mounted) {
      await cubit.createExercise(
        result['name'],
        result['muscleGroup'],
        result['subGroup'],
        result['unit'],
        result['isIsolate'],
        hasCablePosition: result['hasCablePosition'] ?? false,
        hasBenchPosition: result['hasBenchPosition'] ?? false,
        trackWeightReps: result['trackWeightReps'] ?? true,
        trackDistance: result['trackDistance'] ?? false,
        distanceUnit: result['distanceUnit'],
        trackSpeed: result['trackSpeed'] ?? false,
        speedUnit: result['speedUnit'],
        trackCalories: result['trackCalories'] ?? false,
        caloriesUnit: result['caloriesUnit'],
        secondaryMuscleEngagement: result['secondaryMuscleEngagement'],
      );
      _loadExercises(); // Refresh list
    }
  }
}
