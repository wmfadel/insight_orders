import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';

class ToChartsIcon extends StatelessWidget {
  const ToChartsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.bubble_chart,
      size: 32,
      semanticLabel: context.translate(L10nKeys.openCharts),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(delay: 4000.ms, duration: 1800.ms)
        .shake(hz: 4, curve: Curves.easeInOutCubic)
        .then(delay: 600.ms);
  }
}
