import 'package:biofit_pro/locator.dart';
import 'package:biofit_pro/data/repositories/body_repository.dart';
import 'package:biofit_pro/logic/cubit/evolution/evolution_cubit.dart';
import 'package:biofit_pro/logic/cubit/evolution/evolution_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/evolution_boxes.dart';
import 'widgets/gains_chart_dialog.dart';
import 'widgets/grip_chart_dialog.dart';
import 'widgets/body_fat_history_dialog.dart';
import 'widgets/weight_history_dialog.dart';
import 'widgets/testo_chart_dialog.dart';
import 'widgets/profile_dialog.dart';
import 'widgets/measurements_dialog.dart';
import 'widgets/body_metrics_history_dialog.dart';
import 'widgets/volume_chart_dialog.dart';
import 'widgets/muscle_fatigue_hud.dart';
import 'widgets/status_tracking_bar.dart';
import 'package:biofit_pro/logic/cubit/auth/auth_cubit.dart';
import 'package:biofit_pro/logic/cubit/auth/auth_state.dart';
import '../../widgets/foggy_background.dart';
import '../../../core/services/coach_call_service.dart';
import '../../../core/services/tutorial_service.dart';
import '../../widgets/reward_animation_overlay.dart';
import '../../widgets/tutorial_overlay.dart';
import 'package:intl/intl.dart';

class MainWindowScreen extends StatefulWidget {
  const MainWindowScreen({super.key});

  @override
  State<MainWindowScreen> createState() => _MainWindowScreenState();
}

