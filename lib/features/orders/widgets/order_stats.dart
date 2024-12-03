import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          label: 'Total Orders',
          value: cubit.orders.length.toString(),
        ),
        _StatEntry(
          label: 'Total Sales',
          value: cubit.totalSales.toStringAsFixed(2),
        ),
        _StatEntry(
          label: 'Average Order Value',
          value: cubit.averageOrderValue.toStringAsFixed(2),
        ),
        _StatEntry(
          label: 'Highest Order Value',
          value: cubit.maxOrderValue.toStringAsFixed(2),
        ),
        const SizedBox(height: 16),
        Text(
          'Active/Inactive Orders',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _StatEntry(
          label: 'Active',
          value:
              '${cubit.activeOrders} (${cubit.activePercentage.toStringAsFixed(2)}%)',
        ),
        _StatEntry(
          label: 'Inactive',
          value:
              '${cubit.inactiveOrders} (${cubit.inactivePercentage.toStringAsFixed(2)}%)',
        ),
        const SizedBox(height: 16),
        Text(
          'Orders by Time of Day',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _StatEntry(
          label: 'Morning',
          value: timeOfDayDistribution['Morning (12 AM - 6 AM)'].toString(),
        ),
        _StatEntry(
          label: 'Afternoon',
          value: timeOfDayDistribution['Afternoon (6 AM - 12 PM)'].toString(),
        ),
        _StatEntry(
          label: 'Evening',
          value: timeOfDayDistribution['Evening (12 PM - 6 PM)'].toString(),
        ),
        _StatEntry(
          label: 'Night',
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
