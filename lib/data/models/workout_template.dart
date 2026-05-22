import 'package:isar/isar.dart';
import 'exercise.dart';
import 'workout_day.dart';

part 'workout_template.g.dart';

@collection
class TemplateFolder {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  final parent = IsarLink<TemplateFolder>();

  @Backlink(to: 'parent')
  final subFolders = IsarLinks<TemplateFolder>();

  final templates = IsarLinks<WorkoutTemplate>();
}

@collection
class WorkoutTemplate {
  Id id = Isar.autoIncrement;

  late String name;

  final exercises = IsarLinks<TemplateExercise>();

  final folder = IsarLink<TemplateFolder>();
}

@collection
class TemplateExercise {
  Id id = Isar.autoIncrement;

  final exercise = IsarLink<Exercise>();

  List<WorkoutSet> sets = [];

  int orderIndex = 0;
}