class _MainWindowScreenState extends State<MainWindowScreen> {
  final GlobalKey _pointsKey = GlobalKey();
  final GlobalKey _measurementsKey = GlobalKey();
  final GlobalKey _gainsKey = GlobalKey();
  final GlobalKey _expandKey = GlobalKey();
  final GlobalKey _gainsBoxKey = GlobalKey();
  final GlobalKey _weightBoxKey = GlobalKey();
  final GlobalKey _fatBoxKey = GlobalKey();
  final GlobalKey _gripBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final service = TutorialService();
      service.registerKey(TutorialStep.rewardMetrics, _pointsKey);
      service.registerKey(TutorialStep.measurements, _measurementsKey);
      service.registerKey(TutorialStep.gainsAnalytics, _gainsKey);
      service.registerKey(TutorialStep.expandMetrics, _expandKey);
      service.registerKey(TutorialStep.gainsBox, _gainsBoxKey);
      service.registerKey(TutorialStep.weightBox, _weightBoxKey);
      service.registerKey(TutorialStep.bodyFatBox, _fatBoxKey);
      service.registerKey(TutorialStep.gripBox, _gripBoxKey);
    });
  }

  void _handleTutorialStep(TutorialStep step) {
    if (TutorialService().currentStep == step) {
      TutorialService().next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        body: FoggyBackground(
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<EvolutionCubit, EvolutionState>(
                    builder: (context, state) {
                      final isComplete = state.settings?.isProfileComplete ?? false;

                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.03),
                              ),
                            ),
                            child: Stack(
                              children: [
                                // ── Fatigue Progress HUD ──────────────────────
                                Positioned.fill(
                                  top: 100,
                                  bottom: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: MuscleGainsHUD(evolutionState: state),
                                  ),
                                ),
                                // --- SMART ADAPTIVE TOP BAR ---
                                Positioned(
                                  top: 17,
                                  left: 0,
                                  right: 0,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final w = MediaQuery.of(context).size.width;
                                      // Scale factor: 1.0 at 390px, smaller below
                                      final scale = (w / 390).clamp(0.7, 1.0);
                                      final iconSize = (20 * scale).roundToDouble();
                                      final gap = (4 * scale).roundToDouble();
                                      final txtSize = (11 * scale).roundToDouble();
                                      final emojiSize = (13 * scale).roundToDouble();
                                      final narrow = w < 360;

                                      Widget rewardGroup = narrow
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _buildRewardLabel(icon: "💪", value: state.settings?.musclePoints ?? 0, color: Colors.orangeAccent, emojiSize: emojiSize, txtSize: txtSize),
                                              SizedBox(height: gap / 2),
                                              _buildRewardLabel(icon: "🪙", value: state.settings?.coins ?? 0, color: Colors.yellowAccent, emojiSize: emojiSize, txtSize: txtSize),
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _buildRewardLabel(icon: "💪", value: state.settings?.musclePoints ?? 0, color: Colors.orangeAccent, emojiSize: emojiSize * 1.5, txtSize: txtSize * 1.5),
                                              SizedBox(width: gap),
                                              _buildRewardLabel(icon: "🪙", value: state.settings?.coins ?? 0, color: Colors.yellowAccent, emojiSize: emojiSize * 1.5, txtSize: txtSize * 1.5),
                                            ],
                                          );

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            GestureDetector(
                                              key: _pointsKey,
                                              onTap: () => _showGainsChart(context),
                                              child: rewardGroup,
                                            ),
                                            SizedBox(width: gap),
                                            PopupMenuButton<String>(
                                              icon: Icon(Icons.settings, color: Colors.white70, size: (iconSize + 8).roundToDouble()),
                                              offset: const Offset(0, 40),
                                              color: const Color(0xFF1A1A1A),
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14),
                                                side: const BorderSide(color: Colors.white10),
                                              ),
                                              onSelected: (value) {
                                                if (value == 'profile') {
                                                  _showProfileDialog(context);
                                                } else if (value == 'coach') {
                                                  CoachCallService().triggerTestCall();
                                                } else if (value == 'auth') {
                                                  final authState = context.read<AuthCubit>().state;
                                                  _showLoginLogoutDialog(context, authState is AuthSuccess);
                                                } else if (value == 'tutorial') {
                                                  TutorialService().start();
                                                }
                                              },
                                              itemBuilder: (ctx) => [
                                                PopupMenuItem(
                                                  value: 'profile',
                                                  child: Row(children: [
                                                    Icon(Icons.person_pin, color: isComplete ? Colors.blueAccent : Colors.orangeAccent, size: 18),
                                                    const SizedBox(width: 10),
                                                    const Text('BIO PROFILE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                                  ]),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'coach',
                                                  child: Row(children: [
                                                    Icon(Icons.support_agent, color: Colors.cyanAccent, size: 18),
                                                    SizedBox(width: 10),
                                                    Text('AI COACH', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                                  ]),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'tutorial',
                                                  child: Row(children: [
                                                    Icon(Icons.school, color: Colors.purpleAccent, size: 18),
                                                    SizedBox(width: 10),
                                                    Text('TEST TUTORIAL', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                                  ]),
                                                ),
                                                PopupMenuItem(
                                                  value: 'auth',
                                                  child: Builder(builder: (ctx) {
                                                    final isLoggedIn = ctx.read<AuthCubit>().state is AuthSuccess;
                                                    return Row(children: [
                                                      Icon(Icons.logout, color: isLoggedIn ? Colors.redAccent : Colors.greenAccent, size: 18),
                                                      const SizedBox(width: 10),
                                                      Text(isLoggedIn ? 'LOGOUT' : 'LOGIN', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                                    ]);
                                                  }),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: gap),
                                            _buildSystemButton(
                                              key: _measurementsKey,
                                              icon: Icons.straighten, color: Colors.cyanAccent, onTap: () => _showMeasurementsDialog(context), size: iconSize
                                            ),
                                            SizedBox(width: gap),
                                            SizedBox(
                                              key: _expandKey,
                                              width: 44,
                                              height: 44,
                                              child: _buildSystemButton(
                                                icon: state.showBottomMetrics ? Icons.unfold_less : Icons.unfold_more,
                                                color: Colors.white38,
                                                onTap: () {
                                                  context.read<EvolutionCubit>().toggleBottomMetrics();
                                                  _handleTutorialStep(TutorialStep.expandMetrics);
                                                },
                                                size: iconSize,
                                              ),
                                            ),
                                            SizedBox(width: gap),
                                            _buildSystemButton(
                                              key: _gainsKey,
                                              icon: Icons.bar_chart, color: Colors.orangeAccent, onTap: () => _showVolumeChart(context), size: iconSize
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                BlocBuilder<EvolutionCubit, EvolutionState>(
                  builder: (context, state) {
                    return EvolutionMonitoringSection(
                      state: state,
                      gainsKey: _gainsBoxKey,
                      weightKey: _weightBoxKey,
                      fatKey: _fatBoxKey,
                      gripKey: _gripBoxKey,
                      onGainsTap: () {
                        _showGainsChart(context);
                        _handleTutorialStep(TutorialStep.gainsBox);
                      },
                      onWeightTap: () {
                        _showWeightHistory(context);
                        _handleTutorialStep(TutorialStep.weightBox);
                      },
                      onFatTap: () {
                        _showBodyFatHistory(context);
                        _handleTutorialStep(TutorialStep.bodyFatBox);
                      },
                      onGripTap: () {
                        _showGripChart(context);
                        _handleTutorialStep(TutorialStep.gripBox);
                      },
                      onTestoTap: () => _showTestoChart(context),
                    );
                  },
                ),
                const StatusTrackingBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRewardBar({
    required String icon,
    required num value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required double size,
    Key? key,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        key: key,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }

  Widget _buildRewardLabel({
    required String icon,
    required num value,
    required Color color,
    double emojiSize = 13,
    double txtSize = 11,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: TextStyle(fontSize: emojiSize)),
        const SizedBox(width: 4),
        Text(
          value.toString(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: txtSize,
          ),
        ),
      ],
    );
  }

  Widget _buildLogMetricsButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showMeasurementsDialog(context),
      icon: const Icon(Icons.add_chart_rounded, color: Colors.cyanAccent, size: 22),
      style: IconButton.styleFrom(
        backgroundColor: Colors.cyanAccent.withOpacity(0.1),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildVolumeButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showVolumeChart(context),
      icon: const Icon(Icons.fitness_center_rounded, color: Colors.orangeAccent, size: 22),
      style: IconButton.styleFrom(
        backgroundColor: Colors.orangeAccent.withOpacity(0.1),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  void _showGainsChart(BuildContext context) {
    final cubit = context.read<EvolutionCubit>();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: GainsChartDialog(
          muscleGains: cubit.state.muscleGains,
          onTimeframeChange: (start, end) {
            cubit.loadChartHistory(
              start: start,
              end: end,
              muscleGroup: 'All',
              subGroup: 'All',
            );
          },
        ),
      ),
    );
  }

  void _showWeightHistory(BuildContext context) {
    showDialog(context: context, builder: (_) => const WeightHistoryDialog());
  }

  void _showBodyFatHistory(BuildContext context) {
    showDialog(context: context, builder: (_) => const BodyFatHistoryDialog());
  }

  void _showGripChart(BuildContext context) {
    showDialog(context: context, builder: (_) => const GripChartDialog());
  }

  void _showTestoChart(BuildContext context) {
    showDialog(context: context, builder: (_) => const TestoChartDialog());
  }

  void _showVolumeChart(BuildContext context) {
    final cubit = context.read<EvolutionCubit>();
    showDialog(
      context: context,
      builder: (_) => VolumeChartDialog(cubit: cubit),
    );
  }

  void _showProfileDialog(BuildContext context) {
    final state = context.read<EvolutionCubit>().state;
    showDialog(
      context: context,
      builder: (_) => ProfileDialog(
        initialIsMetric: state.isMetricMeasurements,
        initialGender: state.settings?.gender,
        initialAge: state.settings?.age,
        initialHeightCm: state.settings?.heightCm,
      ),
    );
  }

  void _showMeasurementsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const BodyMetricsHistoryDialog(initialField: 'waist'),
    );
  }

  void _showLoginLogoutDialog(BuildContext context, bool hasSession) {
    if (hasSession) {
      context.read<AuthCubit>().signOut();
    } else {
      // Logic for login navigation if needed
    }
  }
}

class EvolutionMonitoringSection extends StatelessWidget {
  final EvolutionState state;
  final VoidCallback onGainsTap;
  final VoidCallback onWeightTap;
  final VoidCallback onFatTap;
  final VoidCallback onGripTap;
  final VoidCallback onTestoTap;
  final GlobalKey? gainsKey;
  final GlobalKey? weightKey;
  final GlobalKey? fatKey;
  final GlobalKey? gripKey;

  const EvolutionMonitoringSection({
    super.key,
    required this.state,
    required this.onGainsTap,
    required this.onWeightTap,
    required this.onFatTap,
    required this.onGripTap,
    required this.onTestoTap,
    this.gainsKey,
    this.weightKey,
    this.fatKey,
    this.gripKey,
  });

  @override
  Widget build(BuildContext context) {
    double totalGainsGrams = 0;
    state.muscleGains.values.forEach((areaMap) {
      areaMap.values.forEach((gain) {
        totalGainsGrams += gain;
      });
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: EvolutionBox(
                  key: gainsKey,
                  value: totalGainsGrams.toStringAsFixed(1),
                  icon: Icons.auto_graph_rounded,
                  color: Colors.greenAccent,
                  onTap: onGainsTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: EvolutionBox(
                  key: weightKey,
                  value: (state.latestMetric?.weight ?? 0.0).toStringAsFixed(1),
                  icon: Icons.monitor_weight_outlined,
                  color: Colors.cyanAccent,
                  onTap: onWeightTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: EvolutionBox(
                  key: fatKey,
                  value: (state.latestMetric?.bodyFatPercentage ?? 0.0).toStringAsFixed(1),
                  icon: Icons.bloodtype_outlined,
                  color: Colors.greenAccent,
                  onTap: onFatTap,
                ),
              ),
            ],
          ),
          if (state.showBottomMetrics) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox.shrink()),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: EvolutionBox(
                    key: gripKey,
                    value: (((state.latestMetric?.gripStrengthLeft ?? 0.0) +
                                (state.latestMetric?.gripStrengthRight ?? 0.0)) /
                            2)
                        .toStringAsFixed(1),
                    icon: Icons.pan_tool_outlined,
                    color: Colors.cyanAccent,
                    onTap: onGripTap,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: EvolutionBox(
                    value: (state.latestMetric?.estimatedFreeTestosterone ?? 0.0).toStringAsFixed(1),
                    icon: Icons.bolt_rounded,
                    color: Colors.cyanAccent,
                    onTap: onTestoTap,
                  ),
                ),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: SizedBox.shrink()),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
