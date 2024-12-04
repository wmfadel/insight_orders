import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insight_orders/features/orders/models/chart_data.dart';
import 'package:insight_orders/features/orders/models/filter_enum.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';
import 'package:intl/intl.dart';

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

  ChartFilters _selectedFilter = ChartFilters.all;

  ChartFilters get selectedFilter => _selectedFilter;
  set selectedFilter(ChartFilters filter) {
    _selectedFilter = filter;
    emit(ChartFilterChanged(filter));
  }

  List<OrderData> applyFilter() {
    DateTime firstOrderDate = DateFormat("h a").parse(chartData.first.time);

    switch (_selectedFilter) {
      case ChartFilters.oneDay:
        // Show data for the first day in the dataset
        return chartData.where((order) {
          DateTime orderTime = DateFormat("h a").parse(order.time);
          return orderTime.year == firstOrderDate.year &&
              orderTime.month == firstOrderDate.month &&
              orderTime.day == firstOrderDate.day;
        }).toList();
      case ChartFilters.oneWeek:
        // Show data for the first full week
        DateTime firstDayOfWeek =
            firstOrderDate.subtract(Duration(days: firstOrderDate.weekday - 1));
        DateTime endOfWeek = firstDayOfWeek.add(const Duration(days: 6));

        return chartData.where((order) {
          DateTime orderTime = DateFormat("h a").parse(order.time);
          return orderTime.isAfter(firstDayOfWeek) &&
              orderTime.isBefore(endOfWeek);
        }).toList();
      case ChartFilters.oneMonth:
        // Show data for the first full month
        DateTime firstDayOfMonth =
            DateTime(firstOrderDate.year, firstOrderDate.month, 1);
        DateTime endOfMonth = DateTime(firstOrderDate.year,
            firstOrderDate.month + 1, 0); // Last day of the first month

        return chartData.where((order) {
          DateTime orderTime = DateFormat("h a").parse(order.time);
          return orderTime.isAfter(firstDayOfMonth) &&
              orderTime.isBefore(endOfMonth);
        }).toList();
      case ChartFilters.all:
      default:
        return chartData;
    }
  }
}
