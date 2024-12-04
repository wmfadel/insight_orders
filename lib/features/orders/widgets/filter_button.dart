import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/features/orders/controllers/chart/chart_cubit.dart';
import 'package:insight_orders/features/orders/models/filter_enum.dart';

class FilterButton extends StatelessWidget {
  final ChartFilters filter;

  const FilterButton({required this.filter, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChartCubit>();
    return GestureDetector(
      onTap: () {
        cubit.selectedFilter = filter;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: cubit.selectedFilter == filter
                ? Colors.blue.withOpacity(0.3)
                : Colors.grey.withOpacity(0.3),
          ),
          child: Text(context.translate(filter.name)),
        ),
      ),
    );
  }
}
