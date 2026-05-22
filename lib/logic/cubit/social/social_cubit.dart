import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math' as math;
import 'package:biofit_pro/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:biofit_pro/data/repositories/social_repository.dart';
import 'package:biofit_pro/data/models/social_models.dart';
import 'package:biofit_pro/data/repositories/body_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biofit_pro/core/services/coach_service.dart';
import 'package:biofit_pro/data/repositories/coach_repository.dart';
import 'package:biofit_pro/core/services/notification_service.dart';
import 'package:biofit_pro/core/utils/profanity_filter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:biofit_pro/logic/cubit/evolution/evolution_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io' show File, Platform;

// RE-EXPORT models so UI can use them
export 'package:biofit_pro/data/models/social_models.dart';

class UserReport extends Equatable {
  final String id;
  final String reporterId;
  final String reportedUserId;
  final String reason;
  final DateTime timestamp;
  final String? messageId;

  const UserReport({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    required this.reason,
    required this.timestamp,
    this.messageId,
  });

  @override
  List<Object?> get props => [
    id,
    reporterId,
    reportedUserId,
    reason,
    timestamp,
    messageId,
  ];
}

class SocialState extends Equatable {
  final List<SocialConversation> conversations;
  final List<SocialMessage> messages;
  final List<UserReport> reports;
  final List<String> bannedUserIds;
  final String userName;
  final String? myDnaId;
  final bool isLoading;
  final String? error;

  const SocialState({
    this.conversations = const [],
    this.messages = const [],
    this.reports = const [],
    this.bannedUserIds = const [],
    this.userName = 'Muvio Citizen',
    this.myDnaId,
    this.isLoading = false,
    this.error,
  });

  SocialState copyWith({
    List<SocialConversation>? conversations,
    List<SocialMessage>? messages,
    List<UserReport>? reports,
    List<String>? bannedUserIds,
    String? userName,
    String? myDnaId,
    bool? isLoading,
    String? error,
  }) {
    return SocialState(
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      reports: reports ?? this.reports,
      bannedUserIds: bannedUserIds ?? this.bannedUserIds,
      userName: userName ?? this.userName,
      myDnaId: myDnaId ?? this.myDnaId,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    conversations,
    messages,
    reports,
    bannedUserIds,
    userName,
    myDnaId,
    isLoading,
    error,
  ];
}

class SocialCubit extends Cubit<SocialState> {
  final SocialRepository _repository = locator<SocialRepository>();
  final BodyRepository _bodyRepository = locator<BodyRepository>();
  
  StreamSubscription? _msgSubscription;
  Timer? _restPollingTimer;

  // Use a getter to avoid crashing if Firebase isn't initialized on Windows/Desktop
  FirebaseFirestore? get _firestore {
    try {
      if (Firebase.apps.isNotEmpty) {
        return FirebaseFirestore.instance;
      }
    } catch (e) {
      debugPrint('[FIRE CONFIG] Firestore not available: $e');
    }
    return null;
  }

  SocialCubit() : super(const SocialState()) {
    // Immediate mock load to prevent empty screen while awaiting DB
    _seedInitialRooms();
    _init();
  }

  void _seedInitialRooms() {
    // Seed state immediately so UI isn't empty on first frame
    final mockC1 = SocialConversation()
      ..remoteId = '1'
      ..name = 'MUVIO SYNC GATEWAY'
      ..isGroup = true
      ..participantIds = ['me', 'u2', 'u3']
      ..lastMessage = 'Synchronizing protocol...'
      ..lastActive = DateTime.now();

    final mockC2 = SocialConversation()
      ..remoteId = 'dev_support'
      ..name = 'DEVELOPER (REPORT BUG)'
      ..isGroup = false
      ..lastMessage = 'System Online.'
      ..lastActive = DateTime.now().subtract(const Duration(minutes: 5));

    final mockC3 = SocialConversation()
      ..remoteId = 'looksmax_3'
      ..name = 'MUVIO NETWORK'
      ..isGroup = true
      ..lastMessage = 'Optimization in progress.'
      ..lastActive = DateTime.now().subtract(const Duration(minutes: 10));

    emit(state.copyWith(conversations: [mockC1, mockC2, mockC3]));
  }

