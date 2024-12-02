import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ToChartsIcon extends StatelessWidget {
  const ToChartsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.bubble_chart,
      size: 32,
      semanticLabel: 'Open charts', // TODO localize
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(delay: 4000.ms, duration: 1800.ms)
        .shake(hz: 4, curve: Curves.easeInOutCubic)
        .then(delay: 600.ms);
  }
}
