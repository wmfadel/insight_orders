import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/repositories/orders_repository.dart';

class OrdersService {
  final OrdersRepository _ordersRepository;

  OrdersService({OrdersRepository? ordersRepository})
      : _ordersRepository = ordersRepository ?? OrdersRepository();

  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> getOrders() async {
    final orders = await _ordersRepository.getOrders();
    _orders = orders;
  }
}
