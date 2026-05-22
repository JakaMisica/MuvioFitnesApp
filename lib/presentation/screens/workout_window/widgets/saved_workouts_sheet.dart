import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../data/models/workout_template.dart';
import '../../../../data/repositories/workout_repository.dart';

class SavedWorkoutsSheet extends StatefulWidget {
  const SavedWorkoutsSheet({super.key});

  @override
  State<SavedWorkoutsSheet> createState() => _SavedWorkoutsSheetState();
}

class _SavedWorkoutsSheetState extends State<SavedWorkoutsSheet> {
  final List<TemplateFolder> _navigationStack = [];
  List<TemplateFolder> _currentSubFolders = [];
  List<TemplateViewModel> _currentTemplates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentLevel();
  }

  Future<void> _loadCurrentLevel() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final cubit = context.read<WorkoutCubit>();
      if (_navigationStack.isEmpty) {
        final folders = await cubit.getAllFolders();
        if (mounted) {
          setState(() {
            _currentSubFolders = folders;
            _currentTemplates = [];
          });
        }
      } else {
        final current = _navigationStack.last;
        final subFolders = await cubit.getSubFolders(current.id);
        final templates = await cubit.getTemplatesInFolder(current.id);
        if (mounted) {
          setState(() {
            _currentSubFolders = subFolders;
            _currentTemplates = templates;
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading level: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _pushFolder(TemplateFolder folder) {
    setState(() => _navigationStack.add(folder));
    _loadCurrentLevel();
  }

  void _popFolder() {
    if (_navigationStack.isNotEmpty) {
      setState(() => _navigationStack.removeLast());
      _loadCurrentLevel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentFolderName = _navigationStack.isEmpty
        ? "Saved Workouts"
        : _navigationStack.last.name;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                if (_navigationStack.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _popFolder,
                  ),
                Expanded(
                  child: Text(
                    currentFolderName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.create_new_folder),
                  onPressed: _showCreateFolderDialog,
                  tooltip: "Create Sub-folder",
                ),
              ],
            ),
          ),

          const Divider(height: 32),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    final hasItems =
        _currentSubFolders.isNotEmpty || _currentTemplates.isNotEmpty;
    if (!hasItems) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, size: 48, color: Colors.white12),
            const SizedBox(height: 16),
            Text(
              "Empty Folder",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white38),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // Sub-folders
        ..._currentSubFolders.map((folder) => _buildFolderTile(folder)),

        if (_currentSubFolders.isNotEmpty && _currentTemplates.isNotEmpty)
          const Divider(height: 32, indent: 8, endIndent: 8),

        // Templates
        ..._currentTemplates.map((template) => _buildTemplateTile(template)),

        const SizedBox(height: 40), // Extra space at bottom
      ],
    );
  }

  Widget _buildFolderTile(TemplateFolder folder) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.folder, color: Colors.cyanAccent),
        title: Text(folder.name),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_outline,
            size: 20,
            color: Colors.white24,
          ),
          onPressed: () => _confirmDeleteFolder(folder),
        ),
        onTap: () => _pushFolder(folder),
      ),
    );
  }

  Widget _buildTemplateTile(TemplateViewModel template) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(
          Icons.fitness_center_outlined,
          color: Colors.white60,
        ),
        title: Text(template.name),
        subtitle: Text("${template.exercises.length} exercises"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                size: 20,
                color: Colors.white24,
              ),
              onPressed: () => _confirmDeleteTemplate(template),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
        onTap: () {
          context.read<WorkoutCubit>().applyTemplate(template.id);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showCreateFolderDialog() {
    final cubit = context.read<WorkoutCubit>();
    final controller = TextEditingController();
    final parentId = _navigationStack.isEmpty ? null : _navigationStack.last.id;

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text(parentId == null ? "New Folder" : "New Sub-folder"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Folder Name"),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  await cubit.createFolder(controller.text, parentId: parentId);
                  if (mounted) {
                    Navigator.pop(context);
                    _loadCurrentLevel();
                  }
                }
              },
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteFolder(TemplateFolder folder) {
    final cubit = context.read<WorkoutCubit>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: const Text("Delete Folder?"),
          content: Text(
            "This will delete '${folder.name}' and all its contents.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await cubit.deleteFolder(folder.id);
                if (mounted) {
                  Navigator.pop(context);
                  _loadCurrentLevel();
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteTemplate(TemplateViewModel template) {
    final cubit = context.read<WorkoutCubit>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: const Text("Delete Workout?"),
          content: Text("Delete '${template.name}'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await cubit.deleteTemplate(template.id);
                if (mounted) {
                  Navigator.pop(context);
                  _loadCurrentLevel();
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
