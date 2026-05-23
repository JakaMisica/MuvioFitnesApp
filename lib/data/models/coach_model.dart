import 'package:isar/isar.dart';

part 'coach_model.g.dart';

@collection
class CoachModel {
  Id id = Isar.autoIncrement;

  late String name;
  late String parodyName;
  late String description;
  late String systemPrompt;
  late bool isAi;
  late bool isPremium;
  late double price;
  late String avatarUrl;

  // For the free "Lazy Coach"
  bool isLazyCoach = false;

  // Track if user has "hired" this coach
  bool isHired = false;

  CoachModel({
    required this.name,
    required this.parodyName,
    required this.description,
    required this.systemPrompt,
    this.isAi = true,
    this.isPremium = false,
    this.price = 0.0,
    this.avatarUrl = '',
    this.isLazyCoach = false,
    this.isHired = false,
  });
}