  Future<void> _init() async {
    final settings = await _bodyRepository.getUserSettings();
    final msgs = await _repository.getAllMessages();
    
    // ALWAYS ensure a unique local ID exists first (critical for Windows)
    if (settings.socialUserId == null || settings.socialUserId!.isEmpty || settings.socialUserId == 'null') {
      final String newId = 'user_${DateTime.now().millisecondsSinceEpoch}_${(DateTime.now().microsecond % 9000).abs()}';
      settings.socialUserId = newId;
      await _bodyRepository.saveUserSettings(settings);
      debugPrint('[SOCIAL] Generated new Citizen ID: $newId');
    }

    // Ensure default groups exist in DB
    await _loadMockData(); 
    
    // Auto-Cleanup: Bug reports older than 30 days
    await _cleanupOldReports();
    // Now get the uid - on Windows this will correctly use the persisted local ID
    final String? myUid = await _getSafeMyUid();
    
    // Auto-Sync Google Name if not set
    String? currentName = settings.socialUserName;
    if (currentName == null || currentName.isEmpty) {
      try {
        currentName = FirebaseAuth.instance.currentUser?.displayName;
      } catch (_) {}
      if (currentName != null && currentName.isNotEmpty) {
        settings.socialUserName = currentName;
        await _bodyRepository.saveUserSettings(settings);
      }
    }
    
    final String savedName = currentName ?? myUid ?? 'Muvio Citizen';

    final convs = await _repository.getAllConversations();
    emit(state.copyWith(
      conversations: convs,
      messages: msgs,
      userName: savedName,
      myDnaId: myUid,
    ));
    debugPrint('[SOCIAL] Init complete. DNA ID: $myUid | Name: $savedName');

    try {
      if (kIsWeb || Platform.isWindows) {
         _startRestSync();
      } else {
         _startFirestoreSync();
      }
    } catch (e) {
      debugPrint('[SOCIAL] Skipping cloud sync init: $e');
    }

    // --- COACH INTEGRATION ---
    await _ensureActiveCoachConversation();
    
    // --- MONTHLY RANDOM SQUAD INTEGRATION ---
    // 1. Register self in global registry so we can be shuffled
    await _registerInGlobalRegistry();
    // 2. Compute and join the monthly group
    await _syncMonthlyGroups();
    
    // Check for inactivity messages
    await locator<CoachService>().checkInactivity(this);
  }

