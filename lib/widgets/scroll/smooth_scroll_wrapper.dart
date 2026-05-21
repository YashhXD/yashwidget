import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SmoothScrollWrapper extends StatelessWidget {
  final ScrollController controller;
  final Widget child;
  final double scrollSpeed;
  final int animationDuration;
  final Curve curve;

  const SmoothScrollWrapper({
    super.key,
    required this.controller,
    required this.child,
    this.scrollSpeed = 130.0,
    this.animationDuration = 400,
    this.curve = Curves.easeOutQuad, // FIXED: Changed from outQuadrant to easeOutQuad
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          // Detect the direction of the mouse wheel scroll
          final double delta = pointerSignal.scrollDelta.dy;
          if (delta == 0) return;

          // Calculate the new target scroll position
          double targetOffset = controller.offset + (delta > 0 ? scrollSpeed : -scrollSpeed);
          
          // Clamp the target offset so it doesn't scroll past the top or bottom boundaries
          targetOffset = targetOffset.clamp(
            controller.position.minScrollExtent,
            controller.position.maxScrollExtent,
          );

          // Animate smoothly to the target position
          controller.animateTo(
            targetOffset,
            duration: Duration(milliseconds: animationDuration),
            curve: curve,
          );
        }
      },
      child: ScrollConfiguration(
        // Deselect standard drag scrolling physics on desktop to prevent conflicts
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
          },
        ),
        child: child,
      ),
    );
  }
}