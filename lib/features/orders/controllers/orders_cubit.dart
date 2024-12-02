import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required OrdersService ordersService,
  })  : _ordersService = ordersService,
        super(OrdersInitial());

  final OrdersService _ordersService;

  List<Order> get orders => _ordersService.orders;

  Future<void> loadOrders() async {
    emit(OrdersLoading());
    try {
      await _ordersService.getOrders();
      emit(OrdersCompleted(orders: _ordersService.orders));
    } catch (e) {
      /// This should have exception specific cases for each type of expected
      /// exceptions with custom handling if needed, but here the example is
      /// simple no need to introduce more levels of error handling
      emit(const OrdersError());
    }
  }
}
