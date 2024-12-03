import 'package:insight_orders/core/utils/number_utils.dart';
import 'package:insight_orders/core/utils/time_utils.dart';
import 'package:insight_orders/features/orders/models/chart_data.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/repositories/orders_repository.dart';

class OrdersService {
  final OrdersRepository _ordersRepository;

  OrdersService({OrdersRepository? ordersRepository})
      : _ordersRepository = ordersRepository ?? OrdersRepository();

  List<Order> _orders = [];
  final List<OrderData> _chartData = [];

  List<Order> get orders => [..._orders];

  List<OrderData> get chartData => [..._chartData];

  double get totalSales => _orders.fold(0.0,
      (sum, order) => sum + NumberUtils.removeFormatting(order.price ?? '0'));

  double get averageOrderValue => totalSales / _orders.length;

  double get maxOrderValue => _orders
      .map((order) => NumberUtils.removeFormatting(order.price ?? '0'))
      .reduce((a, b) => a > b ? a : b);

  int get activeOrders =>
      _orders.where((order) => order.isActive ?? false).length;

  int get inactiveOrders => _orders.length - activeOrders;

  double get activePercentage => (activeOrders / orders.length) * 100;

  double get inactivePercentage => (inactiveOrders / orders.length) * 100;

  Future<void> getOrders() async {
    final orders = await _ordersRepository.getOrders();
    _orders = orders;
    if (chartData.isEmpty) _chartData.addAll(_generateChartData());
  }

  List<OrderData> _generateChartData() {
    Map<String, int> orderCountByHour = {};

    // Group orders by hour and count them
    for (var order in _orders) {
      String timeKey = TimeUtils.extractHour(order.registered ?? '-');
      if (orderCountByHour.containsKey(timeKey)) {
        orderCountByHour[timeKey] = orderCountByHour[timeKey]! + 1;
      } else {
        orderCountByHour[timeKey] = 1;
      }
    }

    // List of all hours from 12 AM to 11 PM
    List<String> allHours = [
      '12 AM',
      '1 AM',
      '2 AM',
      '3 AM',
      '4 AM',
      '5 AM',
      '6 AM',
      '7 AM',
      '8 AM',
      '9 AM',
      '10 AM',
      '11 AM',
      '12 PM',
      '1 PM',
      '2 PM',
      '3 PM',
      '4 PM',
      '5 PM',
      '6 PM',
      '7 PM',
      '8 PM',
      '9 PM',
      '10 PM',
      '11 PM'
    ];

    // Create a list of OrderData, ensuring all hours are included with a count of 0 if missing
    return allHours.map((hour) {
      int orderCount =
          orderCountByHour[hour] ?? 0; // Default to 0 if no orders for the hour
      return OrderData(hour, orderCount);
    }).toList();
  }


  Map<String, int> timeOfDayDistributions() {
    Map<String, int> timeOfDayDistribution = {
      'Morning (12 AM - 6 AM)': 0,
      'Afternoon (6 AM - 12 PM)': 0,
      'Evening (12 PM - 6 PM)': 0,
      'Night (6 PM - 12 AM)': 0,
    };

    for (var order in orders) {
      DateTime dateTime = DateTime.parse(order.registered ?? '-');
      if (dateTime.hour >= 0 && dateTime.hour < 6) {
        timeOfDayDistribution['Morning (12 AM - 6 AM)'] =
            timeOfDayDistribution['Morning (12 AM - 6 AM)']! + 1;
      } else if (dateTime.hour >= 6 && dateTime.hour < 12) {
        timeOfDayDistribution['Afternoon (6 AM - 12 PM)'] =
            timeOfDayDistribution['Afternoon (6 AM - 12 PM)']! + 1;
      } else if (dateTime.hour >= 12 && dateTime.hour < 18) {
        timeOfDayDistribution['Evening (12 PM - 6 PM)'] =
            timeOfDayDistribution['Evening (12 PM - 6 PM)']! + 1;
      } else {
        timeOfDayDistribution['Night (6 PM - 12 AM)'] =
            timeOfDayDistribution['Night (6 PM - 12 AM)']! + 1;
      }
    }
    return timeOfDayDistribution;
  }
}
