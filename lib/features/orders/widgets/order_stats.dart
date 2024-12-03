import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/features/orders/controllers/chart/chart_cubit.dart';

class OrderStats extends StatelessWidget {
  const OrderStats({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChartCubit>();
    final Map<String, int> timeOfDayDistribution = cubit.timeOfDayDistributions;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _StatEntry(
          label: context.translate(L10nKeys.totalOrders),
          value: cubit.orders.length.toString(),
        ),
        _StatEntry(
          label: context.translate(L10nKeys.totalSales),
          value: cubit.totalSales.toStringAsFixed(2),
        ),
        _StatEntry(
          label: context.translate(L10nKeys.averageOrderValue),
          value: cubit.averageOrderValue.toStringAsFixed(2),
        ),
        _StatEntry(
          label: context.translate(L10nKeys.highestOrderValue),
          value: cubit.maxOrderValue.toStringAsFixed(2),
        ),
        const SizedBox(height: 16),
        Text(
          context.translate(L10nKeys.activeInactiveOrders),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _StatEntry(
          label: context.translate(L10nKeys.active),
          value:
              '${cubit.activeOrders} (${cubit.activePercentage.toStringAsFixed(2)}%)',
        ),
        _StatEntry(
          label: context.translate(L10nKeys.inactive),
          value:
              '${cubit.inactiveOrders} (${cubit.inactivePercentage.toStringAsFixed(2)}%)',
        ),
        const SizedBox(height: 16),
        Text(
          context.translate(L10nKeys.ordersByTime),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _StatEntry(
          label: context.translate(L10nKeys.morning),
          value: timeOfDayDistribution['Morning (12 AM - 6 AM)'].toString(),
        ),
        _StatEntry(
          label: context.translate(L10nKeys.afternoon),
          value: timeOfDayDistribution['Afternoon (6 AM - 12 PM)'].toString(),
        ),
        _StatEntry(
          label: context.translate(L10nKeys.evening),
          value: timeOfDayDistribution['Evening (12 PM - 6 PM)'].toString(),
        ),
        _StatEntry(
          label: context.translate(L10nKeys.night),
          value: timeOfDayDistribution['Night (6 PM - 12 AM)'].toString(),
        ),
      ],
    );
  }
}

class _StatEntry extends StatelessWidget {
  final String label;
  final String value;

  const _StatEntry({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
