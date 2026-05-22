import 'dart:math';
import 'package:flutter/material.dart';

class CelebrationParticles extends StatefulWidget {
  final Widget child;
  const CelebrationParticles({super.key, required this.child});

  @override
  State<CelebrationParticles> createState() => CelebrationParticlesState();
}

class CelebrationParticlesState extends State<CelebrationParticles>
    with SingleTickerProviderStateMixin {
  final List<Particle> _particles = [];
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            if (mounted) {
              setState(() {
                _particles.removeWhere((p) => p.isDead);
                for (var p in _particles) {
                  p.update();
                }
              });
            }
          });
  }

  void explodeConfetti() {
    final size = MediaQuery.of(context).size;
    // Create multiple bursts for a full effect
    for (int i = 0; i < 60; i++) {
      _particles.add(
        Particle(
          x: size.width / 2,
          y: 100, // Top of screen/header area
          vx: (_random.nextDouble() - 0.5) * 15,
          vy: (_random.nextDouble() * -12) - 5,
          color: Colors.primaries[_random.nextInt(Colors.primaries.length)],
          type: ParticleType.confetti,
          size: _random.nextDouble() * 8 + 4,
        ),
      );
    }
    if (!_controller.isAnimating) _controller.repeat();
  }

  void popCheckmark(Offset position) {
    for (int i = 0; i < 12; i++) {
      _particles.add(
        Particle(
          x: position.dx,
          y: position.dy,
          vx: (_random.nextDouble() - 0.5) * 10,
          vy: (_random.nextDouble() * -15) - 5,
          color: Colors.greenAccent,
          type: ParticleType.checkmark,
          size: _random.nextDouble() * 10 + 10,
        ),
      );
    }
    if (!_controller.isAnimating) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_particles.isNotEmpty)
          IgnorePointer(
            child: CustomPaint(
              size: Size.infinite,
              painter: ParticlePainter(particles: _particles),
            ),
          ),
      ],
    );
  }
}

enum ParticleType { confetti, checkmark }

class Particle {
  double x, y, vx, vy;
  double gravity = 0.4;
  Color color;
  double life = 1.0;
  double decay;
  ParticleType type;
  double size;
  double rotation = 0;
  double vRotation;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.type,
    required this.size,
  }) : decay = Random().nextDouble() * 0.015 + 0.01,
       vRotation = (Random().nextDouble() - 0.5) * 0.3;

  void update() {
    x += vx;
    y += vy;
    vy += gravity;
    life -= decay;
    rotation += vRotation;
  }

  bool get isDead => life <= 0;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()..color = p.color.withOpacity(p.life.clamp(0, 1));

      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);

      if (p.type == ParticleType.confetti) {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.6,
          ),
          paint,
        );
      } else {
        // Draw a green circle with a black checkmark
        final circlePaint = Paint()
          ..color = Colors.green.withOpacity(p.life.clamp(0, 1))
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset.zero, p.size * 0.5, circlePaint);

        final checkPath = Path()
          ..moveTo(-p.size * 0.25, 0)
          ..lineTo(-p.size * 0.05, p.size * 0.2)
          ..lineTo(p.size * 0.25, -p.size * 0.2);

        final checkPaint = Paint()
          ..color = Colors.black.withOpacity(p.life.clamp(0, 1))
          ..style = PaintingStyle.stroke
          ..strokeWidth = p.size * 0.1
          ..strokeCap = StrokeCap.round;

        canvas.drawPath(checkPath, checkPaint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
