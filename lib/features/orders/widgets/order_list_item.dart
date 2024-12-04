import 'package:flutter/material.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/core/theme/colors.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/models/order_status.dart';

class OrderListItem extends StatelessWidget {
  final Order order;

  const OrderListItem({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Semantics(
              label:
                  '${context.translate(L10nKeys.orderImageFor)} ${order.company ?? context.translate(L10nKeys.unknown)}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  order.picture ?? '',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company and Buyer Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.company ?? '-',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Semantics(
                        label:
                            '${context.translate(L10nKeys.price)}: ${order.price ?? "-"}',
                        child: Text(
                          order.price ?? '-',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _statusColor(context, order.status),
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${context.translate(L10nKeys.by)}: ${order.buyer ?? '-'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(context, order.status)
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Semantics(
                          label:
                              '${context.translate(L10nKeys.orderStatus)}: ${order.status?.name ?? "-"}',
                          child: Text(
                            order.status?.name ?? '-',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Status & Tags
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: (order.tags ?? [])
                                .map((tag) => Container(
                                      padding: const EdgeInsets.all(4),
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withOpacity(0.25),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Text(tag),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Registration Date and Active Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${context.translate(L10nKeys.registered)}: ${order.registered?.split('T')[0]}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.onSurface),
                      ),
                      Semantics(
                        label: context.translate((order.isActive ?? false)
                            ? L10nKeys.activeOrder
                            : L10nKeys.inactiveOrder),
                        child: Icon(
                          (order.isActive ?? false)
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: (order.isActive ?? false)
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context, OrderStatus? status) {
    return switch (status ?? OrderStatus.ordered) {
      OrderStatus.ordered => AppColors.statusOrdered,
      OrderStatus.delivered => AppColors.statusDelivered,
      OrderStatus.returned => AppColors.statusReturned
    };
  }
}
