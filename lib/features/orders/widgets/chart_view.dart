import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insight_orders/features/orders/controllers/chart/chart_cubit.dart';
import 'package:insight_orders/features/orders/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  late final TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChartCubit>();
    return SfCartesianChart(
      legend: const Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <LineSeries<OrderData, String>>[
        LineSeries<OrderData, String>(
          name: 'Orders',
          dataSource: cubit.chartData,
          xValueMapper: (OrderData data, _) => data.time,
          yValueMapper: (OrderData data, _) => data.orderCount,
          enableTooltip: true,
        ),
      ],
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        title: AxisTitle(text: 'Number of Orders'),
      ),
    );
  }
}
