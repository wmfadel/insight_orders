import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late final TooltipBehavior _tooltipBehavior;
  late List<OrderData> _chartData;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chartData = _generateChartData();
    super.initState();
  }

  // Function to generate the chart data, ensuring all hours are represented
  List<OrderData> _generateChartData() {
    List<Order> orders = GetIt.instance.get<OrdersService>().orders;
    Map<String, int> orderCountByHour = {};

    // Group orders by hour and count them
    for (var order in orders) {
      String timeKey = extractHour(order.registered ?? '-');
      if (orderCountByHour.containsKey(timeKey)) {
        orderCountByHour[timeKey] = orderCountByHour[timeKey]! + 1;
      } else {
        orderCountByHour[timeKey] = 1;
      }
    }

    // List of all hours from 12 AM to 11 PM
    List<String> allHours = [
      '12 AM', '1 AM', '2 AM', '3 AM', '4 AM', '5 AM', '6 AM', '7 AM', '8 AM',
      '9 AM', '10 AM', '11 AM', '12 PM', '1 PM', '2 PM', '3 PM', '4 PM', '5 PM',
      '6 PM', '7 PM', '8 PM', '9 PM', '10 PM', '11 PM'
    ];

    // Create a list of OrderData, ensuring all hours are included with a count of 0 if missing
    return allHours.map((hour) {
      int orderCount = orderCountByHour[hour] ?? 0; // Default to 0 if no orders for the hour
      return OrderData(hour, orderCount);
    }).toList();
  }
  double removeFormatting(String formattedNumber) {
    // Remove the currency symbol (e.g., "$")
    String cleanedString = formattedNumber.replaceAll(RegExp(r'[^\d.]'), '');

    // Convert the cleaned string to a double
    return double.tryParse(cleanedString) ?? 0.0;  // Return 0.0 if parsing fails
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orders = GetIt.instance.get<OrdersService>().orders;
    double totalSales = orders.fold(0.0, (sum, order) => sum + removeFormatting(order.price ?? '0'));
    double averageOrderValue = totalSales / orders.length;
    double maxOrderValue = orders.map((order) => removeFormatting(order.price ?? '0')).reduce((a, b) => a > b ? a : b);

    var statusCount = {
      'Ordered': 0,
      'Delivered': 0,
      'Returned': 0,
    };

    for (var order in orders) {
      statusCount[order.status?.name ?? 'Unknown'] = statusCount[order.status?.name ?? 'Unknown']??0 + 1;
    }

    Map<String, int> timeOfDayDistribution = {
      'Morning (12 AM - 6 AM)': 0,
      'Afternoon (6 AM - 12 PM)': 0,
      'Evening (12 PM - 6 PM)': 0,
      'Night (6 PM - 12 AM)': 0,
    };

    for (var order in orders) {
      DateTime dateTime = DateTime.parse(order.registered ?? '-');
      if (dateTime.hour >= 0 && dateTime.hour < 6) {
        timeOfDayDistribution['Morning (12 AM - 6 AM)']= timeOfDayDistribution['Morning (12 AM - 6 AM)']!+1;
      } else if (dateTime.hour >= 6 && dateTime.hour < 12) {
        timeOfDayDistribution['Afternoon (6 AM - 12 PM)'] = timeOfDayDistribution['Afternoon (6 AM - 12 PM)']!+1;
      } else if (dateTime.hour >= 12 && dateTime.hour < 18) {
        timeOfDayDistribution['Evening (12 PM - 6 PM)']= timeOfDayDistribution['Evening (12 PM - 6 PM)']!+1;
      } else {
        timeOfDayDistribution['Night (6 PM - 12 AM)']= timeOfDayDistribution['Night (6 PM - 12 AM)']!+1;
      }
    }
    int activeOrders = orders.where((order) => order.isActive ?? false).length;
    int inactiveOrders = orders.length - activeOrders;

    double activePercentage = (activeOrders / orders.length) * 100;
    double inactivePercentage = (inactiveOrders / orders.length) * 100;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: SfCartesianChart(
              legend: const Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <LineSeries<OrderData, String>>[
                LineSeries<OrderData, String>(
                  name: 'Orders',
                  dataSource: _chartData,
                  xValueMapper: (OrderData data, _) => data.time,
                  yValueMapper: (OrderData data, _) => data.orderCount,
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                title: AxisTitle(text: 'Number of Orders'),
              ),
            ),
          ),
          // Additional Stats
          SizedBox(height: 16),
          Text('Total Orders: ${orders.length}'),
          Text('Total Sales: \$${totalSales.toStringAsFixed(2)}'),
          Text('Average Order Value: \$${averageOrderValue.toStringAsFixed(2)}'),
          Text('Highest Order Value: \$${maxOrderValue.toStringAsFixed(2)}'),

          SizedBox(height: 16),
          Text('Orders by Status'),
          Text('Ordered: ${statusCount['Ordered']}'),
          Text('Delivered: ${statusCount['Delivered']}'),
          Text('Returned: ${statusCount['Returned']}'),
          SizedBox(height: 16),
          Text('Active/Inactive Orders'),
          Text('Active: $activeOrders (${activePercentage.toStringAsFixed(2)}%)'),
          Text('Inactive: $inactiveOrders (${inactivePercentage.toStringAsFixed(2)}%)'),


          SizedBox(height: 16),
          Text('Orders by Time of Day'),
          Text('Morning: ${timeOfDayDistribution['Morning (12 AM - 6 AM)']}'),
          Text('Afternoon: ${timeOfDayDistribution['Afternoon (6 AM - 12 PM)']}'),
          Text('Evening: ${timeOfDayDistribution['Evening (12 PM - 6 PM)']}'),
          Text('Night: ${timeOfDayDistribution['Night (6 PM - 12 AM)']}'),


        ],
      ),
    );
  }

  // Function to extract the hour part from the datetime string
  String extractHour(String dateString) {
    // Parse the ISO 8601 string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Return the hour in 'hh a' format (12-hour clock with AM/PM)
    return DateFormat('h a').format(dateTime);
  }
}

// Data model for the chart
class OrderData {
  final String time;
  final int orderCount;

  OrderData(this.time, this.orderCount);
}
