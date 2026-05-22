import 'package:flutter/material.dart';
import '../../widgets/foggy_background.dart';
import 'widgets/celebration_particles.dart';
import 'widgets/date_header.dart';
import 'widgets/vertical_day_view.dart';
import 'widgets/guided_breathing_overlay.dart';

final GlobalKey<CelebrationParticlesState> celebrationKey =
    GlobalKey<CelebrationParticlesState>();

class WorkoutWindowScreen extends StatelessWidget {
  const WorkoutWindowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CelebrationParticles(
          key: celebrationKey,
          child: const WorkoutWindowView(),
        ),
        const GuidedBreathingOverlay(),
      ],
    );
  }
}

class WorkoutWindowView extends StatefulWidget {
  const WorkoutWindowView({super.key});

  @override
  State<WorkoutWindowView> createState() => _WorkoutWindowViewState();
}

class _WorkoutWindowViewState extends State<WorkoutWindowView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keep state when swiping between horizontal pages

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: FoggyBackground(
        child: Column(
          children: const [
            SafeArea(bottom: false, child: DateHeader()),
            Expanded(child: VerticalDayView()),
          ],
        ),
      ),
    );
  }
}
