import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insight_orders/core/utils/app_logger.dart';
import 'package:insight_orders/core/widgets/page_not_found.dart';
import 'package:insight_orders/features/orders/controllers/orders_cubit.dart';
import 'package:insight_orders/features/orders/pages/chart_page.dart';
import 'package:insight_orders/features/orders/pages/orders_page.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';

class AppRouter {
  static const String ordersPath = '/orders';
  static const String ordersName = 'orders';

  static const String ordersChartPath = '/chart';
  static const String ordersChartName = 'chart';

  final GoRouter _router = GoRouter(
      initialLocation: ordersPath,
      routes: <RouteBase>[
        GoRoute(
          path: ordersPath,
          name: ordersName,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider<OrdersCubit>(
              create: (context) => OrdersCubit(
                ordersService: GetIt.instance.get<OrdersService>(),
              )..loadOrders(),
              child: const OrdersPage(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: ordersChartPath,
              name: ordersChartName,
              builder: (BuildContext context, GoRouterState state) {
                return const ChartPage();
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) {
        AppLogger.e('Error: ${state.error}');
        return const NotFoundPage();
      },
      redirect: (context, state) {
        AppLogger.i('Moving to page: ${state.name}'
            '${state.extra != null ? ' with extra: ${state.extra}' : ''}'
            '${state.pathParameters.isNotEmpty ? ' with parameters: ${state.pathParameters}' : ''}');
        return null;
      });

  GoRouter get router => _router;
}
