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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
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
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 400, child: ChartView()),
              const SizedBox(height: 16),
              const Align(alignment: Alignment.center, child: OrderStats())
            ],
          ),
        ),
      ),
    );
  }
}
