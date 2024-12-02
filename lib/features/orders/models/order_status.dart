import 'package:insight_orders/core/exceptions/exception.dart';

enum OrderStatus {
  ordered,
  delivered,
  returned,
}

OrderStatus? orderStatusFromString(String status) {
  return switch (status.toLowerCase()) {
    'ordered' => OrderStatus.ordered,
    'delivered' => OrderStatus.delivered,
    'returned' => OrderStatus.returned,
    _ => throw InvalidStatusException(),
  };
}
