import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../../core/services/tutorial_service.dart';
import 'package:muvio/logic/cubit/social/social_cubit.dart';
import 'package:muvio/logic/cubit/workout/workout_cubit.dart';
import 'package:muvio/logic/cubit/diet/diet_cubit.dart';
import 'package:muvio/logic/cubit/tasks/task_cubit.dart';
import 'package:muvio/logic/cubit/sleep/sleep_cubit.dart';
import 'package:muvio/presentation/screens/social/widgets/social_import_dialogs.dart';
import 'package:muvio/presentation/screens/workout_window/widgets/save_workout_template_dialog.dart';
import 'package:muvio/logic/cubit/evolution/evolution_cubit.dart';
import 'package:muvio/logic/cubit/evolution/evolution_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:muvio/presentation/screens/social/widgets/coach_selection_dialog.dart';

import 'package:muvio/presentation/widgets/foggy_background.dart';

class SocialHubScreen extends StatefulWidget {
  const SocialHubScreen({super.key});

  @override
  State<SocialHubScreen> createState() => _SocialHubScreenState();
}

class _SocialHubScreenState extends State<SocialHubScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildChatsTab(),
                    _buildFriendsTab(),
                    _buildCoachTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final tabTitles = ['CHATS', 'FRIENDS', 'COACH'];
    final currentTitle = tabTitles[_tabController.index];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- LEFT: Fire points + current tab title ---
          BlocBuilder<EvolutionCubit, EvolutionState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 4),
                  Text(
                    '${state.settings?.socialPoints ?? 0}',
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    currentTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              );
            },
          ),
          // --- RIGHT: Action buttons ---
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showContactDevDialog(context),
                icon: const Icon(
                  Icons.bug_report_outlined,
                  color: Colors.orangeAccent,
                ),
                tooltip: 'Report Bug / Contact Dev',
              ),
              IconButton(
                onPressed: () => _showAddFriendDialog(context),
                icon: const Icon(
                  Icons.person_add_outlined,
                  color: Colors.cyanAccent,
                ),
              ),
              const Gap(4),
              BlocBuilder<SocialCubit, SocialState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () => _showNameSettingsDialog(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyanAccent.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.cyanAccent.withOpacity(0.3),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (state.userName.isNotEmpty
                                ? state.userName.substring(0, 1)
                                : 'U')
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AddFriendDialog());
  }

  void _showContactDevDialog(BuildContext context) {
    final TextEditingController contactController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'CONTACT DEVELOPERS',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Found a bug or have a suggestion? Tell us directly.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Gap(16),
            TextField(
              controller: contactController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white38),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (contactController.text.isNotEmpty) {
                context.read<SocialCubit>().contactDeveloper(
                  contactController.text,
                );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Message sent to developer! Check the conversation list.',
                    ),
                    backgroundColor: Colors.orangeAccent,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text(
              'SEND MESSAGE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.cyanAccent,
      labelColor: Colors.cyanAccent,
      unselectedLabelColor: Colors.white24,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: const [
        Tab(text: 'CHATS'),
        Tab(text: 'FRIENDS'),
        Tab(text: 'COACH'),
      ],
    );
  }

  Widget _buildChatsTab() {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        if (state.conversations.isEmpty) {
          return const Center(
            child: Text(
              "No active protocols found.",
              style: TextStyle(color: Colors.white24),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.conversations.length,
          itemBuilder: (context, index) {
            final conv = state.conversations[index];
            final widget = _buildConversationCard(conv);
            if (conv.remoteId.startsWith('monthly_gym_bros_')) {
              return KeyedSubtree(
                key: TutorialService().getKeyForStep(TutorialStep.squadItem),
                child: widget,
              );
            }
            return widget;
          },
        );
      },
    );
  }

  Widget _buildConversationCard(SocialConversation conv) {
    return GestureDetector(
      onLongPress: () => _showChatOptions(conv),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: conv.isBlocked
              ? Colors.red.withOpacity(0.05)
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: conv.isBlocked
                ? Colors.red.withOpacity(0.2)
                : Colors.white.withOpacity(0.05),
          ),
        ),
        child: ListTile(
          onTap: () => _openChat(conv),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: conv.remoteId.startsWith('monthly_gym_bros_')
                    ? [Colors.orangeAccent, Colors.deepOrange]
                    : (conv.isGroup
                          ? [Colors.purpleAccent, Colors.blueAccent]
                          : [Colors.cyanAccent, Colors.greenAccent]),
              ),
            ),
            child: Icon(
              conv.remoteId.startsWith('monthly_gym_bros_')
                  ? Icons.emoji_events
                  : (conv.isGroup ? Icons.groups : Icons.person),
              color: Colors.black,
              size: 24,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  conv.name.toUpperCase(),
                  style: TextStyle(
                    color: conv.isBlocked ? Colors.redAccent : Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
              if (conv.isMuted)
                const Icon(Icons.volume_off, color: Colors.white24, size: 14),
            ],
          ),
          subtitle: Text(
            conv.isBlocked
                ? 'ACCESS RESTRICTED'
                : (conv.lastMessage ?? 'Protocol idle...'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: conv.isBlocked
                  ? Colors.redAccent.withOpacity(0.5)
                  : Colors.white38,
              fontSize: 11,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(conv.lastActive),
                style: const TextStyle(color: Colors.white24, fontSize: 10),
              ),
              if (conv.isGroup)
                const Icon(
                  Icons.shield_outlined,
                  size: 12,
                  color: Colors.purpleAccent,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChatOptions(SocialConversation conv) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(
                conv.isBlocked ? Icons.check_circle_outline : Icons.block,
                color: Colors.orangeAccent,
              ),
              title: Text(
                conv.isBlocked ? 'Unblock' : 'Block Chat',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(ctx);
                context.read<SocialCubit>().toggleBlock(conv.remoteId);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Delete Chat',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(ctx);
                showDialog(
                  context: context,
                  builder: (dCtx) => AlertDialog(
                    backgroundColor: const Color(0xFF1A1A1A),
                    title: const Text(
                      'Delete Chat?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      'This will permanently delete "${conv.name}" and all its messages.',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dCtx),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white38),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dCtx);
                          context.read<SocialCubit>().deleteConversation(
                            conv.remoteId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('DELETE'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }

  void _openChat(SocialConversation conv) {
    final socialCubit = context.read<SocialCubit>();
    final taskCubit = context.read<TaskCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: socialCubit),
            BlocProvider.value(value: taskCubit),
          ],
          child: ChatWindowScreen(conversation: conv),
        ),
      ),
    );
  }

  Widget _buildFriendsTab() {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        final myId = state.myDnaId ?? 'Loading...';
        final TextEditingController friendController = TextEditingController();

        // Separate pending from accepted friends
        final pendingRequests = state.conversations
            .where((c) => !c.isGroup && c.isPendingFriendRequest)
            .toList();
        final activeFriends = state.conversations
            .where(
              (c) =>
                  !c.isGroup &&
                  !c.isPendingFriendRequest &&
                  c.remoteId.startsWith('p2p_'),
            )
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // My DNA ID Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyanAccent.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.fingerprint_rounded,
                      color: Colors.cyanAccent,
                      size: 40,
                    ),
                    const Gap(12),
                    Text(
                      state.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Gap(4),
                    SelectableText(
                      myId,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: myId));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('DNA ID copied!'),
                                  backgroundColor: Colors.cyanAccent,
                                ),
                              );
                            },
                            icon: const Icon(Icons.copy_rounded, size: 16),
                            label: const Text('COPY ID'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _showCreateGroupDialog(context, activeFriends),
                            icon: const Icon(Icons.group_add_rounded, size: 16),
                            label: const Text('CREATE GROUP'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pending Friend Requests
              if (pendingRequests.isNotEmpty) ...[
                const Gap(28),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'PENDING REQUESTS (${pendingRequests.length})',
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                ...pendingRequests.map(
                  (conv) => _buildPendingRequestCard(conv),
                ),
              ],

              // Active Friends
              const Gap(28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FRIENDS (${activeFriends.length})',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              if (activeFriends.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'No friends yet. Add someone below!',
                      style: TextStyle(color: Colors.white24, fontSize: 12),
                    ),
                  ),
                )
              else
                ...activeFriends.map((conv) => _buildFriendCard(conv)),

              // Add Friend
              const Gap(28),
              const Text(
                'ADD FRIEND BY ID',
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                ),
              ),
              const Gap(12),
              TextField(
                controller: friendController,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  hintText: "Enter friend's DNA ID...",
                  hintStyle: const TextStyle(color: Colors.white10),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.03),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.person_add_rounded,
                        color: Colors.cyanAccent,
                      ),
                      onPressed: () {
                        if (friendController.text.isNotEmpty) {
                          context.read<SocialCubit>().addFriend(
                            friendController.text.trim(),
                          );
                          friendController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Friend request sent! ✓'),
                              backgroundColor: Colors.greenAccent,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const Gap(8),
              const Text(
                'Share your ID with friends and enter theirs to connect.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white10,
                  fontSize: 10,
                  height: 1.5,
                ),
              ),
              const Gap(24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPendingRequestCard(SocialConversation conv) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
              ),
            ),
            child: Center(
              child: Text(
                (conv.peerName ?? conv.name).isNotEmpty
                    ? (conv.peerName ?? conv.name)[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conv.peerName ?? conv.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'Wants to connect with you',
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => context.read<SocialCubit>().acceptFriendRequest(
                  conv.remoteId,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'ACCEPT',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              const Gap(6),
              GestureDetector(
                onTap: () => context.read<SocialCubit>().deleteConversation(
                  conv.remoteId,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'DECLINE',
                    style: TextStyle(
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFriendCard(SocialConversation conv) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: conv.isBlocked
                    ? [Colors.red.shade800, Colors.red.shade900]
                    : [Colors.cyanAccent, Colors.greenAccent],
              ),
            ),
            child: Center(
              child: Text(
                (conv.peerName ?? conv.name).isNotEmpty
                    ? (conv.peerName ?? conv.name)[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conv.peerName ?? conv.name,
                  style: TextStyle(
                    color: conv.isBlocked ? Colors.redAccent : Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      conv.isBlocked ? 'Blocked' : 'Friend',
                      style: TextStyle(
                        color: conv.isBlocked
                            ? Colors.redAccent.withOpacity(0.6)
                            : Colors.greenAccent.withOpacity(0.7),
                        fontSize: 11,
                      ),
                    ),
                    if (!conv.isBlocked) ...[
                      const Gap(8),
                      Container(width: 1, height: 8, color: Colors.white10),
                      const Gap(8),
                      const Text('🕶️', style: TextStyle(fontSize: 10)),
                      const Gap(4),
                      Text(
                        conv.peerSocialPoints.toString(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white38, size: 20),
            color: const Color(0xFF1A1A1A),
            onSelected: (value) {
              if (value == 'chat') {
                _openChat(conv);
              } else if (value == 'block') {
                context.read<SocialCubit>().toggleBlock(conv.remoteId);
              } else if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (dCtx) => AlertDialog(
                    backgroundColor: const Color(0xFF1A1A1A),
                    title: const Text(
                      'Remove Friend?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      'Remove ${conv.peerName ?? conv.name} from your friends?',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dCtx),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white38),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dCtx);
                          context.read<SocialCubit>().deleteConversation(
                            conv.remoteId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('REMOVE'),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'chat',
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.cyanAccent,
                      size: 18,
                    ),
                    Gap(12),
                    Text(
                      'Open Chat',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'block',
                child: Row(
                  children: [
                    Icon(
                      conv.isBlocked ? Icons.check_circle_outline : Icons.block,
                      color: Colors.orangeAccent,
                      size: 18,
                    ),
                    const Gap(12),
                    Text(
                      conv.isBlocked ? 'Unblock' : 'Block',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.person_remove_outlined,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                    Gap(12),
                    Text(
                      'Remove Friend',
                      style: TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateGroupDialog(
    BuildContext context,
    List<SocialConversation> friends,
  ) {
    final nameController = TextEditingController();
    final selectedIds = <String>{};

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'CREATE GROUP CHAT',
            style: TextStyle(
              color: Colors.purpleAccent,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Group name...',
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Gap(16),
                const Text(
                  'SELECT FRIENDS:',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Gap(8),
                if (friends.isEmpty)
                  const Text(
                    'No friends yet. Add friends first!',
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  )
                else
                  ...friends.map((f) {
                    final pid = f.peerId ?? f.remoteId;
                    return CheckboxListTile(
                      value: selectedIds.contains(pid),
                      onChanged: (v) {
                        setDialogState(() {
                          if (v == true)
                            selectedIds.add(pid);
                          else
                            selectedIds.remove(pid);
                        });
                      },
                      title: Text(
                        f.peerName ?? f.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      activeColor: Colors.purpleAccent,
                      checkColor: Colors.black,
                    );
                  }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.white38),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && selectedIds.isNotEmpty) {
                  context.read<SocialCubit>().createGroupChat(
                    nameController.text,
                    selectedIds.toList(),
                  );
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Group created! ✓'),
                      backgroundColor: Colors.purpleAccent,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'CREATE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoachTab() {
    return const CoachSelectionView();
  }

  void _showNameSettingsDialog(BuildContext context) {
    final cubit = context.read<SocialCubit>();
    final controller = TextEditingController(text: cubit.state.userName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'IDENTITY SETTINGS',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set the name that others will see in chats.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Gap(16),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter your name...',
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white24),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                cubit.updateUserName(controller.text);
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text(
              'SAVE NAME',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatWindowScreen extends StatefulWidget {
  final SocialConversation conversation;
  const ChatWindowScreen({super.key, required this.conversation});

  @override
  State<ChatWindowScreen> createState() => _ChatWindowScreenState();
}

class _ChatWindowScreenState extends State<ChatWindowScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        final conversation = state.conversations.firstWhere(
          (c) => c.remoteId == widget.conversation.remoteId,
          orElse: () => widget.conversation,
        );

        return Scaffold(
          backgroundColor: Colors.black,
          body: FoggyBackground(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: false,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        conversation.isBlocked
                            ? 'BLOCKED'
                            : (conversation.isGroup
                                  ? '${conversation.participantIds.length} members'
                                  : 'Active Channel'),
                        style: TextStyle(
                          fontSize: 10,
                          color: conversation.isBlocked
                              ? Colors.redAccent
                              : Colors.cyanAccent,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    PopupMenuButton<String>(
                      key: TutorialService().getKeyForStep(
                        TutorialStep.squadDetailsIcon,
                      ),
                      icon: const Icon(Icons.more_vert, color: Colors.white70),
                      color: const Color(0xFF1A1A1A),
                      onSelected: (value) {
                        if (value == 'mute') {
                          context.read<SocialCubit>().toggleMute(
                            conversation.remoteId,
                          );
                        } else if (value == 'block') {
                          context.read<SocialCubit>().toggleBlock(
                            conversation.remoteId,
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'mute',
                          child: Row(
                            children: [
                              Icon(
                                conversation.isMuted
                                    ? Icons.volume_up
                                    : Icons.volume_off,
                                color: Colors.cyanAccent,
                                size: 18,
                              ),
                              const Gap(12),
                              Text(
                                conversation.isMuted ? 'UNMUTE' : 'MUTE',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'block',
                          child: Row(
                            children: [
                              Icon(
                                conversation.isBlocked
                                    ? Icons.check_circle_outline
                                    : Icons.block,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                              const Gap(12),
                              Text(
                                conversation.isBlocked ? 'UNBLOCK' : 'BLOCK',
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (conversation.remoteId == 'looksmax_3')
                  _buildPinnedProtocolHeader(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    reverse: true, // Newer messages at the bottom
                    itemCount: state.messages
                        .where((m) => m.conversationId == conversation.remoteId)
                        .length,
                    itemBuilder: (context, index) {
                      final filteredMessages =
                          state.messages
                              .where(
                                (m) =>
                                    m.conversationId == conversation.remoteId,
                              )
                              .toList()
                            ..sort(
                              (a, b) => b.timestamp.compareTo(a.timestamp),
                            );
                      return _buildMessageBubble(
                        filteredMessages[index],
                        conversation,
                      );
                    },
                  ),
                ),
                if (!conversation.isBlocked) _buildInputArea(),
                if (conversation.isBlocked)
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.red.withOpacity(0.1),
                    child: const Center(
                      child: Text(
                        'YOU HAVE BLOCKED THIS CONTACT',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPinnedProtocolHeader() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, taskState) {
        final isImported = taskState.tasks.any(
          (t) => t.group == 'Natural Looks Maxing',
        );

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent.withOpacity(0.15),
                Colors.blueAccent.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.purpleAccent.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.purpleAccent,
                      size: 20,
                    ),
                  ),
                  const Gap(16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NATURAL LOOKS MAXING',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Structural Realignment Protocol',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text(
                'This protocol focuses on foundational habits for facial remodeling and posture correction.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const Gap(20),
              SizedBox(
                width: double.infinity,
                child: isImported
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          await context.read<TaskCubit>().deleteTasksByGroup(
                            'Natural Looks Maxing',
                          );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Protocol Tasks Removed From Daily List!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.redAccent,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.close_rounded, size: 18),
                        label: const Text(
                          'CANCEL / REMOVE PROTOCOL',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.2),
                          foregroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: Colors.redAccent),
                          ),
                          elevation: 0,
                        ),
                      )
                    : ElevatedButton.icon(
                        key: TutorialService().getKeyForStep(
                          TutorialStep.workoutPlanButton,
                        ),
                        onPressed: () async {
                          await context
                              .read<TaskCubit>()
                              .createNaturalLooksMaxingTasks();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Protocol Tasks Added to Daily List!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.purpleAccent,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.download_rounded, size: 18),
                        label: const Text(
                          'IMPORT TO DAILY TASKS',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(
    SocialMessage msg,
    SocialConversation conversation,
  ) {
    final isMe = msg.senderId == 'me';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            GestureDetector(
              onTap: () => _showProfilePreview(msg),
              child: Container(
                margin: const EdgeInsets.only(right: 8, bottom: 4),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: msg.senderId == 'developer'
                      ? Colors.redAccent
                      : (msg.senderId.startsWith('coach')
                            ? Colors.purple
                            : Colors.white12),
                  child: Text(
                    (msg.senderName.isNotEmpty ? msg.senderName[0] : '?')
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!isMe && conversation.isGroup)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 2),
                  child: Text(
                    msg.senderName,
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: isMe
                      ? Colors.cyanAccent.withOpacity(0.08)
                      : Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 16 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 16),
                  ),
                  border: Border.all(
                    color: isMe
                        ? Colors.cyanAccent.withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                  ),
                ),
                child: GestureDetector(
                  onLongPress: () => _showMessageOptions(msg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (msg.sharedType != null) ...[
                        _buildSharedContentPreview(msg),
                        const Gap(8),
                      ],
                      if (msg.isImported && msg.sharedType != null)
                        _buildImportedActions(msg)
                      else if (msg.isSnap)
                        _buildSnapPreview(msg)
                      else if (msg.isBlurred)
                        _buildBlurredMessage(msg)
                      else
                        Text(
                          msg.text,
                          style: TextStyle(
                            color: msg.isDeleted
                                ? Colors.white24
                                : Colors.white,
                            fontSize: 13,
                            fontStyle: msg.isDeleted
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                      if (msg.isEdited && !msg.isDeleted)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            '(edited)',
                            style: TextStyle(
                              color: Colors.white10,
                              fontSize: 8,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isMe)
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 4),
              child: const Icon(
                Icons.check_circle_outline,
                size: 10,
                color: Colors.cyanAccent,
              ),
            ),
        ],
      ),
    );
  }

  void _showProfilePreview(SocialMessage msg) {
    if (msg.senderId == 'me') return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white.withOpacity(0.05),
                child: Text(
                  msg.senderName[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
              const Gap(16),
              Text(
                msg.senderName.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const Gap(4),
              Text(
                'Muvio Community Member',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<SocialCubit>().addFriend(msg.senderName);
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added ${msg.senderName} to friends'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('ADD AS FRIEND'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<SocialCubit>().banUser(msg.senderId);
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.block, size: 16),
                      label: const Text(
                        'BAN USER',
                        style: TextStyle(fontSize: 10),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<SocialCubit>().toggleMute(
                          msg.conversationId,
                        );
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.visibility_off, size: 16),
                      label: const Text(
                        'MUTE / UNMUTE',
                        style: TextStyle(fontSize: 10),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white54,
                        side: const BorderSide(color: Colors.white54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSharedContentPreview(SocialMessage msg) {
    IconData icon;
    Color color;
    String title;

    switch (msg.sharedType) {
      case 'workout':
        icon = Icons.fitness_center;
        color = Colors.cyanAccent;
        title = 'WORKOUT PLAN';
        break;
      case 'diet':
        icon = Icons.restaurant_menu;
        color = Colors.orangeAccent;
        title = 'DIET PLAN';
        break;
      case 'task':
        icon = Icons.checklist;
        color = Colors.purpleAccent;
        title = 'TASK LIST';
        break;
      case 'sleep':
        icon = Icons.bedtime;
        color = Colors.blueAccent;
        title = 'SLEEP DATA';
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
        title = 'UNKNOWN DATA';
    }

    return InkWell(
      onTap: msg.isImported
          ? () => _navigateToImportedData(msg)
          : () => _startImportFlow(msg),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  msg.isImported ? 'VIEW IMPORTED DATA' : 'TAP TO IMPORT DATA',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnapPreview(SocialMessage msg) {
    return InkWell(
      onTap: () => _showSnapViewer(msg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flash_on, color: Colors.cyanAccent, size: 18),
                const Gap(8),
                Text(
                  msg.snapViewed ? 'SNAP OPENED' : 'TAP TO VIEW SNAP',
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          if (!msg.snapViewed)
            const Padding(
              padding: EdgeInsets.only(top: 4.0, left: 2.0),
              child: Text(
                'THIS MESSAGE WILL SELF-DESTRUCT',
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSnapViewer(SocialMessage msg) {
    if (msg.snapViewed) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Image.network(
                msg.text,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.cyanAccent),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () {
                Navigator.pop(ctx);
                context.read<SocialCubit>().markSnapAsViewed(
                  msg.conversationId,
                  msg.remoteId,
                  msg.text,
                );
              },
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SNAP VIEWING...',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredMessage(SocialMessage msg) {
    return InkWell(
      onTap: () => context.read<SocialCubit>().toggleBlur(msg.remoteId),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.visibility_off_outlined,
              color: Colors.white24,
              size: 14,
            ),
            const Gap(8),
            Text(
              'CENSORED CONTENT - TAP TO VIEW',
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageOptions(SocialMessage msg) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(20),
            if (msg.senderId == 'me' && !msg.isDeleted) ...[
              ListTile(
                leading: const Icon(
                  Icons.edit_outlined,
                  color: Colors.cyanAccent,
                ),
                title: const Text(
                  'EDIT MESSAGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _showEditDialog(msg);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'DELETE MESSAGE',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  context.read<SocialCubit>().deleteMessage(msg.remoteId);
                },
              ),
            ],
            if (msg.senderId != 'me')
              ListTile(
                leading: const Icon(
                  Icons.report_problem_outlined,
                  color: Colors.orangeAccent,
                ),
                title: const Text(
                  'REPORT MESSAGE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _showReportDialog(msg);
                },
              ),
            if (msg.senderId != 'me')
              ListTile(
                leading: const Icon(Icons.block, color: Colors.redAccent),
                title: const Text(
                  'BLOCK USER',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  context.read<SocialCubit>().toggleBlock(
                    widget.conversation.remoteId,
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.white70),
              title: const Text(
                'COPY TEXT',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pop(ctx),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(SocialMessage msg) {
    final controller = TextEditingController(text: msg.text);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'EDIT MESSAGE',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<SocialCubit>().editMessage(
                  msg.remoteId,
                  controller.text,
                );
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text('UPDATE'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(SocialMessage msg) {
    final TextEditingController reportController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'REPORT CONTENT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Why are you reporting this message?',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Gap(16),
            TextField(
              controller: reportController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Describe the issue...',
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white38),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SocialCubit>().reportUser(
                msg.senderId,
                reportController.text,
                messageId: msg.remoteId,
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Report submitted. Thank you for keeping Muvio safe!',
                  ),
                  backgroundColor: Colors.cyanAccent,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text(
              'SUBMIT REPORT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToImportedData(SocialMessage msg) {
    final type = msg.sharedType;
    if (type == null) return;
    final data = jsonDecode(msg.sharedContentJson ?? '{}');

    // Determine theme color per type
    Color themeColor;
    switch (type) {
      case 'workout':
        themeColor = Colors.orangeAccent;
        break;
      case 'diet':
        themeColor = Colors.greenAccent;
        break;
      case 'task':
        themeColor = Colors.purpleAccent;
        break;
      case 'sleep':
        themeColor = Colors.indigoAccent;
        break;
      default:
        themeColor = Colors.cyanAccent;
    }

    final dateStr = data['date'] as String?;
    final targetDate = (dateStr != null)
        ? (DateTime.tryParse(dateStr) ?? DateTime.now())
        : DateTime.now();

    showDialog(
      context: context,
      builder: (ctx) => SocialImportPreviewDialog(
        title: 'IMPORTED ${type.toUpperCase()}',
        themeColor: themeColor,
        targetDate: targetDate,
        content: _buildPreviewContent(type, data, themeColor),
        onImport: () {}, // no-op — already imported
        onDelete: () {
          // Delete the whole message from the chat
          context.read<SocialCubit>().deleteMessage(msg.remoteId);
          Navigator.pop(ctx);
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.cyanAccent),
            onPressed: () => _showShareOptions(),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Write a message...",
                hintStyle: const TextStyle(color: Colors.white12),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onSubmitted: (_) => _send(),
            ),
          ),
          const Gap(12),
          CircleAvatar(
            backgroundColor: Colors.cyanAccent,
            child: IconButton(
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.black,
                size: 20,
              ),
              onPressed: _send,
            ),
          ),
        ],
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SHARE DATA',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            const Gap(20),
            _buildShareItem(
              Icons.bolt_rounded,
              'SEND SNAP',
              Colors.cyanAccent,
              'snap',
            ),
            _buildShareItem(
              Icons.fitness_center,
              'WORKOUT PLAN',
              Colors.cyanAccent,
              'workout',
            ),
            _buildShareItem(
              Icons.restaurant_menu,
              'DIET PLAN',
              Colors.orangeAccent,
              'diet',
            ),
            _buildShareItem(
              Icons.checklist,
              'TASK LIST',
              Colors.purpleAccent,
              'task',
            ),
            _buildShareItem(
              Icons.bedtime,
              'SLEEP DATA',
              Colors.blueAccent,
              'sleep',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareItem(
    IconData icon,
    String label,
    Color color,
    String type,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      onTap: () async {
        Navigator.pop(context);

        if (type == 'snap') {
          final imageUrl = await context.read<SocialCubit>().pickImage();
          if (imageUrl != null) {
            context.read<SocialCubit>().sendSnap(
              widget.conversation.remoteId,
              imageUrl,
            );
          }
          return;
        }

        String jsonStr = '{"mock": "data"}';

        if (type == 'workout') {
          final workout = context.read<WorkoutCubit>().state.workoutDay;
          if (workout != null) {
            jsonStr = jsonEncode({
              'date': workout.date.toIso8601String(),
              'exercises': workout.exercises.map((log) {
                return {
                  'name': log.exercise.value?.name ?? 'Unknown',
                  'muscleGroup':
                      log.exercise.value?.muscleGroup.name ?? 'chest',
                  'sets': log.sets.length,
                  'weight': log.sets.isNotEmpty
                      ? (log.sets.first.weight ?? 0.0)
                      : 0.0,
                  'reps': log.sets.isNotEmpty
                      ? (log.sets.first.reps ?? 10)
                      : 10,
                  'notes': log.notes,
                };
              }).toList(),
            });
          }
        } else if (type == 'diet') {
          // Prefer the currently loaded diet; fall back to the latest saved diet
          var diet = context.read<DietCubit>().state.currentDiet;
          diet ??= await context.read<DietCubit>().getLatestDiet();
          if (diet != null) {
            jsonStr = jsonEncode({
              'date': diet.date.toIso8601String(),
              'meals': diet.meals.map((m) {
                return {
                  'name': m.name,
                  'time': m.time,
                  'items': m.items.map((item) {
                    return {
                      'name': item.name,
                      'amount': item.amount,
                      'unit': item.unit,
                      'calories': item.calories,
                      'protein': item.protein,
                      'carbs': item.carbs,
                      'fat': item.fat,
                    };
                  }).toList(),
                };
              }).toList(),
              'supplements': diet.supplements.map((item) {
                return {
                  'name': item.name,
                  'amount': item.amount,
                  'unit': item.unit,
                  'calories': item.calories,
                  'protein': item.protein,
                  'carbs': item.carbs,
                  'fat': item.fat,
                };
              }).toList(),
            });
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No diet data found. Add meals first.'),
                ),
              );
            }
            return;
          }
        } else if (type == 'task') {
          final tasks = context.read<TaskCubit>().state.tasks;
          jsonStr = jsonEncode({
            'tasks': tasks.map((t) {
              return {
                'name': t.name,
                'sentiment': t.sentiment,
                'isNote': t.isNote,
                'recurrenceType': t.recurrenceType,
              };
            }).toList(),
          });
        } else if (type == 'sleep') {
          final session = context.read<SleepCubit>().state.latestSession;
          if (session != null) {
            jsonStr = jsonEncode({
              'date': session.startTime.toIso8601String(),
              'score': session.qualityScore,
              'startTime': session.startTime.toIso8601String(),
              'endTime': session.endTime?.toIso8601String(),
              'eventCount': session.events.length,
            });
          }
        }

        context.read<SocialCubit>().shareContent(
          widget.conversation.remoteId,
          'Shared a $type with you.',
          type,
          jsonStr,
        );
      },
    );
  }

  void _send() {
    if (_controller.text.isNotEmpty) {
      debugPrint(
        '[SOCIAL UI] Sending message to ${widget.conversation.remoteId}: "${_controller.text}"',
      );
      context.read<SocialCubit>().sendMessage(
        widget.conversation.remoteId,
        _controller.text,
      );
      _controller.clear();
    }
  }

  Future<void> _startImportFlow(SocialMessage msg) async {
    final type = msg.sharedType;
    if (type == null) return;

    List<DateTime> highlightedDays = [];
    String title = 'IMPORT ${type.toUpperCase()}';
    Color themeColor = Colors.cyanAccent;

    // 1. Get highlight data & theme
    try {
      if (type == 'workout') {
        highlightedDays = await context.read<WorkoutCubit>().getDaysWithData();
        themeColor = Colors.orangeAccent;
      } else if (type == 'diet') {
        highlightedDays = await context.read<DietCubit>().getDaysWithData();
        themeColor = Colors.greenAccent;
      } else if (type == 'task') {
        highlightedDays = await context.read<TaskCubit>().getDaysWithData();
        themeColor = Colors.purpleAccent;
      } else if (type == 'sleep') {
        highlightedDays = await context.read<SleepCubit>().getDaysWithData();
        themeColor = Colors.indigoAccent;
      }
    } catch (e) {
      debugPrint('Error fetching history: $e');
    }

    // 2. Open Calendar Selector (Old flow returned!)
    if (!mounted) return;
    final targetDate = await showDialog<DateTime>(
      context: context,
      builder: (ctx) => SocialImportSelectorDialog(
        title: title,
        themeColor: themeColor,
        highlightedDays: highlightedDays,
        onDateSelected: (date) => Navigator.pop(ctx, date),
      ),
    );

    if (targetDate == null) return;

    // 3. Open Preview Confirmation
    if (!mounted) return;
    final data = jsonDecode(msg.sharedContentJson ?? '{}');
    await showDialog(
      context: context,
      builder: (ctx) => SocialImportPreviewDialog(
        title: 'CONFIRM IMPORT',
        themeColor: themeColor,
        targetDate: targetDate,
        content: _buildPreviewContent(type, data, themeColor),
        onImport: () async {
          try {
            if (type == 'workout') {
              await context.read<WorkoutCubit>().importWorkoutDay(
                data,
                targetDate: targetDate,
              );
            } else if (type == 'diet') {
              await context.read<DietCubit>().importDietPlan(
                data,
                targetDate: targetDate,
              );
            } else if (type == 'task') {
              await context.read<TaskCubit>().importTasks(
                data,
                targetDate: targetDate,
              );
            } else if (type == 'sleep') {
              await context.read<SleepCubit>().importSleepSession(
                data,
                targetDate: targetDate,
              );
            }

            if (!mounted) return;
            context.read<SocialCubit>().markAsImported(msg.remoteId);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${type.toUpperCase()} IMPORTED SUCCESSFULLY'),
                backgroundColor: Colors.green.withOpacity(0.8),
              ),
            );
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Import Failed: $e')));
          }
        },
      ),
    );
  }

  Widget _buildImportedActions(SocialMessage msg) {
    final type = msg.sharedType;
    final color = _getThemeColorForType(type ?? '');

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        if (type == 'workout' || type == 'diet' || type == 'task')
          _bubbleActionButton(
            label: 'SMART COPY',
            icon: Icons.bolt_rounded,
            color: color,
            onTap: () => _handleSmartCopy(msg),
          ),
        if (type == 'workout' || type == 'diet')
          _bubbleActionButton(
            label: type == 'workout' ? 'SAVE TO FOLDER' : 'SAVE TEMPLATE',
            icon: type == 'workout'
                ? Icons.folder_open_rounded
                : Icons.save_alt,
            color: color,
            onTap: () => _handleSaveToFolder(msg),
          ),
      ],
    );
  }

  Widget _bubbleActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.25), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const Gap(6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getThemeColorForType(String type) {
    switch (type) {
      case 'workout':
        return Colors.orangeAccent;
      case 'diet':
        return Colors.greenAccent;
      case 'task':
        return Colors.purpleAccent;
      case 'sleep':
        return Colors.indigoAccent;
      default:
        return Colors.cyanAccent;
    }
  }

  Future<void> _handleSmartCopy(SocialMessage msg) async {
    final type = msg.sharedType;
    if (type == null) return;
    final data = jsonDecode(msg.sharedContentJson ?? '{}');
    final today = DateTime.now();

    try {
      if (type == 'workout') {
        await context.read<WorkoutCubit>().importWorkoutDay(
          data,
          targetDate: today,
        );
      } else if (type == 'diet') {
        await context.read<DietCubit>().importDietPlan(data, targetDate: today);
      } else if (type == 'task') {
        await context.read<TaskCubit>().importTasks(data, targetDate: today);
      } else if (type == 'sleep') {
        await context.read<SleepCubit>().importSleepSession(
          data,
          targetDate: today,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('COPIED TO TODAY SUCCESSFULLY'),
          backgroundColor: Colors.green.withOpacity(0.8),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Copy Failed: $e')));
    }
  }

  // Helper for Save to Folder
  Future<void> _handleSaveToFolder(SocialMessage msg) async {
    final type = msg.sharedType;
    if (type == null) return;
    final data = jsonDecode(msg.sharedContentJson ?? '{}');

    if (type == 'workout') {
      _showSaveTemplateDialog(data);
    } else if (type == 'diet') {
      _showSaveDietTemplateDialog(data);
    }
  }

  void _showSaveTemplateDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (ctx) => SaveWorkoutTemplateDialog(sharedData: data),
    );
  }

  void _showSaveDietTemplateDialog(Map<String, dynamic> data) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D1117),
        title: const Text(
          'Save Diet Template',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Template Name',
            labelStyle: TextStyle(color: Colors.white70),
            hintText: 'e.g. My Vegan Plan',
            hintStyle: TextStyle(color: Colors.white24),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await context.read<DietCubit>().saveSharedDietAsTemplate(
                  data,
                  nameController.text,
                );
                if (mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Saved template '${nameController.text}'"),
                      backgroundColor: Colors.green.withOpacity(0.8),
                    ),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewContent(
    String type,
    Map<String, dynamic> data,
    Color color,
  ) {
    if (type == 'workout') {
      final List exercises = data['exercises'] ?? [];
      if (exercises.isEmpty) {
        return _emptyState('No exercises in this workout');
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: exercises.asMap().entries.map((entry) {
          final i = entry.key;
          final ex = entry.value;
          final name = ex['name'] ?? 'Unknown';
          final sets = ex['sets'] ?? 0;
          final reps = ex['reps'] ?? 0;
          final weight = ex['weight'] ?? 0.0;
          final muscleGroup = ex['muscleGroup'] ?? 'chest';

          return Container(
            margin: EdgeInsets.only(bottom: i < exercises.length - 1 ? 8 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.07),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.18)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.fitness_center_rounded,
                    color: color,
                    size: 18,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(3),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          muscleGroup.toUpperCase(),
                          style: TextStyle(
                            color: color.withOpacity(0.8),
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _statBadge('$sets × $reps', Icons.repeat_rounded, color),
                    const Gap(4),
                    Text(
                      '$weight kg',
                      style: TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else if (type == 'diet') {
      final List meals = data['meals'] ?? [];
      final List supplements = data['supplements'] ?? [];
      if (meals.isEmpty && supplements.isEmpty) {
        return _emptyState('No meals in this diet plan');
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...meals.asMap().entries.map((entry) {
            final m = entry.value;
            final items = (m['items'] as List?) ?? [];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.18)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant_menu_rounded,
                        color: color,
                        size: 13,
                      ),
                      const Gap(6),
                      Text(
                        m['name']?.toString().toUpperCase() ?? 'MEAL',
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      if (m['time'] != null) ...[
                        const Spacer(),
                        Text(
                          m['time'].toString(),
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(6),
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(right: 8, top: 1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withOpacity(0.6),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${item['name']}  •  ${item['calories']?.toInt() ?? 0} kcal',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (supplements.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.medication_rounded,
                        color: Colors.white38,
                        size: 13,
                      ),
                      Gap(6),
                      Text(
                        'SUPPLEMENTS',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  ...supplements.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '• ${s['name']}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else if (type == 'task') {
      final List tasks = data['tasks'] ?? [];
      if (tasks.isEmpty) {
        return _emptyState('No tasks in this list');
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: tasks.asMap().entries.map((entry) {
          final i = entry.key;
          final t = entry.value;
          final sentiment = (t['sentiment'] as num?)?.toDouble() ?? 0.0;
          final dotColor = sentiment > 0.3
              ? Colors.tealAccent
              : sentiment < -0.3
              ? Colors.redAccent
              : Colors.grey;

          return Container(
            margin: EdgeInsets.only(bottom: i < tasks.length - 1 ? 6 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.07),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: color.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    t['name'] ?? 'Task',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                if (t['isNote'] == true)
                  Icon(
                    Icons.sticky_note_2_outlined,
                    color: Colors.white24,
                    size: 14,
                  ),
              ],
            ),
          );
        }).toList(),
      );
    } else if (type == 'sleep') {
      final score = ((data['score'] as num?)?.toDouble() ?? 0.0) * 100;
      final scoreColor = score >= 80
          ? Colors.greenAccent
          : score >= 60
          ? Colors.orangeAccent
          : Colors.redAccent;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.bedtime_rounded, color: color, size: 28),
                const Gap(14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SLEEP SCORE',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${score.toInt()}%',
                      style: TextStyle(
                        color: scoreColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${data['eventCount'] ?? 0} events',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return _emptyState('No content data available');
  }

  Widget _statBadge(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 10),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white24, fontSize: 12),
        ),
      ),
    );
  }
}

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  final TextEditingController _friendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF121212),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.cyanAccent.withOpacity(0.1)),
      ),
      title: const Text(
        'ADD NEW CONTACT',
        style: TextStyle(
          color: Colors.cyanAccent,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          letterSpacing: 2,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _friendController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search by ID or Username...",
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 12),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.cyanAccent,
                size: 20,
              ),
            ),
          ),
          const Gap(24),
          const Text(
            'OR SHARE INVITE LINK',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(Icons.message, 'SMS', Colors.greenAccent),
              _buildSocialIcon(Icons.share, 'Snapchat', Colors.yellowAccent),
              _buildSocialIcon(
                Icons.camera_alt,
                'Instagram',
                Colors.pinkAccent,
              ),
              _buildSocialIcon(Icons.facebook, 'Facebook', Colors.blueAccent),
            ],
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Share.share(
                  'Hey! Join me on Muvio to track our workouts and chat! Download here: https://muvio.app/invite/user123',
                );
              },
              icon: const Icon(Icons.link, size: 18),
              label: const Text(
                'COPY INVITE LINK',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.cyanAccent,
                side: BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL', style: TextStyle(color: Colors.white38)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_friendController.text.isNotEmpty) {
              context.read<SocialCubit>().addFriend(_friendController.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Request sent to ${_friendController.text}"),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'ADD FRIEND',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        Share.share('Join me on Muvio! https://muvio.app/invite/user123');
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 18),
          ),
          const Gap(4),
          Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
