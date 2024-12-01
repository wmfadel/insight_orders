import 'package:flutter/material.dart';
import 'package:insight_orders/router/app_router.dart';

class InsightOrdersApp extends StatelessWidget {
  const InsightOrdersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Insight Orders',
      routerConfig: AppRouter().router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // TODO add router here
    );
  }
}
