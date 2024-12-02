import 'package:flutter/material.dart';
import 'package:insight_orders/core/constants/strings.dart';
import 'package:rive/rive.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});
// TODO test this widget
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          ConstStrings.animation404Rive,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
