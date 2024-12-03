import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/features/orders/controllers/orders_cubit.dart';
import 'package:insight_orders/features/orders/widgets/orders_list.dart';
import 'package:insight_orders/features/orders/widgets/to_charts_icon.dart';
import 'package:insight_orders/router/app_router.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.translate(L10nKeys.orders),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                IconButton(
                  icon: const ToChartsIcon(),
                  onPressed: () {
                    context.goNamed(AppRouter.ordersChartName);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: OrdersList(orders: cubit.orders)),
          ],
        ),
      ),
    );
  }
}
