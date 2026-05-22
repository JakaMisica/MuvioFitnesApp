import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../logic/cubit/ai/ai_cubit.dart';
import '../../../core/services/tutorial_service.dart';
import '../../../logic/cubit/workout/workout_cubit.dart';
import '../../../logic/cubit/diet/diet_cubit.dart';
import '../../../data/models/enums.dart';
import '../../../core/services/voice_coach_service.dart';
import '../../../core/services/coach_call_service.dart';
import '../../widgets/foggy_background.dart';
import 'dart:convert';
import 'widgets/ai_paywall_dialog.dart';

class AiRecommendationsScreen extends StatelessWidget {
  const AiRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AiView();
  }
}

class _AiView extends StatefulWidget {
  const _AiView();

  @override
  State<_AiView> createState() => _AiViewState();
}

class _AiViewState extends State<_AiView> with AutomaticKeepAliveClientMixin {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final Set<String> _addedExerciseKeys = {};
  final Set<String> _savedDietKeys = {};
  bool _isDictating = false;

  @override
  bool get wantKeepAlive => true;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _toggleDictation() async {
    if (_isDictating) {
      // Stop and Transcribe
      setState(() => _isDictating = false);
      final path = await VoiceCoachService().stopVoiceCapture();
      if (path != null) {
        setState(() => _controller.text = "Transcribing...");
        final text = await VoiceCoachService().transcribeLocal(path);
        setState(() => _controller.text = text);
      }
    } else {
      // Start Recording
      final success = await VoiceCoachService().startVoiceCapture();
      if (success) {
        setState(() {
          _isDictating = true;
          _controller.text = "Hearing your input...";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: SafeArea(
          key: TutorialService().getKeyForStep(TutorialStep.coachWait),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: BlocConsumer<AiCubit, AiState>(
                  listener: (context, state) {
                    if (state.messages.isNotEmpty &&
                        state.messages.last['role'] == 'user') {
                      _scrollToBottom();
                    }
                    if (state.showPaywall) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        isDismissible: false,
                        builder: (_) => BlocProvider.value(
                          value: context.read<AiCubit>(),
                          child: const AiPaywallDialog(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.messages.isEmpty &&
                        state.mode == AiMode.general) {
                      return _buildEmptyState();
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount:
                          state.messages.length + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.messages.length) {
                          return _buildLoadingIndicator();
                        }
                        final msg = state.messages[index];
                        return _buildChatBubble(msg);
                      },
                    );
                  },
                ),
              ),
              if (context.watch<AiCubit>().state.error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.redAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      context.watch<AiCubit>().state.error!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              _buildInputArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 16, 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: [
          // Left: Identity & Neural Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'NEURAL LINK',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildConnectionPulse(),
                  ],
                ),
                const SizedBox(height: 6),
                BlocBuilder<AiCubit, AiState>(
                  builder: (context, state) {
                    final coachName = state.activeCoachName?.toUpperCase() ?? "BIOLOGICAL OPTIMIZATION ENGINE";
                    return Text(
                      coachName,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // NEURAL CALL BUTTON - More Prominent
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyanAccent.withOpacity(0.15), Colors.blueAccent.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
            ),
            child: IconButton(
              onPressed: () => CoachCallService().triggerManualCall(),
              icon: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_calling_3_rounded, color: Colors.cyanAccent, size: 20),
                  SizedBox(height: 1),
                  Text('CALL', style: TextStyle(color: Colors.cyanAccent, fontSize: 7, fontWeight: FontWeight.w900)),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              tooltip: 'Initialize Neural Voice Link',
            ),
          ),
          
          const SizedBox(width: 8),
          
          IconButton(
            onPressed: () => _showHistoryDialog(context),
            icon: const Icon(Icons.history_rounded, color: Colors.white24, size: 20),
            tooltip: 'Archives',
          ),
          IconButton(
            onPressed: () {
              context.read<AiCubit>().clearChat();
              if (mounted) {
                setState(() {
                  _addedExerciseKeys.clear();
                  _savedDietKeys.clear();
                });
              }
            },
            icon: const Icon(Icons.add_comment_outlined, color: Colors.white24, size: 20),
            tooltip: 'Synchronize New Protocol',
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionPulse() {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.greenAccent, blurRadius: 4, spreadRadius: 1),
        ],
      ),
    );
  }


  void _showHistoryDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (btmContext) {
        return BlocBuilder<AiCubit, AiState>(
          bloc: context.read<AiCubit>(),
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HYPER-HISTORY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'Stored biological advisory logs',
                    style: TextStyle(color: Colors.white24, fontSize: 10),
                  ),
                  const Gap(20),
                  if (state.sessions.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          "No archived logs",
                          style: TextStyle(color: Colors.white12, fontSize: 12),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.sessions.length,
                        separatorBuilder: (_, __) => const Gap(10),
                        itemBuilder: (context, index) {
                          final session = state.sessions[index];
                          final isCurrent = session.id == state.activeSessionId;
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                context.read<AiCubit>().switchToSession(
                                  session.id,
                                );
                                Navigator.pop(btmContext);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isCurrent
                                        ? Colors.cyanAccent.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.05),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      session.mode == AiMode.diet
                                          ? Icons.restaurant_rounded
                                          : session.mode == AiMode.workout
                                          ? Icons.fitness_center_rounded
                                          : Icons.psychology_rounded,
                                      color: isCurrent
                                          ? Colors.cyanAccent
                                          : Colors.white24,
                                      size: 20,
                                    ),
                                    const Gap(16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            session.title ?? "Unnamed Protocol",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isCurrent
                                                  ? Colors.white
                                                  : Colors.white60,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              height: 1.2,
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            "${session.lastMessageTime.month}/${session.lastMessageTime.day} ${session.lastMessageTime.hour.toString().padLeft(2, '0')}:${session.lastMessageTime.minute.toString().padLeft(2, '0')}",
                                            style: TextStyle(
                                              color: isCurrent
                                                  ? Colors.cyanAccent
                                                        .withOpacity(0.5)
                                                  : Colors.white10,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => context
                                          .read<AiCubit>()
                                          .deleteSession(session.id),
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.white12,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const Gap(24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.05),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.1)),
              ),
              child: const Icon(
                Icons.psychology_outlined,
                size: 64,
                color: Colors.cyanAccent,
              ),
            ),
            const Gap(24),
            const Text(
              "NEURAL ADVISOR ACTIVE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const Gap(12),
            Text(
              "I have access to your performance metrics. Ask me to analyze your trends or design a recovery protocol.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(Map<String, String> msg) {
    final isUser = msg['role'] == 'user';
    final content = msg['content'] ?? '';

    final exerciseRegex = RegExp(r'<exercise>(.*?)</exercise>', dotAll: true);
    final dietRegex = RegExp(r'<diet>(.*?)</diet>', dotAll: true);

    final exercises = exerciseRegex
        .allMatches(content)
        .map((m) => m.group(1)!.trim())
        .toList();
    final diets = dietRegex
        .allMatches(content)
        .map((m) => m.group(1)!.trim())
        .toList();

    String cleanText = content
        .replaceAll(exerciseRegex, '')
        .replaceAll(dietRegex, '')
        .trim();

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (cleanText.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.85,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? Colors.cyanAccent.withOpacity(0.1)
                    : Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                border: Border.all(
                  color: isUser
                      ? Colors.cyanAccent.withOpacity(0.2)
                      : Colors.white.withOpacity(0.05),
                ),
              ),
              child: Text(
                cleanText,
                style: TextStyle(
                  color: isUser
                      ? Colors.cyanAccent
                      : Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          for (final json in exercises) _buildExerciseRecommendationCard(json),
          for (final json in diets) _buildDietRecommendationCard(json),
        ],
      ),
    );
  }