  Future<void> _registerInGlobalRegistry() async {
    final fs = _firestore;
    final myUid = await _getSafeMyUid();
    if (fs == null || myUid == null) return;

    try {
      await fs.collection('users_registry').doc(myUid).set({
        'uid': myUid,
        'name': state.userName,
        'lastActive': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      debugPrint('[SOCIAL] Successfully registered in Global DNA Registry.');
    } catch (e) {
      debugPrint('[SOCIAL ERR] Global registration failed: $e');
    }
  }

  Future<void> _syncMonthlyGroups() async {
    final fs = _firestore;
    final myUid = await _getSafeMyUid();
    if (fs == null || myUid == null) return;

    try {
      // 1. Get current month key as seed (e.g., "2026_04")
      final now = DateTime.now();
      final monthKey = "${now.year}_${now.month.toString().padLeft(2, '0')}";
      
      // 2. Fetch all registered users
      final snapshot = await fs.collection('users_registry').get();
      final allUsers = snapshot.docs.map((d) => d.data()).toList();
      
      if (allUsers.length < 2) return; // Not enough people for a group

      // 3. Deterministic Shuffle
      // Sort first to ensure order is identical on all devices before shuffle
      allUsers.sort((a, b) => (a['uid'] as String).compareTo(b['uid'] as String));
      
      // Seeded random based on monthKey
      final seed = monthKey.hashCode;
      final random = math.Random(seed);
      
      // Fisher-Yates shuffle
      for (int i = allUsers.length - 1; i > 0; i--) {
        int n = random.nextInt(i + 1);
        var temp = allUsers[i];
        allUsers[i] = allUsers[n];
        allUsers[n] = temp;
      }

      // 4. Chunk into groups of 4 to 7
      // We'll target 5 per group as a sweet spot
      const int targetSize = 5;
      final List<List<Map<String, dynamic>>> squads = [];
      for (int i = 0; i < allUsers.length; i += targetSize) {
         final end = (i + targetSize < allUsers.length) ? i + targetSize : allUsers.length;
         squads.add(allUsers.sublist(i, end));
      }
      
      // Ensure the last squad isn't too small
      if (squads.length > 1 && squads.last.length < 3) {
         final last = squads.removeLast();
         squads.last.addAll(last);
      }

      // 5. Find MY squad
      int mySquadIndex = squads.indexWhere((s) => s.any((u) => u['uid'] == myUid));
      if (mySquadIndex == -1) return;

      final mySquadMembers = squads[mySquadIndex];
      final squadConvId = "monthly_gym_bros_$monthKey\_$mySquadIndex";
      
      // 6. Automatically join room in local DB
      final existing = await _repository.getConversationByRemoteId(squadConvId);
      if (existing == null) {
         final newConv = SocialConversation()
           ..remoteId = squadConvId
           ..name = "NEW RANDOM MONTHLY GYM BROS"
           ..isGroup = true
           ..participantIds = mySquadMembers.map((u) => u['uid'] as String).toList()
           ..lastActive = DateTime.now()
           ..lastMessage = "Your new squad for $monthKey is ready! 🧬";
         await _repository.saveConversation(newConv);
         
         final allConvs = await _repository.getAllConversations();
         emit(state.copyWith(conversations: allConvs));
         debugPrint('[SQUAD] Joined new monthly squad: $squadConvId');
      }
    } catch (e) {
      debugPrint('[SQUAD ERR] Shuffle failed: $e');
    }
  }

  Future<void> _cleanupOldReports() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    debugPrint('[SOCIAL] Regular maintenance: Cleaning up bug reports older than: $cutoff');
    await _repository.deleteOldMessages('dev_support', cutoff);
    
    // Refresh state messages
    final msgs = await _repository.getAllMessages();
    emit(state.copyWith(messages: msgs));
  }

  Future<void> updateUserName(String newName) async {
    final settings = await _bodyRepository.getUserSettings();
    settings.socialUserName = newName;
    await _bodyRepository.saveUserSettings(settings);
    emit(state.copyWith(userName: newName));
  }

  void _startFirestoreSync() {
    _msgSubscription?.cancel();
    final fs = _firestore;
    if (fs == null) return;
    
    debugPrint('[SOCIAL] Starting Native Firestore Listener...');
    _msgSubscription = fs
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(100)
        .snapshots()
        .listen((snapshot) {
      _processFirestoreMessages(snapshot.docs);
    }, onError: (err) => debugPrint('[FIRESTORE ERR] $err'));
  }

  Future<void> _processFirestoreMessages(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    final String? myUid = await _getSafeMyUid();
    if (myUid == null) return;

    final List<SocialMessage> toAdd = [];
    final currentMessages = await _repository.getAllMessages();

    for (var doc in docs) {
      final data = doc.data();
      final String mid = doc.id;
      final String cid = data['conversationId'] ?? 'unknown';
      final String sid = data['senderId'] ?? 'other';
      final String sname = data['senderName'] ?? 'User';
      final String text = data['text'] ?? '';
      final ts = data['timestamp'];
      final DateTime dt = (ts is Timestamp) ? ts.toDate() : DateTime.now();

      final exists = currentMessages.any((m) {
        if (m.remoteId == mid) return true;
        // Check for local pending messages that match this incoming cloud message
        if (m.text == text && m.conversationId == cid) {
           final diff = m.timestamp.difference(dt).abs().inSeconds;
           if (diff < 15) return true; 
        }
        return false;
      });
      
      if (!exists) {
        final isFromMe = sid == myUid;
        
        // Auto-Establish Link if we don't know this conversation (Incoming P2P)
        final existing = await _repository.getConversationByRemoteId(cid);
        if (existing == null && cid.startsWith('p2p_')) {
           await _autoEstablishP2PLink(cid, sname, sid);
        }

        final newMsg = SocialMessage()
          ..conversationId = cid
          ..remoteId = mid
          ..senderId = isFromMe ? 'me' : sid
          ..senderName = isFromMe ? 'You' : sname
          ..text = text
          ..timestamp = dt
          ..isPending = false;
        
        toAdd.add(newMsg);

        // Notify user if NOT from me and NOT muted/blocked
        if (!isFromMe) {
          final conv = existing ?? await _repository.getConversationByRemoteId(cid);
          if (conv != null && !conv.isMuted && !conv.isBlocked) {
            NotificationService.showMessageNotification(
              conversationId: cid,
              senderName: sname,
              text: text,
              isGroup: conv.isGroup,
            );
          }
        }
      }
    }

    if (toAdd.isNotEmpty) {
      await _repository.saveMessages(toAdd);
      final allMsgs = await _repository.getAllMessages();
      
      final allConvs = await _repository.getAllConversations();
      bool convUpdated = false;
      for (var conv in allConvs) {
         final convMsgs = allMsgs.where((m) => m.conversationId == conv.remoteId).toList();
         if (convMsgs.isNotEmpty) {
           final latestMsg = convMsgs.reduce((a, b) => a.timestamp.isAfter(b.timestamp) ? a : b);
           if (conv.lastMessage != latestMsg.text || conv.lastActive != latestMsg.timestamp) {
             conv.lastMessage = latestMsg.text;
             conv.lastActive = latestMsg.timestamp;
             await _repository.saveConversation(conv);
             convUpdated = true;
           }
         }
      }

      final updatedConvs = convUpdated ? await _repository.getAllConversations() : allConvs;
      emit(state.copyWith(messages: allMsgs, conversations: updatedConvs));
    }
  }

  Future<void> _loadMockData() async {
    final devSupport = await _repository.getConversationByRemoteId('dev_support') ?? SocialConversation()
      ..remoteId = 'dev_support'
      ..name = 'DEVELOPER (Report Bug)'
      ..isGroup = false
      ..participantIds = ['me', 'developer']
      ..lastMessage = 'Connected with Developer.'
      ..lastActive = DateTime.now();

    final group1 = await _repository.getConversationByRemoteId('1') ?? SocialConversation()
      ..remoteId = '1'
      ..name = 'Hypertrophy Squad'
      ..isGroup = true
      ..participantIds = ['me', 'user2', 'user3']
      ..lastMessage = 'Let\'s crush the leg day tomorrow!'
      ..lastActive = DateTime.now();

    final group2 = await _repository.getConversationByRemoteId('looksmax_3') ?? SocialConversation()
      ..remoteId = 'looksmax_3'
      ..name = 'LOOKSMAXXING'
      ..isGroup = true
      ..participantIds = ['me', 'u4', 'u5']
      ..lastMessage = 'Optimization in progress.'
      ..lastActive = DateTime.now();

    final group3 = await _repository.getConversationByRemoteId('coach_alpha') ?? SocialConversation()
      ..remoteId = 'coach_alpha'
      ..name = 'Coach Marcus'
      ..isGroup = false
      ..participantIds = ['me', 'coach']
      ..lastMessage = 'Your protein intake is looking good.'
      ..lastActive = DateTime.now().subtract(const Duration(hours: 2));

    await _repository.saveConversation(devSupport);
    await _repository.saveConversation(group1);
    await _repository.saveConversation(group2);
    await _repository.saveConversation(group3);

    final allMsgs = await _repository.getAllMessages();
    if (allMsgs.isEmpty) {
      final m1 = SocialMessage()
        ..conversationId = 'dev_support'
        ..remoteId = 'm_dev_init'
        ..senderId = 'developer'
        ..senderName = 'Developer'
        ..text = 'Hello! Welcome to BioFit Social. Cloud sync is now active.'
        ..timestamp = DateTime.now().subtract(const Duration(days: 1));
      await _repository.saveMessage(m1);
    }
  }

  Future<String?> _getSafeMyUid() async {
    // First: prefer Google/Firebase UID if signed in
    String? uid;
    try {
      if (Firebase.apps.isNotEmpty) {
        uid = FirebaseAuth.instance.currentUser?.uid;
      }
    } catch (e) {
      debugPrint('[FIRE ERR] Auth check failed: $e');
    }
    if (uid != null && uid.isNotEmpty) return uid;

    // Fallback: always use the persisted local Citizen ID
    // This is the primary path for Windows where Firebase auth is not active
    final settings = await _bodyRepository.getUserSettings();
    if (settings.socialUserId == null || settings.socialUserId!.isEmpty || settings.socialUserId == 'null') {
      final String newId = 'user_${DateTime.now().millisecondsSinceEpoch}_${(DateTime.now().microsecond % 9000).abs()}';
      settings.socialUserId = newId;
      await _bodyRepository.saveUserSettings(settings);
      debugPrint('[SOCIAL CUBIT] Generated Emergency UID: $newId');
    }
    debugPrint('[SOCIAL CUBIT] Using Citizen UID: ${settings.socialUserId}');
    return settings.socialUserId;
  }

  Future<void> sendMessage(String conversationId, String text) async {
    if (state.bannedUserIds.contains('me')) return;

    final isProfane = ProfanityFilter.containsSwearWords(text);
    final String? myUid = await _getSafeMyUid();
    if (myUid == null) return;

    final newMessage = SocialMessage()
      ..conversationId = conversationId
      ..remoteId = DateTime.now().millisecondsSinceEpoch.toString()
      ..senderId = 'me'
      ..senderName = state.userName
      ..text = text
      ..timestamp = DateTime.now()
      ..isProfane = isProfane
      ..isBlurred = isProfane
      ..isPending = true;

    await _repository.saveMessage(newMessage);
    debugPrint('[SOCIAL CUBIT] Message saved to Isar: ${newMessage.text}');
    
    final conv = await _repository.getConversationByRemoteId(conversationId);
    if (conv != null) {
      conv.lastMessage = text;
      conv.lastActive = DateTime.now();
      await _repository.saveConversation(conv);
    }

    final allMessages = await _repository.getAllMessages();
    final allConvs = await _repository.getAllConversations();
    debugPrint('[SOCIAL CUBIT] State updated. Total messages: ${allMessages.length}');
    emit(state.copyWith(messages: allMessages, conversations: allConvs));

    // Upload to Firebase
    try {
      final fs = _firestore;
      if (fs == null) {
        // Fallback for Windows/Web
        await _sendRestMessage(text, conversationId);
        return;
      }
      
      final docRef = await fs.collection('messages').add({
        'conversationId': conversationId,
        'senderId': myUid,
        'senderName': state.userName,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      debugPrint('[SOCIAL CUBIT] Firestore upload success: ${docRef.id}');
      
      // Update local message with Firebase ID to avoid duplication
      newMessage.isPending = false;
      newMessage.remoteId = docRef.id;
      await _repository.saveMessage(newMessage);
    } catch (e) {
      debugPrint('[FIRE ERR] Firestore send failed: $e');
    }

    // --- SOCIAL REWARD SYSTEM ---
    _incrementSocialRewards(isSnap: false);

    if (conversationId.startsWith(CoachService.COACH_CONV_ID_PREFIX)) {
      _handleCoachResponse(conversationId, text);
    }
  }

  Future<void> _incrementSocialRewards({required bool isSnap}) async {
    final settings = await _bodyRepository.getUserSettings();
    final now = DateTime.now();
    
    // Check if reset is needed
    final lastReset = settings.lastRewardResetDate;
    final isNewDay = lastReset == null || 
        lastReset.year != now.year || 
        lastReset.month != now.month || 
        lastReset.day != now.day;

    if (isNewDay) {
      settings.lastRewardResetDate = now;
      settings.todayMessageRewardsCount = 0;
      settings.todaySnapRewardsCount = 0;
    }

    if (isSnap) {
      if (settings.todaySnapRewardsCount < 5) {
        settings.todaySnapRewardsCount++;
        await _bodyRepository.saveUserSettings(settings);
        locator<EvolutionCubit>().addSocialPoints(3);
      }
    } else {
      if (settings.todayMessageRewardsCount < 10) {
        settings.todayMessageRewardsCount++;
        await _bodyRepository.saveUserSettings(settings);
        locator<EvolutionCubit>().addSocialPoints(1);
      }
    }
  }

  Future<void> sendSnap(String conversationId, String imagePath) async {
    if (state.bannedUserIds.contains('me')) return;
    
    final String? myUid = await _getSafeMyUid();
    if (myUid == null) return;

    // 1. Local Preview
    final newMessage = SocialMessage()
      ..conversationId = conversationId
      ..remoteId = 'temp_${DateTime.now().millisecondsSinceEpoch}'
      ..senderId = 'me'
      ..senderName = state.userName
      ..text = '[SNAP]'
      ..timestamp = DateTime.now()
      ..isSnap = true
      ..isPending = true;

    await _repository.saveMessage(newMessage);
    emit(state.copyWith(messages: await _repository.getAllMessages()));

    // 2. Upload to Storage
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('snaps')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      final uploadTask = await storageRef.putFile(File(imagePath));
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // 3. Upload to Firestore
      final fs = _firestore;
      if (fs != null) {
        final docRef = await fs.collection('messages').add({
          'conversationId': conversationId,
          'senderId': myUid,
          'senderName': state.userName,
          'text': downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
          'isSnap': true,
          'snapViewed': false,
        });

        newMessage.isPending = false;
        newMessage.remoteId = docRef.id;
        newMessage.text = downloadUrl;
        await _repository.saveMessage(newMessage);
      }
      
      _incrementSocialRewards(isSnap: true);
      emit(state.copyWith(messages: await _repository.getAllMessages()));
    } catch (e) {
      debugPrint('[SNAP ERR] $e');
    }
  }

  Future<void> markSnapAsViewed(String conversationId, String messageRemoteId, String imageUrl) async {
    // 1. Mark Viewed in Firestore
    final fs = _firestore;
    if (fs != null) {
      try {
        await fs.collection('messages').doc(messageRemoteId).update({
          'snapViewed': true,
        });

        // 2. Immediate Cleanup from Storage
        try {
          await FirebaseStorage.instance.refFromURL(imageUrl).delete();
          debugPrint('[SNAP] Storage file deleted');
        } catch (e) {
          debugPrint('[SNAP STORAGE ERR] $e');
        }

        // 3. Immediate Cleanup from Firestore
        await fs.collection('messages').doc(messageRemoteId).delete();
        debugPrint('[SNAP] Firestore doc deleted');

        // 4. Local Cleanup
        final msg = await _repository.getMessageByRemoteId(messageRemoteId);
        if (msg != null) {
          msg.isDeleted = true;
          await _repository.saveMessage(msg);
          emit(state.copyWith(messages: await _repository.getAllMessages()));
        }
      } catch (e) {
        debugPrint('[SNAP VIEW ERR] $e');
      }
    }
  }

  Future<void> _handleCoachResponse(String conversationId, String userText) async {
    final coachIdStr = conversationId.replaceFirst(CoachService.COACH_CONV_ID_PREFIX, '');
    final coachId = int.tryParse(coachIdStr);
    if (coachId == null) return;

    final coach = await locator<CoachRepository>().getCoach(coachId);
    if (coach == null) return;

    if (!coach.isAi) {
      Future.delayed(const Duration(seconds: 1), () {
        receiveMessage(conversationId, coach.name, "I DON'T CARE! JUST TRAIN!", senderId: 'coach_$coachId');
      });
      return;
    }

    try {
      final response = await locator<CoachService>().generateCoachChatResponse(coach, userText);
      receiveMessage(conversationId, coach.name, response, senderId: 'coach_$coachId');
    } catch (e) {
      receiveMessage(conversationId, coach.name, "YEAH BUDDY! (System Error)", senderId: 'coach_$coachId');
    }
  }

  void receiveMessage(String conversationId, String senderName, String text, {String senderId = 'other'}) async {
    final existingConv = await _repository.getConversationByRemoteId(conversationId);
    if (existingConv == null) {
      final newConv = SocialConversation()
        ..remoteId = conversationId
        ..name = senderName.toUpperCase()
        ..isGroup = conversationId == '1' || conversationId == '3'
        ..participantIds = ['me', senderId]
        ..lastActive = DateTime.now()
        ..lastMessage = text;
      await _repository.saveConversation(newConv);
    } else {
      existingConv.lastMessage = text;
      existingConv.lastActive = DateTime.now();
      await _repository.saveConversation(existingConv);
    }

    final newMessage = SocialMessage()
      ..conversationId = conversationId
      ..remoteId = DateTime.now().millisecondsSinceEpoch.toString()
      ..senderId = senderId
      ..senderName = senderName
      ..text = text
      ..timestamp = DateTime.now();

    await _repository.saveMessage(newMessage);
    
    // Notify user if NOT from me and NOT muted/blocked
    final conv = await _repository.getConversationByRemoteId(conversationId);
    if (conv != null && !conv.isMuted && !conv.isBlocked && senderId != 'me') {
      NotificationService.showMessageNotification(
        conversationId: conversationId,
        senderName: senderName,
        text: text,
        isGroup: conv.isGroup,
      );
    }

    final allMessages = await _repository.getAllMessages();
    final allConvs = await _repository.getAllConversations();
    emit(state.copyWith(messages: allMessages, conversations: allConvs));
  }

  Future<void> deleteMessage(String remoteId) async {
    final msgs = await _repository.getAllMessages();
    final idx = msgs.indexWhere((m) => m.remoteId == remoteId);
    if (idx != -1) {
      await _repository.deleteMessage(msgs[idx].id);
      final allMsgs = await _repository.getAllMessages();
      emit(state.copyWith(messages: allMsgs));
    }
  }

  Future<void> editMessage(String remoteId, String newText) async {
    final msgs = await _repository.getAllMessages();
    final idx = msgs.indexWhere((m) => m.remoteId == remoteId);
    if (idx != -1) {
      final updated = msgs[idx].copyWith(text: newText, isEdited: true);
      await _repository.saveMessage(updated);
      final allMsgs = await _repository.getAllMessages();
      emit(state.copyWith(messages: allMsgs));
    }
  }

  void toggleMute(String conversationId) async {
    final conv = await _repository.getConversationByRemoteId(conversationId);
    if (conv != null) {
      final updated = conv.copyWith(isMuted: !conv.isMuted);
      await _repository.saveConversation(updated);
      final allConvs = await _repository.getAllConversations();
      emit(state.copyWith(conversations: allConvs));
    }
  }

  void toggleBlock(String conversationId) async {
    final conv = await _repository.getConversationByRemoteId(conversationId);
    if (conv != null) {
      final updated = conv.copyWith(isBlocked: !conv.isBlocked);
      await _repository.saveConversation(updated);
      final allConvs = await _repository.getAllConversations();
      emit(state.copyWith(conversations: allConvs));
    }
  }

  void toggleBlur(String remoteId) async {
    final msgs = await _repository.getAllMessages();
    final idx = msgs.indexWhere((m) => m.remoteId == remoteId);
    if (idx != -1) {
      final updated = msgs[idx].copyWith(isBlurred: !msgs[idx].isBlurred);
      await _repository.saveMessage(updated);
      final allMsgs = await _repository.getAllMessages();
      emit(state.copyWith(messages: allMsgs));
    }
  }

  void markAsImported(String remoteId) async {
    final msgs = await _repository.getAllMessages();
    final idx = msgs.indexWhere((m) => m.remoteId == remoteId);
    if (idx != -1) {
      final updated = msgs[idx].copyWith(isImported: true);
      await _repository.saveMessage(updated);
      final allMsgs = await _repository.getAllMessages();
      emit(state.copyWith(messages: allMsgs));
    }
  }

  void reportUser(String reportedUserId, String reason, {String? messageId}) {
    final report = UserReport(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      reporterId: 'me',
      reportedUserId: reportedUserId,
      reason: reason,
      timestamp: DateTime.now(),
      messageId: messageId,
    );
    final updated = List<UserReport>.from(state.reports)..add(report);
    emit(state.copyWith(reports: updated));
    debugPrint('Reported user $reportedUserId for $reason');
  }

  void addFriend(String idOrName) async {
    final String? myId = await _getSafeMyUid();
    if (myId == null || idOrName.isEmpty) return;
    if (myId == idOrName) {
      debugPrint('[SOCIAL] Cannot add self.');
      return;
    }

    // Universal ID established - Citizen IDs or Firebase UIDs
    final ids = [myId, idOrName]..sort();
    final convId = 'p2p_${ids[0]}_${ids[1]}';

    final existing = await _repository.getConversationByRemoteId(convId);
    if (existing == null) {
      // Create local chat with YOUR name (so you can find it)
      final newConv = SocialConversation()
        ..remoteId = convId
        ..name = idOrName // Will be shown as the peer's ID until they respond
        ..isGroup = false
        ..participantIds = [myId, idOrName]
        ..lastActive = DateTime.now()
        ..isPendingFriendRequest = false // I'm the sender - already "accepted" on my side
        ..peerName = idOrName
        ..peerId = idOrName
        ..lastMessage = 'Friend request sent.';
      await _repository.saveConversation(newConv);
      
      final convs = await _repository.getAllConversations();
      emit(state.copyWith(conversations: convs));
      debugPrint('[SOCIAL] P2P Link established: $convId');
    }

    // SEND INITIAL CLOUD MESSAGE WITH YOUR NAME - This triggers auto-link on the other device!
    // Message format: 'FRIEND_REQUEST:MyName' so the other device knows your real name
    sendMessage(convId, 'FRIEND_REQUEST:${state.userName}');
  }

  /// Accept a pending friend request - mark it as accepted and notify peer
  Future<void> acceptFriendRequest(String conversationId) async {
    final conv = await _repository.getConversationByRemoteId(conversationId);
    if (conv == null) return;
    final updated = conv.copyWith(isPendingFriendRequest: false);
    await _repository.saveConversation(updated);
    final convs = await _repository.getAllConversations();
    emit(state.copyWith(conversations: convs));
    // Send acceptance message so peer knows
    sendMessage(conversationId, 'FRIEND_ACCEPTED:${state.userName}');
  }

  /// Delete/remove a conversation (friend or group)
  Future<void> deleteConversation(String conversationId) async {
    final conv = await _repository.getConversationByRemoteId(conversationId);
    if (conv == null) return;
    await _repository.deleteConversation(conv.id);
    // Also remove messages for this conv
    final allMsgs = await _repository.getAllMessages();
    for (final m in allMsgs.where((m) => m.conversationId == conversationId)) {
      await _repository.deleteMessage(m.id);
    }
    final allConvs = await _repository.getAllConversations();
    final remainingMsgs = await _repository.getAllMessages();
    emit(state.copyWith(conversations: allConvs, messages: remainingMsgs));
  }

  /// Create a new group chat from a list of friend IDs
  Future<void> createGroupChat(String groupName, List<String> friendIds) async {
    final String? myId = await _getSafeMyUid();
    if (myId == null) return;
    final convId = 'group_${DateTime.now().millisecondsSinceEpoch}';
    final newConv = SocialConversation()
      ..remoteId = convId
      ..name = groupName
      ..isGroup = true
      ..participantIds = [myId, ...friendIds]
      ..lastActive = DateTime.now()
      ..lastMessage = '${state.userName} created this group.';
    await _repository.saveConversation(newConv);
    final convs = await _repository.getAllConversations();
    emit(state.copyWith(conversations: convs));
    // Announce the group to cloud so friends get it via sync
    sendMessage(convId, 'GROUP_CREATED:$groupName by ${state.userName}');
  }

  void banUser(String userId) {
    final updated = List<String>.from(state.bannedUserIds);
    if (!updated.contains(userId)) updated.add(userId);
    emit(state.copyWith(bannedUserIds: updated));
  }

  void contactDeveloper(String text) {
    sendMessage('dev_support', text);
    // Log to local file for user verification
    debugPrint('[MUVIO SUPPORT] Bug reported: $text');
  }

  Future<void> _autoEstablishP2PLink(String convId, String senderName, String senderId) async {
    // Parse real name from FRIEND_REQUEST message if available
    String displayName = senderName;
    if (senderName.startsWith('FRIEND_REQUEST:')) {
      displayName = senderName.replaceFirst('FRIEND_REQUEST:', '').trim();
    }
    // Use a readable short ID as fallback
    if (displayName.isEmpty || displayName.startsWith('user_')) {
      displayName = senderId.length > 12 ? senderId.substring(senderId.length - 8) : senderId;
    }
    
    final newConv = SocialConversation()
      ..remoteId = convId
      ..name = displayName // Use the REAL sender name!
      ..isGroup = false
      ..participantIds = ['me', senderId]
      ..lastActive = DateTime.now()
      ..isPendingFriendRequest = true  // INCOMING request - show in pending section
      ..peerName = displayName
      ..peerId = senderId
      ..lastMessage = '$displayName wants to connect. 🧬';
    await _repository.saveConversation(newConv);
    
    final convs = await _repository.getAllConversations();
    emit(state.copyWith(conversations: convs));
    debugPrint('[SOCIAL] Auto-Link (pending) established: $convId from $displayName');
  }

  Future<void> _ensureActiveCoachConversation() async {
    final settings = await _bodyRepository.getUserSettings();
    if (settings.activeCoachId == null) return;

    final coach = await locator<CoachRepository>().getCoach(settings.activeCoachId!);
    if (coach == null) return;

    final convId = '${CoachService.COACH_CONV_ID_PREFIX}${coach.id}';
    final existing = await _repository.getConversationByRemoteId(convId);
    
    if (existing == null) {
      final newConv = SocialConversation()
        ..remoteId = convId
        ..name = coach.name
        ..isGroup = false
        ..participantIds = ['me', 'coach_${coach.id}']
        ..lastActive = DateTime.now()
        ..lastMessage = 'Your AI Coach is online.';
      await _repository.saveConversation(newConv);
      
      final convs = await _repository.getAllConversations();
      emit(state.copyWith(conversations: convs));
    }
  }

  void shareContent(String conversationId, String text, String type, String json) async {
     final newMessage = SocialMessage()
      ..conversationId = conversationId
      ..remoteId = DateTime.now().millisecondsSinceEpoch.toString()
      ..senderId = 'me'
      ..senderName = state.userName
      ..text = text
      ..timestamp = DateTime.now()
      ..sharedType = type
      ..sharedContentJson = json
      ..isPending = true;

    await _repository.saveMessage(newMessage);
    
    final settings = await _bodyRepository.getUserSettings();
    final String? myUid = FirebaseAuth.instance.currentUser?.uid ?? settings.socialUserId;
    if (myUid != null) {
       final fs = _firestore;
       if (fs != null) {
          await fs.collection('messages').add({
            'conversationId': conversationId,
            'senderId': myUid,
            'senderName': state.userName,
            'text': text,
            'type': type,
            'sharedData': json,
            'timestamp': FieldValue.serverTimestamp(),
          });
       }
    }

    final allMessages = await _repository.getAllMessages();
    emit(state.copyWith(messages: allMessages));
  }

  @override
  Future<void> close() {
    _msgSubscription?.cancel();
    _restPollingTimer?.cancel();
    return super.close();
  }

  // --- CLOUD REST BRIDGE (FOR WINDOWS/WEB) ---

  void _startRestSync() {
    _restPollingTimer?.cancel();
    // Poll every 5 seconds for snappier Windows sync
    _restPollingTimer = Timer.periodic(const Duration(seconds: 5), (_) => _fetchRestUpdates());
    // Immediate fetch on startup - no waiting!
    _fetchRestUpdates();
    debugPrint('[REST SYNC] Started 5-second polling cycle.');
  }

  Future<void> _fetchRestUpdates() async {
    try {
      final url = Uri.parse('https://firestore.googleapis.com/v1/projects/fitnesapp-d5c3c/databases/(default)/documents/messages?orderBy=timestamp%20desc&pageSize=50');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List documents = data['documents'] ?? [];
        
        // Convert REST format to something we can process
        final String? myUid = await _getSafeMyUid();
        final currentMsgs = await _repository.getAllMessages();
        
        for (var doc in documents) {
          final fields = doc['fields'] ?? {};
          final String mid = (doc['name'] as String).split('/').last;
          final String cid = fields['conversationId']?['stringValue'] ?? 'unknown';
          final String sid = fields['senderId']?['stringValue'] ?? 'other';
          final String sname = fields['senderName']?['stringValue'] ?? 'User';
          final String text = fields['text']?['stringValue'] ?? '';
          
          final exists = currentMsgs.any((m) => m.remoteId == mid || (m.text == text && m.conversationId == cid));
          if (!exists && myUid != null) {
            final isFromMe = sid == myUid;

            // Auto-Establish Link for REST sync
            final existing = await _repository.getConversationByRemoteId(cid);
            if (existing == null && cid.startsWith('p2p_')) {
               await _autoEstablishP2PLink(cid, sname, sid);
            }

            final newMsg = SocialMessage()
              ..conversationId = cid
              ..remoteId = mid
              ..senderId = isFromMe ? 'me' : sid
              ..senderName = isFromMe ? 'You' : sname
              ..text = text
              ..timestamp = DateTime.now(); 
            
            await _repository.saveMessage(newMsg);
          }
        }
        
        final allMsgs = await _repository.getAllMessages();
        emit(state.copyWith(messages: allMsgs));
      }
    } catch (e) {
      debugPrint('[REST SYNC ERR] $e');
    }
  }

  Future<void> _sendRestMessage(String text, String cid) async {
    try {
      final url = Uri.parse('https://firestore.googleapis.com/v1/projects/fitnesapp-d5c3c/databases/(default)/documents/messages');
      final String? myUid = state.myDnaId;
      
      final body = json.encode({
        "fields": {
          "conversationId": {"stringValue": cid},
          "senderId": {"stringValue": myUid ?? "unknown"},
          "senderName": {"stringValue": state.userName},
          "text": {"stringValue": text},
          "type": {"stringValue": "text"},
          "timestamp": {"stringValue": DateTime.now().toIso8601String()} // REST handles ISO strings
        }
      });

      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        debugPrint('[SOCIAL] REST Message Sent Successfully.');
        _fetchRestUpdates(); // Immediate pull to confirm
      } else {
        debugPrint('[SOCIAL] REST Send Failed: ${response.statusCode} | ${response.body}');
      }
    } catch (e) {
      debugPrint('[REST SEND ERR] $e');
    }
  }

  Future<String?> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        return result.files.single.path;
      }
    } catch (e) {
      debugPrint('[PICKER ERR] $e');
    }
    return null;
  }
}
