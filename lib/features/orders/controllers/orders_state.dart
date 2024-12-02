part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();
}

final class OrdersInitial extends OrdersState {
  @override
  List<Object> get props => [];
}

final class OrdersLoading extends OrdersState {
  @override
  List<Object> get props => [];
}

final class OrdersCompleted extends OrdersState {
  final List<Order> orders;

  const OrdersCompleted({required this.orders});

  @override
  List<Object> get props => [orders];
}

final class OrdersError extends OrdersState {
  final String? errorMessageKey;

  const OrdersError({this.errorMessageKey});

  @override
  List<Object?> get props => [errorMessageKey];
}
