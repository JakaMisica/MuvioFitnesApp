import 'package:flutter/material.dart';

class FoggyBackground extends StatelessWidget {
  final Widget child;
  final bool showGreenFog;

  const FoggyBackground({
    super.key,
    required this.child,
    this.showGreenFog = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Deep Background - Large Dark Gray Mist (Bottom Left)
        Positioned(
          bottom: -250,
          left: -150,
          child: Container(
            width: 850,
            height: 850,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.grey.withOpacity(0.06), Colors.transparent],
              ),
            ),
          ),
        ),
        // 2. Extra Gray Fog (Top Left)
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 550,
            height: 550,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.grey.withOpacity(0.05), Colors.transparent],
              ),
            ),
          ),
        ),
        // 3. Middle Gray Mist (Right Side)
        Positioned(
          top: 250,
          right: -200,
          child: Container(
            width: 700,
            height: 700,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.grey.withOpacity(0.04), Colors.transparent],
              ),
            ),
          ),
        ),
        // 4. Greenish Fog (Top Right)
        if (showGreenFog)
          Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.green.withOpacity(0.04), Colors.transparent],
                ),
              ),
            ),
          ),
        // 5. Center Diffused Ambient (Medium Gray)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.1, -0.3),
                radius: 1.8,
                colors: [Colors.grey.withOpacity(0.03), Colors.transparent],
              ),
            ),
          ),
        ),
        // 6. Lower Gray Fog (Bottom Right)
        Positioned(
          bottom: -80,
          right: -80,
          child: Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.grey.withOpacity(0.03), Colors.transparent],
              ),
            ),
          ),
        ),
        // The actual content
        child,
      ],
    );
  }
}
