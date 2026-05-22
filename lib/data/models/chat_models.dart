import 'package:isar/isar.dart';
import 'enums.dart';

part 'chat_models.g.dart';

@collection
class ChatSession {
  Id id = Isar.autoIncrement;

  late DateTime startTime;
  late DateTime lastMessageTime;

  String? title;

  @Enumerated(EnumType.name)
  late AiMode mode;

  final messages = IsarLinks<ChatMessage>();
}

@collection
class ChatMessage {
  Id id = Isar.autoIncrement;

  late DateTime timestamp;

  late String role; // "user", "assistant"
  late String content;

  final session = IsarLink<ChatSession>();
}
