import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../logic/cubit/social/social_cubit.dart';
import 'dart:convert';
import 'dart:async';
import '../../../logic/cubit/sleep/sleep_cubit.dart';
import '../../../data/models/sleep_models.dart';
import '../../widgets/foggy_background.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/custom_time_picker.dart';
import 'widgets/auto_track_dialog.dart';
import 'sleep_trends_screen.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SleepView();
  }
}

class SleepView extends StatefulWidget {
  const SleepView({super.key});

  @override
  State<SleepView> createState() => _SleepViewState();
}

class _SleepViewState extends State<SleepView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  List<String> _builtInSounds = [];
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAlarms();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  Future<void> _loadAlarms() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assets = manifest.listAssets();

      final List<String> alarms = assets.where((String key) {
        final nk = key.toLowerCase();
        final isAlarm =
            nk.contains('alarms/') &&
            (nk.endsWith('.mp3') || nk.endsWith('.wav') || nk.endsWith('.ogg'));

        if (!isAlarm) return false;

        // Filter to only 1-5
        final filename = nk.split('/').last.toLowerCase();
        return filename.contains('alarm-1') ||
            filename.contains('alarm-2') ||
            filename.contains('alarm-3') ||
            filename.contains('alarm-4') ||
            filename.contains('alarm-5');
      }).toList();

      if (mounted) {
        setState(() {
          _builtInSounds = alarms;
        });
      }
    } catch (e) {
      debugPrint("SleepScreen: Error loading alarms: $e");
    }

    // Update UI every minute for the alarm countdown
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted)
        setState(() {});
      else
        timer.cancel();
    });
  }

  Future<void> _pickAlarmSound(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        if (!mounted) return;
        context.read<SleepCubit>().updateAlarmSound(result.files.single.path!);
      }
    } catch (e) {
      debugPrint("SleepScreen: Error picking alarm sound: $e");
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: SafeArea(
          child: BlocBuilder<SleepCubit, SleepState>(
            builder: (context, state) {
              final activeSession = state.isTracking
                  ? state.currentSession
                  : state.latestSession;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildHeader(state),
                    const Gap(24),
                    _buildQualityScore(activeSession),
                    const Gap(32),
                    _buildHypnogram(activeSession),
                    const Gap(32),
                    _buildActionButtons(context, state),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(SleepState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SLEEP QUALITY",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
            const Gap(4),
            Row(
              children: [
                if (state.isTracking)
                  FadeTransition(
                    opacity: _pulseController,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                const Gap(8),
                Text(
                  state.isTracking
                      ? "Monitoring: On-Device AI Active"
                      : (state.isAiReady ? "Analysis Ready" : "AI Loading..."),
                  style: TextStyle(
                    color: state.isAiReady
                        ? Colors.white.withOpacity(0.4)
                        : Colors.redAccent.withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (state.isTracking) ...[
                  const Gap(8),
                  Text(
                    "| Events: ${state.detectedEventsCount}",
                    style: TextStyle(
                      color: Colors.orangeAccent.withOpacity(0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<SleepCubit>(),
                  child: const SleepTrendsScreen(),
                ),
              ),
            );
          },
          icon: const Icon(Icons.show_chart_rounded, color: Colors.cyanAccent),
        ),
      ],
    );
  }

  Widget _buildQualityScore(SleepSession? session) {
    final score = session?.qualityScore ?? 0.0;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              value: (session != null && session.endTime == null)
                  ? null
                  : score,
              strokeWidth: 10,
              backgroundColor: Colors.white.withOpacity(0.05),
              color: session != null && session.endTime == null
                  ? Colors.redAccent
                  : Colors.cyanAccent,
            ),
          ),
          Column(
            children: [
              if (session != null && session.endTime == null)
                const Text(
                  "REC",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                  ),
                )
              else
                Text(
                  "${(score * 100).round()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              Text(
                session != null && session.endTime == null
                    ? "MONITORING"
                    : "SLEEP SCORE",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHypnogram(SleepSession? session) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<SleepCubit>()..loadTrendData(7),
              child: const SleepTrendsScreen(),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.cyanAccent.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "HYPNOGRAM",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.cyanAccent.withOpacity(0.4),
                  size: 16,
                ),
                Text(
                  "7-DAY HISTORY",
                  style: TextStyle(
                    color: Colors.cyanAccent.withOpacity(0.4),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const Gap(12),
            // Stage duration pills
            if (session != null && session.stages.isNotEmpty)
              _buildStagePills(session)
            else
              Text(
                "No stage data yet",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.2),
                  fontSize: 11,
                ),
              ),
            const Gap(14),
            SizedBox(
              height: 120,
              child: (session == null || session.stages.isEmpty)
                  ? Center(
                      child: Text(
                        "Start tracking to see your sleep stages",
                        style: TextStyle(color: Colors.white24, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _buildChart(session),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStagePills(SleepSession session) {
    final stages = session.stages;
    final total = stages.length;
    if (total == 0) return const SizedBox();

    // Estimate duration per stage entry (total duration / stage count)
    final totalDuration = (session.endTime ?? DateTime.now()).difference(
      session.startTime,
    );
    final minutesPerEntry = total > 0
        ? (totalDuration.inMinutes / total).clamp(1.0, 60.0)
        : 1.0;

    int deepCount = stages.where((s) => s.stage == SleepStage.deep).length;
    int remCount = stages.where((s) => s.stage == SleepStage.rem).length;
    int lightCount = stages.where((s) => s.stage == SleepStage.light).length;
    int awakeCount = stages.where((s) => s.stage == SleepStage.awake).length;

    int deepMin = (deepCount * minutesPerEntry).round();
    int remMin = (remCount * minutesPerEntry).round();
    int lightMin = (lightCount * minutesPerEntry).round();
    int awakeMin = (awakeCount * minutesPerEntry).round();

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _stagePill("DEEP", "${deepMin}m", const Color(0xFF0D47A1)),
        _stagePill("REM", "${remMin}m", const Color(0xFF6A0080)),
        _stagePill("LIGHT", "${lightMin}m", const Color(0xFF006064)),
        _stagePill("AWAKE", "${awakeMin}m", const Color(0xFF7B3F00)),
      ],
    );
  }

  Widget _stagePill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const Gap(5),
          Text(
            "$label  ",
            style: TextStyle(
              color: color.withOpacity(0.9),
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(SleepSession session) {
    final spots = session.stages.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.stage.index.toDouble());
    }).toList();

    // Color gradient based on stage
    final colors = [
      const Color(0xFF0D47A1), // deep (index 0)
      const Color(0xFF006064), // light (index 1)
      const Color(0xFF6A0080), // rem (index 2)
      const Color(0xFF7B3F00), // awake (index 3)
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (v) =>
              FlLine(color: Colors.white.withOpacity(0.05), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              getTitlesWidget: (value, meta) {
                const labels = ['DEEP', 'LIGHT', 'REM', 'AWAKE'];
                if (value < 0 || value > 3) return const SizedBox();
                return Text(
                  labels[value.toInt()],
                  style: TextStyle(
                    color: colors[value.toInt()].withOpacity(0.7),
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.35,
            color: Colors.cyanAccent,
            barWidth: 2.5,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.cyanAccent.withOpacity(0.2),
                  Colors.cyanAccent.withOpacity(0.02),
                ],
              ),
            ),
          ),
        ],
        minY: 0,
        maxY: 3,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, SleepState state) {
    return Column(
      children: [
        _buildMainActionButton(
          label: state.isTracking ? "STOP TRACKING" : "START TRACKING",
          color: state.isTracking ? Colors.redAccent : Colors.cyanAccent,
          onTap: () {
            if (state.isTracking) {
              context.read<SleepCubit>().stopTracking();
            } else {
              context.read<SleepCubit>().startTracking();
            }
          },
        ),
        const Gap(12),
        _buildMainActionButton(
          label: "AUTO TRACK",
          color: Colors.blueAccent,
          icon: Icons.auto_mode_rounded,
          onTap: () => _showAutoTrackSettings(context, state),
        ),
        const Gap(12),
        _buildMainActionButton(
          label: "SHARE SLEEP ANALYSIS",
          color: Colors.purpleAccent,
          icon: Icons.share_outlined,
          onTap: () => _showSleepSharePicker(context, state),
        ),
        const Gap(12),
        _buildMainActionButton(
          label: "TEST ALARM SOUND",
          color: Colors.orangeAccent,
          icon: Icons.notification_important_rounded,
          onTap: () => context.read<SleepCubit>().testAlarm(),
        ),
        const Gap(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildSecondaryButton(
                    icon: Icons.alarm_on_rounded,
                    label: "SMART ALARM",
                    onTap: () => _pickSmartAlarm(context, state),
                  ),
                  if (state.smartAlarmStart != null) ...[
                    const Gap(12),
                    if (state.isSmartAlarmEnabled) ...[
                      _buildSmartAlarmWindowSlider(context, state),
                    ],
                    const Gap(12),
                    Text(
                      "${_formatTime(state.smartAlarmStart!)} - ${_formatTime(state.smartAlarmEnd!)}",
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(4),
                    _buildAlarmCountdown(state),
                  ],
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child: _buildSecondaryButton(
                icon: Icons.show_chart_rounded,
                label: "TRENDS",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SleepCubit>(),
                        child: const SleepTrendsScreen(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const Gap(20),
        _buildAlarmSoundSection(context, state),
        const Gap(24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "SENSITIVITY SETTINGS",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.info_outline_rounded,
                    size: 14,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF1a1a1a),
                        title: const Text(
                          "AI SENSITIVITY",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: const Text(
                          "This adjusts how sensitive the on-device AI is to detecting sleep sounds (snoring, breathing) and movement.\n\n"
                          "• Higher sensitivity will detect more subtle sounds but may increase false detections.\n"
                          "• Lower sensitivity is stricter and only records clear signals.\n\n"
                          "Adjust this if you feel the reports are over-reporting or missing events.",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "UNDERSTOOD",
                              style: TextStyle(color: Colors.cyanAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            Slider(
              value: state.sensitivity,
              onChanged: (val) =>
                  context.read<SleepCubit>().updateSensitivity(val),
              activeColor: Colors.cyanAccent,
              inactiveColor: Colors.white.withOpacity(0.05),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainActionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withOpacity(0.8), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: color.withOpacity(0.02),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: color),
              const Gap(10),
            ],
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 10.5,
                color: color,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartAlarmWindowSlider(BuildContext context, SleepState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SMART WINDOW",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${state.smartAlarmWindowMinutes} min",
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: state.smartAlarmWindowMinutes.toDouble(),
          min: 5,
          max: 30,
          divisions: 5,
          onChanged: (val) =>
              context.read<SleepCubit>().updateSmartAlarmWindow(val.toInt()),
          activeColor: Colors.cyanAccent,
          inactiveColor: Colors.white.withOpacity(0.05),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.cyanAccent, size: 16),
            const Gap(6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmSoundSection(BuildContext context, SleepState state) {
    final soundPath = state.settings?.alarmSoundPath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ALARM SOUND",
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(12),
        if (_builtInSounds.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: soundPath != null && soundPath.startsWith('assets/')
                    ? Colors.cyanAccent.withOpacity(0.5)
                    : Colors.white.withOpacity(0.05),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _builtInSounds.contains(soundPath) ? soundPath : null,
                hint: const Text(
                  'Select built-in alarm...',
                  style: TextStyle(color: Colors.white24, fontSize: 13),
                ),
                isExpanded: true,
                dropdownColor: const Color(0xFF1a1a1a),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.cyanAccent,
                ),
                items: (() {
                  final sortedList = List<String>.from(_builtInSounds)
                    ..sort((a, b) {
                      final aNum =
                          int.tryParse(
                            RegExp(
                                  r'alarm-(\d+)',
                                ).firstMatch(a.toLowerCase())?.group(1) ??
                                '0',
                          ) ??
                          0;
                      final bNum =
                          int.tryParse(
                            RegExp(
                                  r'alarm-(\d+)',
                                ).firstMatch(b.toLowerCase())?.group(1) ??
                                '0',
                          ) ??
                          0;
                      return aNum.compareTo(bNum);
                    });
                  return sortedList.asMap().entries.map((entry) {
                    final path = entry.value;
                    return DropdownMenuItem(
                      value: path,
                      child: Text(
                        'Ringtone ${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }).toList();
                })(),
                onChanged: (val) async {
                  if (val != null) {
                    context.read<SleepCubit>().updateAlarmSound(val);
                    // Force a rebuild to update the text immediately
                    setState(() {});

                    // Preview with 5s limit
                    try {
                      await _audioPlayer.stop();
                      final relativePath = val.replaceFirst('assets/', '');
                      await _audioPlayer.play(AssetSource(relativePath));

                      // Auto stop after 5s
                      Future.delayed(const Duration(seconds: 5), () {
                        if (mounted) _audioPlayer.stop();
                      });
                    } catch (e) {
                      debugPrint("Preview error: $e");
                    }
                  }
                },
              ),
            ),
          ),
          const Gap(12),
        ],
        _buildSecondaryButton(
          icon: Icons.file_upload_outlined,
          label: soundPath != null && !soundPath.startsWith('assets/')
              ? "CUSTOM: ${soundPath.split('/').last}"
              : "USE CUSTOM SOUND FROM DEVICE",
          onTap: () => _pickAlarmSound(context),
        ),
      ],
    );
  }

  void _pickSmartAlarm(BuildContext context, SleepState state) async {
    final result = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) => CustomTimePickerDialog(
        initialTime: state.smartAlarmEnd != null
            ? TimeOfDay.fromDateTime(state.smartAlarmEnd!)
            : const TimeOfDay(hour: 7, minute: 0),
        title: "WAKE UP WINDOW",
        showSmartAlarmToggle: true,
        isSmartAlarmEnabled: state.isSmartAlarmEnabled,
        onSmartAlarmToggle: (val) =>
            context.read<SleepCubit>().toggleSmartAlarm(val),
      ),
    );

    if (result != null) {
      final now = DateTime.now();
      final endDt = DateTime(
        now.year,
        now.month,
        now.day,
        result.hour,
        result.minute,
      );
      // Default a 30m window
      final startDt = endDt.subtract(const Duration(minutes: 30));
      context.read<SleepCubit>().setSmartAlarm(startDt, endDt);
    }
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final p = dt.hour >= 12 ? "PM" : "AM";
    return "$h:$m $p";
  }

  void _showAutoTrackSettings(BuildContext context, SleepState state) {
    if (state.settings == null) {
      debugPrint("SleepScreen: Settings not loaded yet.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Initializing sleep engine... Please wait a second."),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AutoTrackDialog(
        settings: state.settings!,
        onScheduleChanged: (index, schedule) {
          context.read<SleepCubit>().updateDaySchedule(index, schedule);
        },
        onToggle: (val) {
          context.read<SleepCubit>().toggleAutoTrack(val);
        },
      ),
    );
  }

  void _showSleepSharePicker(BuildContext context, SleepState state) {
    final session = state.latestSession;
    if (session == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No sleep data to share!")));
      return;
    }

    // Serialize sleep summary
    final data = {
      'date': session.date.toIso8601String(),
      'score': session.qualityScore,
      'startTime': session.startTime.toIso8601String(),
      'endTime': session.endTime?.toIso8601String(),
      'eventCount': session.events.length,
      'notes': 'Shared via Social Hub',
    };

    final socialCubit = context.read<SocialCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF121212),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'SHARE SLEEP DATA TO',
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...socialCubit.state.conversations.map((conv) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: conv.isGroup
                      ? Colors.purple
                      : Colors.purpleAccent,
                  child: Icon(
                    conv.isGroup ? Icons.groups : Icons.bedtime,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                title: Text(
                  conv.name,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  socialCubit.shareContent(
                    conv.remoteId,
                    "Shared a sleep report with you.",
                    'sleep',
                    jsonEncode(data),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Shared with ${conv.name}")),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmCountdown(SleepState state) {
    if (state.smartAlarmStart == null) return const SizedBox.shrink();

    final now = DateTime.now();
    DateTime target = state.smartAlarmStart!;

    // If it is in the past, it's actually for tomorrow (repeating logic)
    if (target.isBefore(now)) {
      target = target.add(const Duration(days: 1));
    }

    final diff = target.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    return Text(
      "Alarm starts in $hours:${minutes.toString().padLeft(2, '0')} h",
      style: TextStyle(
        color: Colors.white.withOpacity(0.3),
        fontSize: 9,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
