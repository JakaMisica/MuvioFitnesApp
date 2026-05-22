import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../data/models/workout_template.dart';
import '../../../../data/models/auto_workout_config.dart';

class AutoWorkoutDialog extends StatefulWidget {
  const AutoWorkoutDialog({super.key});

  @override
  State<AutoWorkoutDialog> createState() => _AutoWorkoutDialogState();
}

class _AutoWorkoutDialogState extends State<AutoWorkoutDialog> {
  int _previewOffset = 0;
  WorkoutTemplate? _previewTemplate;
  bool _isLoading = true;
  bool _isConfigMode = false;

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  Future<void> _loadPreview() async {
    setState(() => _isLoading = true);
    final cubit = context.read<WorkoutCubit>();
    final template = await cubit.getTemplateAtOffset(_previewOffset);
    if (mounted) {
      setState(() {
        _previewTemplate = template;
        _isLoading = false;
        // If no template and not in config mode, maybe we should auto-switch to config mode if no folders selected
        final config = cubit.state.autoConfig;
        if (config == null || config.folders.isEmpty) {
          _isConfigMode = true;
        }
      });
    }
  }

  void _next() {
    setState(() => _previewOffset++);
    _loadPreview();
  }

  void _prev() {
    setState(() => _previewOffset--);
    _loadPreview();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isConfigMode ? _buildConfigView() : _buildPreviewView(),
        ),
      ),
    );
  }

  Widget _buildPreviewView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.blueAccent),
              const SizedBox(width: 8),
              const Text(
                "Auto Workout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white60,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => setState(() => _isConfigMode = true),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white60),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        // Body
        Flexible(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : (_previewTemplate == null
                      ? _buildNoWorkoutsFound()
                      : _buildTemplatePreview()),
          ),
        ),

        // Navigation & Paste
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filledTonal(
                    onPressed: _prev,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  Text(
                    "PREVIEW",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: _next,
                    icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _previewTemplate == null
                      ? null
                      : () async {
                          await context.read<WorkoutCubit>().applyAutoWorkout(
                            _previewOffset,
                          );
                          if (mounted) Navigator.pop(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "PASTE WORKOUT",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTemplatePreview() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _previewTemplate!.name,
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${_previewTemplate!.exercises.length} Exercises",
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        const Divider(height: 32, color: Colors.white10),
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _previewTemplate!.exercises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final ex = _previewTemplate!.exercises.elementAt(index);
              return Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ex.exercise.value?.name ?? "Unknown",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoWorkoutsFound() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.white24),
          SizedBox(height: 16),
          Text(
            "No workouts found in selected folder(s)",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigView() {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final config = state.autoConfig ?? AutoWorkoutConfig();
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white60),
                    onPressed: () {
                      if (config.folders.isNotEmpty) {
                        setState(() => _isConfigMode = false);
                        _loadPreview();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Configure Folders",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildFolderList(config),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _pickFolder(config),
                    icon: const Icon(Icons.create_new_folder),
                    label: const Text("Select Folder"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.05),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const Divider(height: 40, color: Colors.white10),
                  SwitchListTile(
                    title: const Text(
                      "Multiple Folders",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Rotate between different routines",
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                    value: config.multipleFoldersEnabled,
                    onChanged: (val) {
                      config.multipleFoldersEnabled = val;
                      context.read<WorkoutCubit>().saveAutoConfig(config);
                    },
                  ),
                ],
              ),
            ),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: config.folders.isEmpty
                      ? null
                      : () {
                          setState(() => _isConfigMode = false);
                          _loadPreview();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent.withOpacity(0.1),
                    foregroundColor: Colors.cyanAccent,
                    side: const BorderSide(color: Colors.cyanAccent, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "DONE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFolderList(AutoWorkoutConfig config) {
    if (config.folders.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text(
            "No folders selected",
            style: TextStyle(color: Colors.white24),
          ),
        ),
      );
    }

    return Column(
      children: config.folders.asMap().entries.map((entry) {
        final idx = entry.key;
        final folder = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.folder, color: Colors.blueAccent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      folder.folderName ?? "Unnamed Folder",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    onPressed: () {
                      config.folders.removeAt(idx);
                      context.read<WorkoutCubit>().saveAutoConfig(config);
                    },
                  ),
                ],
              ),
              if (config.multipleFoldersEnabled) ...[
                const Divider(color: Colors.white10),
                Row(
                  children: [
                    const Text(
                      "Repeat count:",
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Colors.white60,
                      ),
                      onPressed: () {
                        if (folder.repeats > 1) {
                          folder.repeats--;
                          context.read<WorkoutCubit>().saveAutoConfig(config);
                        }
                      },
                    ),
                    Text(
                      "${folder.repeats}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white60,
                      ),
                      onPressed: () {
                        folder.repeats++;
                        context.read<WorkoutCubit>().saveAutoConfig(config);
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> _pickFolder(AutoWorkoutConfig config) async {
    // Show a small simple folder picker dialog
    // We can reuse the same logic from SavedWorkoutsSheet
    final selectedFolder = await showDialog<TemplateFolder>(
      context: context,
      builder: (_) => const _FolderPickerDialog(),
    );

    if (selectedFolder != null && mounted) {
      final newFolder = AutoFolderConfig()
        ..folderId = selectedFolder.id
        ..folderName = selectedFolder.name
        ..repeats = 1;

      config.folders.add(newFolder);
      context.read<WorkoutCubit>().saveAutoConfig(config);
    }
  }
}

class _FolderPickerDialog extends StatefulWidget {
  const _FolderPickerDialog();

  @override
  State<_FolderPickerDialog> createState() => _FolderPickerDialogState();
}

class _FolderPickerDialogState extends State<_FolderPickerDialog> {
  final List<TemplateFolder> _stack = [];
  List<TemplateFolder> _currentFolders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final cubit = context.read<WorkoutCubit>();
    if (_stack.isEmpty) {
      _currentFolders = await cubit.getAllFolders();
    } else {
      _currentFolders = await cubit.getSubFolders(_stack.last.id);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF222222),
      title: const Text("Select Folder"),
      content: SizedBox(
        width: 300,
        height: 400,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (_stack.isNotEmpty)
                    ListTile(
                      leading: const Icon(Icons.arrow_back),
                      title: const Text("Back"),
                      onTap: () {
                        setState(() => _stack.removeLast());
                        _load();
                      },
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _currentFolders.length,
                      itemBuilder: (context, index) {
                        final f = _currentFolders[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.folder,
                            color: Colors.blueAccent,
                          ),
                          title: Text(f.name),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.greenAccent,
                            ),
                            onPressed: () => Navigator.pop(context, f),
                          ),
                          onTap: () {
                            setState(() => _stack.add(f));
                            _load();
                          },
                        );
                      },
                    ),
                  ),
                ],
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
