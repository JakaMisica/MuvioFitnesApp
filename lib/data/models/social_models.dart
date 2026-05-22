import 'package:isar/isar.dart';

part 'social_models.g.dart';

@collection
class SocialConversation {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  late String name;
  bool isGroup = false;
  
  List<String> participantIds = [];
  String? lastMessage;
  late DateTime lastActive;
  
  bool isMuted = false;
  bool isBlocked = false;

  // Friend request fields
  bool isPendingFriendRequest = false; // true = waiting for the other side to accept
  String? peerName;  // Display name of the other person
  String? peerId;    // UID of the other person
  int peerSocialPoints = 0;

  SocialConversation copyWith({
    String? name,
    bool? isMuted,
    bool? isBlocked,
    String? lastMessage,
    DateTime? lastActive,
    bool? isPendingFriendRequest,
    String? peerName,
    String? peerId,
    int? peerSocialPoints,
  }) {
    return SocialConversation()
      ..id = id
      ..remoteId = remoteId
      ..name = name ?? this.name
      ..isGroup = isGroup
      ..participantIds = participantIds
      ..lastMessage = lastMessage ?? this.lastMessage
      ..lastActive = lastActive ?? this.lastActive
      ..isMuted = isMuted ?? this.isMuted
      ..isBlocked = isBlocked ?? this.isBlocked
      ..isPendingFriendRequest = isPendingFriendRequest ?? this.isPendingFriendRequest
      ..peerName = peerName ?? this.peerName
      ..peerId = peerId ?? this.peerId
      ..peerSocialPoints = peerSocialPoints ?? this.peerSocialPoints;
  }
}

@collection
class SocialMessage {
  Id id = Isar.autoIncrement;

  @Index()
  late String conversationId;

  @Index()
  late String remoteId; // For cloud deduplication

  late String senderId;
  late String senderName;
  late String text;
  late DateTime timestamp;

  String? sharedContentJson;
  String? sharedType;
  
  bool isImported = false;
  bool isProfane = false;
  bool isBlurred = false;

  bool isPending = false; 
  bool isEdited = false;
  bool isDeleted = false;

  bool isSnap = false;    // If true, it is an ephemeral image
  bool snapViewed = false; // Flag to trigger deletion after viewing

  SocialMessage copyWith({
    String? text,
    bool? isImported,
    bool? isBlurred,
    bool? isPending,
    bool? isEdited,
    bool? isDeleted,
    bool? snapViewed,
  }) {
    return SocialMessage()
      ..id = id
      ..conversationId = conversationId
      ..remoteId = remoteId
      ..senderId = senderId
      ..senderName = senderName
      ..text = text ?? this.text
      ..timestamp = timestamp
      ..sharedContentJson = sharedContentJson
      ..sharedType = sharedType
      ..isImported = isImported ?? this.isImported
      ..isProfane = isProfane
      ..isBlurred = isBlurred ?? this.isBlurred
      ..isPending = isPending ?? this.isPending
      ..isEdited = isEdited ?? this.isEdited
      ..isDeleted = isDeleted ?? this.isDeleted
      ..isSnap = isSnap
      ..snapViewed = snapViewed ?? this.snapViewed;
  }
}
