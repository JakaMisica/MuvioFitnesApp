import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:biofit_pro/logic/cubit/evolution/evolution_cubit.dart';
import 'package:biofit_pro/locator.dart';

class RewardAnimationOverlay extends StatefulWidget {
  final Widget child;

  const RewardAnimationOverlay({super.key, required this.child});

  @override
  State<RewardAnimationOverlay> createState() => _RewardAnimationOverlayState();
}

class _RewardAnimationOverlayState extends State<RewardAnimationOverlay> {
  final List<_ActiveReward> _rewards = [];
  late final StreamSubscription<RewardEvent> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = locator<EvolutionCubit>().rewardStream.listen(_handleReward);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _handleReward(RewardEvent event) {
    if (!mounted) return;

    setState(() {
      _rewards.add(_ActiveReward(
        id: DateTime.now().millisecondsSinceEpoch,
        type: event.type,
        amount: event.amount,
        // Start from top-right area (near the bars)
        x: MediaQuery.of(context).size.width - 120 + (Random().nextDouble() * 40),
        y: 80 + (Random().nextDouble() * 20),
      ));
    });
  }

  void _removeReward(int id) {
    if (!mounted) return;
    setState(() {
      _rewards.removeWhere((r) => r.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ..._rewards.map((reward) => _RewardItem(
              key: ValueKey(reward.id),
              reward: reward,
              onComplete: () => _removeReward(reward.id),
            )),
      ],
    );
  }
}

class _ActiveReward {
  final int id;
  final RewardType type;
  final int amount;
  final double x;
  final double y;

  _ActiveReward({
    required this.id,
    required this.type,
    required this.amount,
    required this.x,
    required this.y,
  });
}

class _RewardItem extends StatelessWidget {
  final _ActiveReward reward;
  final VoidCallback onComplete;

  const _RewardItem({
    required Key key,
    required this.reward,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMuscle = reward.type == RewardType.muscle;
    final isSocial = reward.type == RewardType.sunglasses;
    final emoji = isSocial ? "🕶️" : (isMuscle ? "💪" : "🪙");
    final text = '+${reward.amount} $emoji';
    final color = isSocial ? Colors.cyanAccent : (isMuscle ? Colors.orangeAccent : Colors.yellowAccent);

    return Positioned(
      left: reward.x,
      top: reward.y,
      child: DefaultTextStyle(
        style: TextStyle(
          color: color,
          fontSize: 24,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.8),
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Text(text)
            .animate(onComplete: (_) => onComplete())
            .fadeIn(duration: 200.ms)
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.2, 1.2),
              duration: 300.ms,
              curve: Curves.elasticOut,
            )
            .then()
            .moveY(begin: 0, end: -80, duration: 1200.ms, curve: Curves.easeOut)
            .fadeOut(begin: 1.0, duration: 800.ms, delay: 400.ms),
      ),
    );
  }
}
