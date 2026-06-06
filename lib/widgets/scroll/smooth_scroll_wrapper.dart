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
    this.curve = Curves.easeOutQuad,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          final double delta = pointerSignal.scrollDelta.dy;
          if (delta == 0) return;
          double targetOffset = controller.offset + (delta > 0 ? scrollSpeed : -scrollSpeed);
          targetOffset = targetOffset.clamp(
            controller.position.minScrollExtent,
            controller.position.maxScrollExtent,
          );
          controller.animateTo(
            targetOffset,
            duration: Duration(milliseconds: animationDuration),
            curve: curve,
          );
        }
      },
      child: ScrollConfiguration(
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