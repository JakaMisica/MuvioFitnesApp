import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import '../../widgets/foggy_background.dart';

class InstallationScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const InstallationScreen({super.key, required this.onComplete});

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
  double _progress = 0.0;
  String _currentTask = "INITIALIZING CORE...";
  final List<String> _tasks = [
    "MAPPING BIOMETRIC SENSORS...",
    "SYNCING LOCAL DATABASE (ISAR)...",
    "RECALIBRATING NEURAL ENGINE...",
    "GENERATING 3D AVATAR MESH...",
    "OPTIMIZING PERFORMANCE PROFILES...",
    "ENCRYPTING LOCAL DATA STORAGE...",
    "SYSTEM READY.",
  ];
  int _taskIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startInstallation();
  }

  void _startInstallation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.02;
        if (_progress >= 1.0) {
          _progress = 1.0;
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 500), widget.onComplete);
        }

        // Update task text
        int newTaskIndex = (_progress * _tasks.length).floor();
        if (newTaskIndex < _tasks.length && newTaskIndex != _taskIndex) {
          _taskIndex = newTaskIndex;
          _currentTask = _tasks[_taskIndex];
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FoggyBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.downloading_rounded,
                  color: Colors.cyanAccent,
                  size: 64,
                ),
                const Gap(32),
                const Text(
                  "INSTALLING SYSTEM",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                  ),
                ),
                const Gap(8),
                Text(
                  _currentTask,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const Gap(40),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 12,
                        width:
                            (MediaQuery.of(context).size.width - 96) *
                            _progress,
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Text(
                  "${(_progress * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white24,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
