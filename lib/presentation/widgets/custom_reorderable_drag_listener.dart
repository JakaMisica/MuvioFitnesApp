import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FastReorderableDelayedDragStartListener
    extends ReorderableDelayedDragStartListener {
  final Duration dragDelay;

  const FastReorderableDelayedDragStartListener({
    super.key,
    required super.child,
    required super.index,
    super.enabled,
    this.dragDelay = const Duration(milliseconds: 250),
  });

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(delay: dragDelay);
  }
}
