import 'package:isar/isar.dart';
import '../datasources/isar_service.dart';
import '../models/social_models.dart';

class SocialRepository {
  final IsarService _isarService;

  SocialRepository(this._isarService);

  Future<List<SocialConversation>> getAllConversations() async {
    final isar = await _isarService.db;
    return await isar.socialConversations
        .where()
        .sortByLastActiveDesc()
        .findAll();
  }

  Future<List<SocialMessage>> getMessagesForConversation(
    String conversationId,
  ) async {
    final isar = await _isarService.db;
    return await isar.socialMessages
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByTimestamp()
        .findAll();
  }

  Future<List<SocialMessage>> getAllMessages() async {
    final isar = await _isarService.db;
    return await isar.socialMessages.where().sortByTimestampDesc().findAll();
  }

  Future<void> saveConversation(SocialConversation conversation) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.socialConversations.put(conversation);
    });
  }

  Future<void> saveMessage(SocialMessage message) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.socialMessages.put(message);
    });
  }

  Future<void> saveMessages(List<SocialMessage> messages) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.socialMessages.putAll(messages);
    });
  }

  Future<SocialConversation?> getConversationByRemoteId(String remoteId) async {
    final isar = await _isarService.db;
    return await isar.socialConversations
        .filter()
        .remoteIdEqualTo(remoteId)
        .findFirst();
  }

  Future<void> deleteMessage(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.socialMessages.delete(id);
    });
  }

  Future<SocialMessage?> getMessageByRemoteId(String remoteId) async {
    final isar = await _isarService.db;
    return await isar.socialMessages
        .filter()
        .remoteIdEqualTo(remoteId)
        .findFirst();
  }

  Future<void> deleteOldMessages(
    String conversationId,
    DateTime olderThan,
  ) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.socialMessages
          .filter()
          .conversationIdEqualTo(conversationId)
          .timestampLessThan(olderThan)
          .deleteAll();
    });
  }

  Future<void> deleteConversation(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.socialConversations.delete(id);
    });
  }
}
