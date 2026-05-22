import 'package:isar/isar.dart';
import '../datasources/isar_service.dart';
import '../models/chat_models.dart';
import '../models/enums.dart';

class ChatRepository {
  final IsarService _isarService;

  ChatRepository(this._isarService);

  Future<List<ChatSession>> getAllSessions() async {
    final isar = await _isarService.db;
    return await isar.chatSessions
        .where()
        .sortByLastMessageTimeDesc()
        .findAll();
  }

  Future<ChatSession?> getSession(int id) async {
    final isar = await _isarService.db;
    final session = await isar.chatSessions.get(id);
    if (session != null) {
      await session.messages.load();
    }
    return session;
  }

  Future<ChatSession> createSession(AiMode mode, {String? title}) async {
    final isar = await _isarService.db;
    final session = ChatSession()
      ..mode = mode
      ..startTime = DateTime.now()
      ..lastMessageTime = DateTime.now()
      ..title =
          title ?? "New Chat ${DateTime.now().hour}:${DateTime.now().minute}";

    await isar.writeTxn(() async {
      await isar.chatSessions.put(session);
    });
    return session;
  }

  Future<void> saveMessage(int sessionId, String role, String content) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final session = await isar.chatSessions.get(sessionId);
      if (session == null) return;

      final message = ChatMessage()
        ..role = role
        ..content = content
        ..timestamp = DateTime.now();

      await isar.chatMessages.put(message);

      message.session.value = session;
      await message.session.save();

      session.messages.add(message);
      session.lastMessageTime = DateTime.now();
      await isar.chatSessions.put(session);
      await session.messages.save();
    });
  }

  Future<void> deleteSession(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final session = await isar.chatSessions.get(id);
      if (session != null) {
        await session.messages.load();
        final messageIds = session.messages.map((m) => m.id).toList();
        await isar.chatMessages.deleteAll(messageIds);
        await isar.chatSessions.delete(id);
      }
    });
  }

  Future<void> clearAll() async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.chatMessages.clear();
      await isar.chatSessions.clear();
    });
  }
}
