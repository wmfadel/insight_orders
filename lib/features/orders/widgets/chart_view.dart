import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insight_orders/features/orders/controllers/chart/chart_cubit.dart';
import 'package:insight_orders/features/orders/models/chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart'; // For date formatting

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  BehaviorSubject<(String, String)?> hoveredValue =
      BehaviorSubject.seeded(null);

  @override
  void dispose() {
    hoveredValue.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChartCubit>();

    // Convert the OrderData to FlSpot
    List<FlSpot> spots = cubit.chartData.map((OrderData data) {
      // Parse the time string like "1 AM", "2 PM", etc. into a DateTime object
      DateTime time = DateFormat("h a")
          .parse(data.time); // "h a" parses time in "1 AM", "2 PM" format

      // We will use the number of minutes since midnight for X-axis
      int minutesSinceMidnight = time.hour * 60 + time.minute;

      return FlSpot(
        minutesSinceMidnight.toDouble(),
        // Convert the time to the number of minutes since midnight
        data.orderCount.toDouble(),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
              stream: hoveredValue.stream,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: snapshot.data == null
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              snapshot.data!.$1,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              '${snapshot.data!.$2}\$',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                );
              }),
        ),
        Expanded(
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: spots.isNotEmpty ? spots.first.x : 0,
              maxX: spots.isNotEmpty ? spots.last.x : 1440,
              minY: 0,
              maxY: spots.isNotEmpty
                  ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 5
                  : 10,
              lineBarsData: [
                LineChartBarData(
                  spots: spots, // Pass the FlSpot data
                  isCurved: false, // Curve the line
                  color: Colors.blue, // Line color
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.1),
                  ), // Color for the area below the line
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => Colors.black54,
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      final timeInMinutes = spot.x.toInt();
                      final hours = (timeInMinutes ~/ 60) % 24;
                      final minutes = timeInMinutes % 60;
                      final formattedTime = DateFormat("h:mm a")
                          .format(DateTime(0, 0, 0, hours, minutes));
                      return LineTooltipItem(
                        'Time: $formattedTime\nOrders: ${spot.y.toInt()}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                  if (touchResponse?.lineBarSpots != null) {
                    final spot = touchResponse!.lineBarSpots!.first;
                    final timeInMinutes = spot.x.toInt();
                    final hours = (timeInMinutes ~/ 60) % 24;
                    final minutes = timeInMinutes % 60;
                    final formattedTime = DateFormat("h:mm a")
                        .format(DateTime(0, 0, 0, hours, minutes));

                    hoveredValue
                        .add((formattedTime, spot.y.toInt().toString()));
                  } else {
                    hoveredValue.add(null);
                  }
                },
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
