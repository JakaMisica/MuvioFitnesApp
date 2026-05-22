import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../logic/cubit/ai/ai_cubit.dart';
import '../../../../data/repositories/body_repository.dart';
import '../../../../locator.dart';

/// Shows as a scrollable bottom sheet. Call via:
///   showModalBottomSheet(context: context, isScrollControlled: true,
///     builder: (_) => BlocProvider.value(value: cubit, child: const AiPaywallDialog()))
class AiPaywallDialog extends StatefulWidget {
  const AiPaywallDialog({super.key});

  @override
  State<AiPaywallDialog> createState() => _AiPaywallDialogState();
}

class _AiPaywallDialogState extends State<AiPaywallDialog> {
  bool _isLoadingPurchase = false;

  Future<String> _getReferralLink() async {
    final settings = await locator<BodyRepository>().getUserSettings();
    final code = 'muvio_${settings.id}_ref';
    return 'https://muvio.app/invite?ref=$code';
  }

  Future<void> _shareReferral() async {
    final link = await _getReferralLink();
    await Share.share(
      '🏋️ I\'m using Muvio to optimize my fitness!\n\n'
      'Download it with my link and we both get FREE AI messages:\n$link',
      subject: 'Join Muvio!',
    );
  }

  Future<void> _startPurchase() async {
    setState(() => _isLoadingPurchase = true);
    try {
      // TODO: Integrate `in_app_purchase` for real billing.
      // On Android: triggers Google Play billing flow.
      // On iOS: triggers App Store (StoreKit) billing flow.
      // For now this simulates success for development.
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        await context.read<AiCubit>().activatePremium();
        if (mounted) Navigator.of(context).pop();
      }
    } finally {
      if (mounted) setState(() => _isLoadingPurchase = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0E0E0E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      // DraggableScrollableSheet-like: fills up to 90% of screen height
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 8, 20, bottomPadding + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildCounter(),
                  const SizedBox(height: 20),
                  _buildPremiumCard(),
                  const SizedBox(height: 16),
                  _buildOrDivider(),
                  const SizedBox(height: 16),
                  _buildReferralCard(),
                  const SizedBox(height: 12),
                  _buildDismissButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.cyanAccent.withOpacity(0.08),
            border: Border.all(
              color: Colors.cyanAccent.withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.auto_awesome,
            color: Colors.cyanAccent,
            size: 28,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'AI QUOTA REACHED',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'You\'ve used all your free AI messages.\nUpgrade or invite a friend to get more.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCounter() {
    return BlocBuilder<AiCubit, AiState>(
      builder: (context, state) {
        final total = state.totalFreeAiMessages.clamp(0, 9999);
        final used = state.usedAiMessages.clamp(0, total);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.psychology_outlined,
                color: Colors.cyanAccent,
                size: 15,
              ),
              const SizedBox(width: 8),
              Text(
                'Messages used: $used / $total',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPremiumCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.cyanAccent.withOpacity(0.10),
            Colors.blueAccent.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.25)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'PREMIUM',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '\$10',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: ' /mo',
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildFeature(Icons.all_inclusive, '500 AI msgs / month'),
          const SizedBox(height: 6),
          _buildFeature(Icons.bolt_rounded, 'Priority response speed'),
          const SizedBox(height: 6),
          _buildFeature(Icons.biotech_outlined, 'Advanced bio-data analysis'),
          const SizedBox(height: 6),
          _buildFeature(Icons.verified_outlined, 'Supports app development'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoadingPurchase ? null : _startPurchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                disabledBackgroundColor: Colors.white12,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoadingPurchase
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      'SUBSCRIBE — GOOGLE PLAY / APP STORE',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 0.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Billed via Google Play or Apple App Store. Cancel anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.2),
                fontSize: 9,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 15),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withOpacity(0.07))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR GET FREE MESSAGES',
            style: TextStyle(
              color: Colors.white.withOpacity(0.25),
              fontSize: 8,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.white.withOpacity(0.07))),
      ],
    );
  }

  Widget _buildReferralCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purpleAccent.withOpacity(0.25),
                  ),
                ),
                child: const Icon(
                  Icons.people_alt_outlined,
                  color: Colors.purpleAccent,
                  size: 17,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invite a Friend',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '+5 free AI messages per install',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.35),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purpleAccent.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.purpleAccent.withOpacity(0.12)),
            ),
            child: Text(
              '🔗 Your friend downloads Muvio via your link. When they complete sign-up, you automatically receive 5 more free AI messages.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _shareReferral,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.purpleAccent,
                side: BorderSide(color: Colors.purpleAccent.withOpacity(0.35)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.share_outlined, size: 15),
              label: const Text(
                'SHARE MY REFERRAL LINK',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          context.read<AiCubit>().dismissPaywall();
          Navigator.of(context).pop();
        },
        child: Text(
          'Maybe later',
          style: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 12),
        ),
      ),
    );
  }
}
