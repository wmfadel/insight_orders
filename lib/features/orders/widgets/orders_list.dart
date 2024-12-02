import 'package:flutter/material.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:insight_orders/features/orders/widgets/order_list_item.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;

  const OrdersList({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Animate(
          // This will animate the item sliding from the right
          effects: const [
            SlideEffect(
              begin: Offset(1.0, 0.0), // (off-screen to the right)
              end: Offset.zero,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
            FadeEffect(
              begin: 0.0,
              end: 1.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
          ],
          child: OrderListItem(
            order: orders[index],
            key: Key('order-${orders[index].id}'),
          ),
        );
      },
    );
  }
}
