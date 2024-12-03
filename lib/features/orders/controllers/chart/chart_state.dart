part of 'chart_cubit.dart';

sealed class ChartState extends Equatable {
  const ChartState();
}

final class ChartInitial extends ChartState {
  @override
  List<Object> get props => [];
}
