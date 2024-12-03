import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/features/orders/widgets/chart_view.dart';
import 'package:insight_orders/features/orders/widgets/order_stats.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    context.translate(L10nKeys.chartAndStats),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: context.pop,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  child: const ChartView(),
                ),
                // Additional Stats
                const Align(alignment: Alignment.center, child: OrderStats())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
