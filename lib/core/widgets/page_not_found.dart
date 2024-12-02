import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_orders/core/constants/strings.dart';
import 'package:insight_orders/core/theme/colors.dart';
import 'package:insight_orders/router/app_router.dart';
import 'package:rive/rive.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.errorSurface,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: double.maxFinite,
              height: 200,
              child: RiveAnimation.asset(
                ConstStrings.animation404Rive,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: Text(
                'Go Back', // TODO localize
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                context.goNamed(AppRouter.ordersName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
