import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlipImageCarousel extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const FlipImageCarousel({
    super.key,
    required this.imagePath,
    this.width = 100,
    this.height = 100,
    this.borderRadius = 12,
  });

  @override
  State<FlipImageCarousel> createState() => _FlipImageCarouselState();
}

class _FlipImageCarouselState extends State<FlipImageCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _currentImagePath = "";
  String _nextImagePath = "";

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void didUpdateWidget(FlipImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _nextImagePath = widget.imagePath;
      if (_controller.isAnimating) return;

      _controller.forward(from: 0).then((_) {
        setState(() {
          _currentImagePath = _nextImagePath;
          _controller.reset();
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final val = _controller.value;

        // Show current image until half-flip, then show next
        final displayedImage = (val < 0.5 || _nextImagePath.isEmpty)
            ? _currentImagePath
            : _nextImagePath;

        // Calculate rotation so it flips 0 -> 90 then -90 -> 0
        double rotation;
        if (val < 0.5) {
          rotation = val * math.pi; // 0 to pi/2
        } else {
          rotation = (val - 1.0) * math.pi; // -pi/2 to 0
        }

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002) // Perspective/Tilt
            ..rotateY(rotation),
          alignment: Alignment.center,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: Colors.white10),
              image: DecorationImage(
                image: AssetImage(displayedImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
