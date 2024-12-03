import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/core/utils/error_message.dart';
import 'package:insight_orders/features/orders/controllers/orders_cubit.dart';
import 'package:insight_orders/features/orders/widgets/orders_view.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrdersCubit, OrdersState>(listener: (context, state) {
        if (state is OrdersError) {
          context.showError(
              message: state.errorMessageKey == null
                  ? null
                  : context.translate(state.errorMessageKey!));
        }
      }, builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersError) {
          return Center(
            child: Text(
              state.errorMessageKey ??
                  context.translate(L10nKeys.someThingWentWrong),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else {
          return const OrdersView();
        }
      }),
    );
  }
}
