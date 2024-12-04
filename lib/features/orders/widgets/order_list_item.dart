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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Image Section
                Semantics(
                  label:
                      '${context.translate(L10nKeys.orderImageFor)} ${order.company ?? context.translate(L10nKeys.unknown)}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
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
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.company ?? '-',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${context.translate(L10nKeys.by)}: ${order.buyer ?? '-'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(context, order.status).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
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
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ItemData(
                    label: context.translate(L10nKeys.price),
                    value: order.price ?? '-'),
                _ItemData(
                    label: context.translate(L10nKeys.registered),
                    value: order.registered?.split('T')[0] ?? '-'),
                // _ItemData(
                //     label:'Active',// context.translate(L10nKeys.registered),
                //     value:order.isActive==true?'Yes':'No'),
              ],
            ),
            const SizedBox(height: 8),
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
                                    color: AppColors.primary.withOpacity(0.25),
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

class _ItemData extends StatelessWidget {
  final String label;
  final String value;

  const _ItemData({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.grey)),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
