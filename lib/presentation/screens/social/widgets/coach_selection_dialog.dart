import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../logic/cubit/coach/coach_cubit.dart';
import '../../../../data/models/coach_model.dart';

class CoachSelectionDialog extends StatelessWidget {
  const CoachSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 500),
        child: const CoachSelectionView(isDialog: true),
      ),
    );
  }
}

class CoachSelectionView extends StatelessWidget {
  final bool isDialog;
  const CoachSelectionView({super.key, this.isDialog = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachCubit, CoachState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Icon(Icons.psychology, color: Colors.cyanAccent, size: 32),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'AVAILABLE AI COACHES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  if (isDialog)
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54),
                      onPressed: () => Navigator.pop(context),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.coaches.length,
                itemBuilder: (context, index) {
                  final coach = state.coaches[index];
                  final isActive = state.activeCoachId == coach.id;
                  final coachCubit = context.read<CoachCubit>();

                  return _CoachCard(
                    coach: coach,
                    isActive: isActive,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (detailCtx) => CoachDetailDialog(
                          coach: coach,
                          isActive: isActive,
                          onHire: () {
                            coachCubit.hireCoach(coach.id);
                            Navigator.pop(detailCtx);
                            if (isDialog) Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  COACH DETAIL DIALOG
// ─────────────────────────────────────────────────────────────
class CoachDetailDialog extends StatelessWidget {
  final CoachModel coach;
  final bool isActive;
  final VoidCallback onHire;

  const CoachDetailDialog({
    super.key,
    required this.coach,
    required this.isActive,
    required this.onHire,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = coach.isPremium ? Colors.amber : Colors.cyanAccent;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: accent.withOpacity(0.25), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.12),
              blurRadius: 40,
              spreadRadius: 4,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header gradient with avatar
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [accent.withOpacity(0.22), Colors.transparent],
                      ),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: accent, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: accent.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 52,
                            backgroundColor: Colors.grey[900],
                            child: Text(
                              coach.parodyName.substring(0, 1),
                              style: TextStyle(
                                color: accent,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (coach.isPremium)
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Text(
                                'AI',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              // Body
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        coach.parodyName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: accent.withOpacity(0.3)),
                        ),
                        child: Text(
                          coach.isPremium ? 'PREMIUM AI COACH' : 'FREE MOTIVATOR',
                          style: TextStyle(
                            color: accent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(children: [
                      const Text('PROFILE',
                          style: TextStyle(
                              color: Colors.white24,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3)),
                      const SizedBox(width: 12),
                      const Expanded(
                          child: Divider(color: Colors.white12, thickness: 1)),
                    ]),
                    const SizedBox(height: 14),
                    // Full description (no limit)
                    Text(
                      coach.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _trait(Icons.bolt, 'Energy',
                        coach.isLazyCoach ? 'Low / Rude' : 'Maximum Intensity',
                        accent),
                    const SizedBox(height: 8),
                    _trait(Icons.psychology_outlined, 'Style',
                        _style(coach), accent),
                    if (coach.isPremium) ...[
                      const SizedBox(height: 8),
                      _trait(Icons.smart_toy_outlined, 'AI Model',
                          'Powered by GPT-4o', accent),
                    ],
                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: isActive ? null : onHire,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isActive ? Colors.grey[800] : accent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: isActive ? 0 : 12,
                          shadowColor: accent.withOpacity(0.5),
                        ),
                        child: Text(
                          isActive
                              ? '✓  CURRENTLY ACTIVE'
                              : coach.isPremium
                                  ? 'HIRE FOR \$${coach.price.toStringAsFixed(2)} / mo'
                                  : 'RECRUIT COACH — FREE',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _style(CoachModel c) {
    if (c.isLazyCoach) return 'Demotivator';
    if (c.parodyName.contains('Arnold')) return 'Philosophical & Intense';
    if (c.parodyName.contains('Greg')) return 'Screaming & Metabolic';
    if (c.parodyName.contains('Mike')) return 'Scientific & Insulting';
    if (c.parodyName.contains('Ronie')) return 'Pure Power & Volume';
    if (c.parodyName.contains('JJ')) return 'Influencer & Aesthetic';
    return 'Relatable & Funny';
  }

  Widget _trait(IconData icon, String label, String value, Color accent) {
    return Row(children: [
      Icon(icon, size: 16, color: accent.withOpacity(0.6)),
      const SizedBox(width: 8),
      Text('$label: ',
          style: const TextStyle(color: Colors.white38, fontSize: 13)),
      Expanded(
        child: Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────
//  COACH CARD (list item)
// ─────────────────────────────────────────────────────────────
class _CoachCard extends StatelessWidget {
  final CoachModel coach;
  final bool isActive;
  final VoidCallback onTap;

  const _CoachCard({
    required this.coach,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.cyanAccent.withOpacity(0.1)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.cyanAccent : Colors.white10,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avatar with AI badge
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[900],
                      child: Text(
                        coach.parodyName.substring(0, 1),
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (coach.isPremium)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: const Text(
                            'AI',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                // Name & description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coach.parodyName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        softWrap: true,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coach.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Price + chevron
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isActive)
                      const Icon(Icons.check_circle, color: Colors.cyanAccent)
                    else
                      Text(
                        coach.isPremium
                            ? '\$${coach.price.toStringAsFixed(2)}'
                            : 'FREE',
                        style: TextStyle(
                          color: coach.isPremium
                              ? Colors.amber
                              : Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    const SizedBox(height: 4),
                    const Icon(Icons.chevron_right_rounded,
                        color: Colors.white24, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
