part of 'chart_cubit.dart';

sealed class ChartState extends Equatable {
  const ChartState();
}

final class ChartInitial extends ChartState {
  @override
  List<Object> get props => [];
}

final class ChartFilterChanged extends ChartState {
 final ChartFilters filter;

  const ChartFilterChanged(this.filter);
  @override
  List<Object> get props => [filter];
}
