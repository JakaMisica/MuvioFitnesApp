import 'dart:async';
import 'package:biofit_pro/data/models/enums.dart';
import 'package:biofit_pro/data/models/muscle_metadata.dart';
import 'package:flutter/material.dart';
import 'package:biofit_pro/logic/cubit/evolution/evolution_state.dart';

class MuscleGainsHUD extends StatefulWidget {
  final EvolutionState evolutionState;

  const MuscleGainsHUD({super.key, required this.evolutionState});

  @override
  State<MuscleGainsHUD> createState() => _MuscleGainsHUDState();
}

class _MuscleGainsHUDState extends State<MuscleGainsHUD> {
  int _currentIndex = 0;
  Timer? _timer;
  late PageController _pageController;
  bool _isAutoPlaying = true;

  final List<MuscleGroup> _slides = [
    MuscleGroup.chest,
    MuscleGroup.back,
    MuscleGroup.shoulders,
    MuscleGroup.arms,
    MuscleGroup.legs,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted && _isAutoPlaying) {
        final nextIndex = (_currentIndex + 1) % _slides.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoPlay() {
    if (_isAutoPlaying) {
      setState(() {
        _isAutoPlaying = false;
      });
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "GAINS EVOLUTION",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                _isAutoPlaying ? "Auto-rotating (10s)" : "Manual Mode",
                style: TextStyle(
                  color: _isAutoPlaying ? Colors.white.withOpacity(0.4) : Colors.cyanAccent.withOpacity(0.6),
                  fontSize: 8,
                  fontWeight: _isAutoPlaying ? FontWeight.normal : FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Listener(
              onPointerDown: (_) => _stopAutoPlay(),
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final group = _slides[index];
                  final subGroups = MuscleMetadata.subgroups[group] ?? [];
                  final groupGains = widget.evolutionState.muscleGains[group.name] ?? {};

                  // If per-subgroup data exists, use it.
                  // Otherwise distribute the 'General' total evenly across all subgroups.
                  final generalTotal = groupGains['General'] ?? 0.0;
                  final hasSpecificData = groupGains.keys.any((k) => k != 'General' && (groupGains[k] ?? 0) > 0);
                  final fallbackPerSubgroup = (!hasSpecificData && subGroups.isNotEmpty)
                      ? generalTotal / subGroups.length
                      : 0.0;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Background Image
                        Positioned.fill(
                          child: Image.asset(
                            MuscleMetadata.getMuscleImagePath(group),
                            fit: BoxFit.cover,
                            color: Colors.black.withOpacity(0.6),
                            colorBlendMode: BlendMode.darken,
                            errorBuilder: (ctx, err, stack) => Container(color: Colors.black45),
                          ),
                        ),
                        
                        // Content
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              ...subGroups.asMap().entries.map((entry) {
                                final name = entry.value;
                                // Use specific subgroup data if available, else use evenly distributed general total
                                final value = hasSpecificData
                                    ? (groupGains[name] ?? 0.0)
                                    : fallbackPerSubgroup;
                                // Scale: value is in grams. Treat 5g per subgroup as 100% bar.
                                final progress = (value / 5.0).clamp(0.0, 1.0);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(color: Colors.white, fontSize: 10),
                                          ),
                                          Text(
                                            "${value > 0 ? '+' : ''}${(value * 20).toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              color: value > 0 ? Colors.greenAccent : Colors.white38,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor: Colors.white.withOpacity(0.05),
                                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                                          minHeight: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),

                        // Dot indicators (now inside the stack for each page or better outside? 
                        // Inside is fine if correctly aligned)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Row(
                            children: _slides.asMap().entries.map((entry) {
                              return Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: entry.key == index 
                                    ? Colors.cyanAccent 
                                    : Colors.white24,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