  // Recommendation cards remain the same as before
  Widget _buildExerciseRecommendationCard(String jsonStr) {
    try {
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      final name = data['name'] ?? 'Exercise';
      final sets = data['sets'] ?? 3;
      final reps = data['reps'] ?? 10;
      final weight = data['weight'] ?? 0.0;
      final mg = (data['muscleGroup'] ?? 'chest').toString().toUpperCase();

      final String cardKey =
          'ex_${data['name']}_${data['sets']}_${data['reps']}_${data['weight']}';
      final bool isAdded = _addedExerciseKeys.contains(cardKey);

      return Container(
        width: 280,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.cyanAccent.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isAdded
                ? Colors.greenAccent.withOpacity(0.5)
                : Colors.cyanAccent.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: isAdded
                  ? Colors.greenAccent.withOpacity(0.05)
                  : Colors.cyanAccent.withOpacity(0.05),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  color: isAdded ? Colors.greenAccent : Colors.cyanAccent,
                  size: 16,
                ),
                const Gap(8),
                Text(
                  mg,
                  style: TextStyle(
                    color: isAdded ? Colors.greenAccent : Colors.cyanAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                if (isAdded) ...[
                  const Spacer(),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 18,
                  ),
                ],
              ],
            ),
            const Gap(12),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Gap(16),
            Row(
              children: [
                _buildMetricSmall('SETS', '$sets'),
                const Gap(24),
                _buildMetricSmall('REPS', '$reps'),
                const Gap(24),
                _buildMetricSmall('WEIGHT', '${weight}kg'),
              ],
            ),
            const Gap(20),
            SizedBox(
              width: double.infinity,
              child: isAdded
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.3),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'ADDED TO WORKOUT',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.read<WorkoutCubit>().addRecommendedExercise(
                          data,
                        );
                        setState(() {
                          _addedExerciseKeys.add(cardKey);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$name added to today\'s workout'),
                            backgroundColor: Colors.cyanAccent.withOpacity(0.8),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'ADD TO WORKOUT',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  Widget _buildDietRecommendationCard(String jsonStr) {
    try {
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      final name = data['name'] ?? 'Plan';
      final meals = data['meals'] as List? ?? [];
      double totalCals = 0;
      double totalProtein = 0;
      for (var m in meals) {
        final items = m['items'] as List? ?? [];
        for (var i in items) {
          totalCals += (i['calories'] as num?)?.toDouble() ?? 0;
          totalProtein += (i['protein'] as num?)?.toDouble() ?? 0;
        }
      }
      final String cardKey = 'diet_${data['name']}_${meals.length}_$totalCals';
      final bool isSaved = _savedDietKeys.contains(cardKey);
      return Container(
        width: 280,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSaved
                ? Colors.greenAccent.withOpacity(0.5)
                : Colors.orangeAccent.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: isSaved
                  ? Colors.greenAccent.withOpacity(0.05)
                  : Colors.orangeAccent.withOpacity(0.05),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: isSaved ? Colors.greenAccent : Colors.orangeAccent,
                  size: 16,
                ),
                const Gap(8),
                Text(
                  'NUTRITION PROTOCOL',
                  style: TextStyle(
                    color: isSaved ? Colors.greenAccent : Colors.orangeAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                if (isSaved) ...[
                  const Spacer(),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 18,
                  ),
                ],
              ],
            ),
            const Gap(12),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Gap(16),
            Row(
              children: [
                _buildMetricSmall('MEALS', '${meals.length}'),
                const Gap(24),
                _buildMetricSmall('CALORIES', '${totalCals.toInt()}'),
                const Gap(24),
                _buildMetricSmall('PROTEIN', '${totalProtein.toInt()}g'),
              ],
            ),
            const Gap(20),
            SizedBox(
              width: double.infinity,
              child: isSaved
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.3),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'SAVED TO TEMPLATES',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.read<DietCubit>().addDietTemplateFromAI(data);
                        setState(() {
                          _savedDietKeys.add(cardKey);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$name saved to templates'),
                            backgroundColor: Colors.orangeAccent.withOpacity(
                              0.8,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'SAVE AS TEMPLATE',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  Widget _buildMetricSmall(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white24,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.cyanAccent,
              ),
            ),
            const Gap(12),
            Text(
              "Analyzing biology...",
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final state = context.watch<AiCubit>().state;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding > 0 ? bottomPadding + 8 : 24),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.messages.isEmpty && state.mode == AiMode.general) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  _buildModeButton(
                    context,
                    'CREATE DIET',
                    Icons.restaurant_menu,
                    Colors.orangeAccent,
                    () {
                      context.read<AiCubit>().setMode(AiMode.diet);
                      context.read<AiCubit>().addBotMessage(
                        "NUTRITION ENGINE INITIALIZED. 🍎\nWhat are you looking for?\n• Specific foods?\n• Meal frequency?",
                      );
                    },
                  ),
                  const Gap(10),
                  _buildModeButton(
                    context,
                    'GENERATE WORKOUT',
                    Icons.fitness_center,
                    Colors.cyanAccent,
                    () {
                      context.read<AiCubit>().setMode(AiMode.workout);
                      context.read<AiCubit>().addBotMessage(
                        "TRAINING ARCHITECT READY. 🦾\nWhat is the target today?\n• Specific muscle groups?\n• Equipment?",
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: state.mode == AiMode.diet
                    ? Colors.orangeAccent.withOpacity(0.2)
                    : state.mode == AiMode.workout
                    ? Colors.cyanAccent.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
              ),
            ),
            child: TextField(
              controller: _controller,
              maxLines: 4,
              minLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: "Coach my performance...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.15)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  context.read<AiCubit>().sendMessage(val);
                  _controller.clear();
                }
              },
            ),
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionButton(
                context,
                'BIO CONTEXT',
                Icons.analytics_outlined,
                Colors.purpleAccent,
                () => context.read<AiCubit>().toggleBioData(!state.useBioData),
                isActive: state.useBioData,
              ),
              const Gap(12),
              _buildActionButton(
                context,
                'REASONING',
                Icons.psychology_outlined,
                Colors.cyanAccent,
                () => context.read<AiCubit>().toggleCoT(!state.useCoT),
                isActive: state.useCoT,
              ),
              const Spacer(),
              // VOICE DICTATION BUTTON next to SEND
              GestureDetector(
                onTap: _toggleDictation,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isDictating 
                        ? Colors.redAccent.withOpacity(0.2) 
                        : Colors.white.withOpacity(0.05),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isDictating ? Colors.redAccent : Colors.white10,
                    ),
                  ),
                  child: Icon(
                    _isDictating ? Icons.stop_rounded : Icons.mic_rounded,
                    color: _isDictating ? Colors.redAccent : Colors.white60,
                    size: 20,
                  ),
                ),
              ),
              const Gap(10),
              // SEND BUTTON
              GestureDetector(
                onTap: state.isLoading
                    ? null
                    : () {
                        if (_controller.text.isNotEmpty) {
                          context.read<AiCubit>().sendMessage(
                            _controller.text,
                          );
                          _controller.clear();
                        }
                      },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: state.isLoading
                        ? Colors.white10
                        : (state.mode == AiMode.diet
                              ? Colors.orangeAccent
                              : Colors.cyanAccent),
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (!state.isLoading)
                        BoxShadow(
                          color: (state.mode == AiMode.diet
                                  ? Colors.orangeAccent
                                  : Colors.cyanAccent)
                              .withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                    ],
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.2) : color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? color : color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isActive ? Colors.white : color),
            const Gap(6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : color,
                fontSize: 8,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const Gap(8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
