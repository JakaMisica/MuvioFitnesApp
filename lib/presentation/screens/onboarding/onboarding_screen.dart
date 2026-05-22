import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../data/repositories/body_repository.dart';
import '../../../data/models/body_metric.dart';
import '../../../locator.dart';
import '../../widgets/foggy_background.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _bodyRepo = locator<BodyRepository>();

  int _step = 0;
  String _gender = "male";
  int _age = 25;
  double _height = 175.0;
  double _weight = 75.0;
  String _goal = "Build Muscle";

  final List<String> _goals = [
    "Build Muscle",
    "Burn Fat",
    "Performance",
    "Recovery",
  ];

  Future<void> _finish() async {
    final settings = await _bodyRepo.getUserSettings();
    settings.gender = _gender;
    settings.age = _age;
    settings.heightCm = _height;
    settings.goal = _goal;
    settings.isProfileComplete = true;
    await _bodyRepo.saveUserSettings(settings);

    // Save initial weight as first body metric
    final metric = BodyMetric(weight: _weight, bodyFatPercentage: 15.0)
      ..date = DateTime.now();
    await _bodyRepo.saveMetric(metric);

    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressBars(),
                const Gap(48),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildStepContent(),
                  ),
                ),
                const Gap(24),
                _buildNavButtons(),
                const Gap(48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBars() {
    return Row(
      children: List.generate(5, (index) {
        bool active = index <= _step;
        return Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: active ? Colors.cyanAccent : Colors.white10,
              borderRadius: BorderRadius.circular(2),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.3),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _buildGenericStep(
          "BIOLOGICAL SCAN",
          "Identify your phenotype.",
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLargeToggleButton(
                "MALE",
                Icons.male,
                _gender == "male",
                () => setState(() => _gender = "male"),
              ),
              const Gap(24),
              _buildLargeToggleButton(
                "FEMALE",
                Icons.female,
                _gender == "female",
                () => setState(() => _gender = "female"),
              ),
            ],
          ),
        );
      case 1:
        return _buildGenericStep(
          "CHRONOLOGICAL AGE",
          "Current metabolic baseline.",
          _buildSliderSelection(
            "${_age}y",
            12,
            100,
            _age.toDouble(),
            (v) => setState(() => _age = v.toInt()),
          ),
        );
      case 2:
        return _buildGenericStep(
          "PHYSICAL STATURE",
          "Vertex to planar distance.",
          _buildSliderSelection(
            "${_height.toInt()}cm",
            100,
            250,
            _height,
            (v) => setState(() => _height = v),
          ),
        );
      case 3:
        return _buildGenericStep(
          "TOTAL MASS",
          "Current gravitational force.",
          _buildSliderSelection(
            "${_weight.toStringAsFixed(1)}kg",
            30,
            200,
            _weight,
            (v) => setState(() => _weight = v),
          ),
        );
      case 4:
        return _buildGenericStep(
          "PRIMARY MISSION",
          "Set the neural direction.",
          Column(children: _goals.map((g) => _buildGoalButton(g)).toList()),
        );
      default:
        return Container();
    }
  }

  Widget _buildGenericStep(String title, String subtitle, Widget content) {
    return Column(
      key: ValueKey(_step),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
        const Gap(8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const Gap(48),
        content,
      ],
    );
  }

  Widget _buildLargeToggleButton(
    String label,
    IconData icon,
    bool active,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: active
              ? Colors.cyanAccent.withOpacity(0.1)
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: active ? Colors.cyanAccent : Colors.white10,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? Colors.cyanAccent : Colors.white24,
              size: 40,
            ),
            const Gap(12),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.cyanAccent : Colors.white24,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSelection(
    String value,
    double min,
    double max,
    double current,
    Function(double) onChanged,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Gap(24),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.cyanAccent,
            inactiveTrackColor: Colors.white10,
            thumbColor: Colors.white,
            overlayColor: Colors.cyanAccent.withOpacity(0.1),
          ),
          child: Slider(
            value: current,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalButton(String goal) {
    bool active = _goal == goal;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => setState(() => _goal = goal),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: active
                ? Colors.cyanAccent.withOpacity(0.1)
                : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: active ? Colors.cyanAccent : Colors.white10,
            ),
          ),
          child: Center(
            child: Text(
              goal.toUpperCase(),
              style: TextStyle(
                color: active ? Colors.cyanAccent : Colors.white24,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_step > 0)
          TextButton(
            onPressed: () => setState(() => _step--),
            child: const Text(
              "PREVIOUS",
              style: TextStyle(
                color: Colors.white24,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          )
        else
          const SizedBox(),
        ElevatedButton(
          onPressed: () {
            if (_step < 4) {
              setState(() => _step++);
            } else {
              _finish();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            _step == 4 ? "INITIALIZE" : "NEXT",
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}
