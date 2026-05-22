import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/workout/workout_cubit.dart';
import '../../../../data/models/workout_template.dart';

class SaveWorkoutTemplateDialog extends StatefulWidget {
  final Map<String, dynamic>? sharedData;
  const SaveWorkoutTemplateDialog({super.key, this.sharedData});

  @override
  State<SaveWorkoutTemplateDialog> createState() =>
      _SaveWorkoutTemplateDialogState();
}

class _SaveWorkoutTemplateDialogState extends State<SaveWorkoutTemplateDialog> {
  final _nameController = TextEditingController();
  final _searchController = TextEditingController();

  final List<TemplateFolder> _navigationStack = [];
  List<TemplateFolder> _currentSubFolders = [];
  List<TemplateFolder> _filteredSubFolders = [];
  bool _isLoading = true;
  TemplateFolder? _selectedFolder;

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
      List<TemplateFolder> folders;
      if (_navigationStack.isEmpty) {
        folders = await cubit.getAllFolders();
      } else {
        folders = await cubit.getSubFolders(_navigationStack.last.id);
      }

      if (mounted) {
        setState(() {
          _currentSubFolders = folders;
          _filteredSubFolders = folders;
          _isLoading = false;
          // Don't auto-select if we just navigated
          _selectedFolder = null;
        });
      }
    } catch (e) {
      debugPrint("Error loading folders: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _filterFolders(String query) {
    setState(() {
      _filteredSubFolders = _currentSubFolders
          .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _pushFolder(TemplateFolder folder) {
    setState(() {
      _navigationStack.add(folder);
      _searchController.clear();
    });
    _loadCurrentLevel();
  }

  void _popFolder() {
    if (_navigationStack.isNotEmpty) {
      setState(() {
        _navigationStack.removeLast();
        _searchController.clear();
      });
      _loadCurrentLevel();
    }
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
                    await _loadCurrentLevel();
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

  @override
  Widget build(BuildContext context) {
    final currentPath = _navigationStack.isEmpty
        ? "Root"
        : _navigationStack.map((f) => f.name).join(" > ");

    return AlertDialog(
      title: const Text("Save as Workout"),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              onTap: () {
                _nameController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _nameController.text.length,
                );
              },
              decoration: const InputDecoration(
                labelText: "Workout Name",
                hintText: "e.g. Full Body Routine",
              ),
              autofocus: true,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (_navigationStack.isNotEmpty)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back, size: 20),
                    onPressed: _popFolder,
                  ),
                if (_navigationStack.isNotEmpty) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Location: $currentPath",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _showCreateFolderDialog,
                  icon: const Icon(
                    Icons.create_new_folder_outlined,
                    size: 20,
                    color: Colors.cyanAccent,
                  ),
                  tooltip: "New Sub-folder",
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              onChanged: _filterFolders,
              decoration: InputDecoration(
                hintText: "Search in this folder...",
                prefixIcon: const Icon(Icons.search, size: 18),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    _filteredSubFolders.isEmpty && _navigationStack.isNotEmpty
                    ? _buildSaveHereOption()
                    : _buildFolderList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final folderToSave =
                _selectedFolder ??
                (_navigationStack.isNotEmpty ? _navigationStack.last : null);

            if (_nameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Name your workout!")),
              );
              return;
            }

            if (folderToSave == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Select a folder first!")),
              );
              return;
            }

            if (widget.sharedData != null) {
              context.read<WorkoutCubit>().saveSharedWorkoutAsTemplate(
                widget.sharedData!,
                _nameController.text,
                folderId: folderToSave.id,
                folderName: folderToSave.name,
              );
            } else {
              context.read<WorkoutCubit>().saveCurrentDayAsTemplate(
                _nameController.text,
                folderToSave.name,
                folderId: folderToSave.id,
              );
            }
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Saved to '${folderToSave.name}'")),
            );
          },
          child: const Text("Save Workout"),
        ),
      ],
    );
  }

  Widget _buildSaveHereOption() {
    final isSelected = _selectedFolder == null;
    return InkWell(
      onTap: () => setState(() => _selectedFolder = null),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: isSelected ? Colors.white.withOpacity(0.05) : null,
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: isSelected ? Colors.cyanAccent : Colors.white24,
            ),
            const SizedBox(width: 12),
            const Text("Save in this folder"),
          ],
        ),
      ),
    );
  }

  Widget _buildFolderList() {
    if (_filteredSubFolders.isEmpty && _navigationStack.isEmpty) {
      return const Center(
        child: Text("No folders yet.", style: TextStyle(color: Colors.white24)),
      );
    }

    return ListView.builder(
      itemCount:
          _filteredSubFolders.length + (_navigationStack.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        if (_navigationStack.isNotEmpty && index == 0) {
          return _buildSaveHereOption();
        }

        final folder =
            _filteredSubFolders[index - (_navigationStack.isNotEmpty ? 1 : 0)];
        final isSelected = _selectedFolder?.id == folder.id;

        return GestureDetector(
          onDoubleTap: () => _pushFolder(folder),
          child: ListTile(
            dense: true,
            leading: const Icon(Icons.folder_outlined, size: 20),
            title: Text(folder.name),
            trailing: const Icon(
              Icons.chevron_right,
              size: 16,
              color: Colors.white24,
            ),
            selected: isSelected,
            selectedTileColor: Colors.white.withOpacity(0.05),
            onTap: () => setState(() => _selectedFolder = folder),
          ),
        );
      },
    );
  }
}
