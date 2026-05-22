import 'package:isar/isar.dart';

part 'auto_workout_config.g.dart';

@collection
class AutoWorkoutConfig {
  Id id = Isar.autoIncrement;

  List<AutoFolderConfig> folders = [];

  int currentFolderIndex = 0;
  int currentWorkoutIndex = 0;
  int currentRepeatCount = 0;

  bool multipleFoldersEnabled = false;

  // To keep track of which templates are in each folder for the cycle
  // This is a flattened list of template IDs for the current active subfolder
  List<int> expandedFolderIds = [];
}

@embedded
class AutoFolderConfig {
  int? folderId;
  String? folderName;
  int repeats = 1;
}
