import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insight_orders/features/orders/models/chart_data.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit({
    required OrdersService ordersService,
  })  : _ordersService = ordersService,
        super(ChartInitial());

  final OrdersService _ordersService;

  List<Order> get orders => _ordersService.orders;

  List<OrderData> get chartData => _ordersService.chartData;

  double get totalSales => _ordersService.totalSales;

  double get averageOrderValue => _ordersService.averageOrderValue;

  double get maxOrderValue => _ordersService.maxOrderValue;

  int get activeOrders => _ordersService.activeOrders;

  int get inactiveOrders => _ordersService.inactiveOrders;

  double get activePercentage => _ordersService.activePercentage;

  double get inactivePercentage => _ordersService.inactivePercentage;


  Map<String, int> get timeOfDayDistributions =>
      _ordersService.timeOfDayDistributions();
}
