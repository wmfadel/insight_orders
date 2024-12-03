import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:insight_orders/features/orders/models/order.dart';
import 'package:insight_orders/features/orders/repositories/orders_repository.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';

// Mock classes
class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late OrdersService ordersService;
  late MockOrdersRepository mockOrdersRepository;
  late List<Order> mockOrders;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
    ordersService = OrdersService(ordersRepository: mockOrdersRepository);

    mockOrders = [
      Order(
        price: "\$3,164.16",
        registered: "2021-05-15T12:48:03 -02:00",
        isActive: true,
      ),
      Order(
        price: "\$1,150.99",
        registered: "2021-05-15T13:15:03 -02:00",
        isActive: false,
      ),
      Order(
        price: "\$5,200.50",
        registered: "2021-05-15T14:30:03 -02:00",
        isActive: true,
      ),
    ];

    when(() => mockOrdersRepository.getOrders())
        .thenAnswer((_) async => mockOrders);
  });

  group('OrdersService', () {
    test('should fetch orders and populate the chart data', () async {
      await ordersService.getOrders();

      expect(ordersService.orders.length, 3);
      expect(ordersService.chartData.length, 24);
    });

    test('should calculate total sales correctly', () async {
      await ordersService.getOrders();
      final totalSales = ordersService.totalSales;

      expect(totalSales, 9515.65);
    });

    test('should calculate average order value correctly', () async {
      await ordersService.getOrders();
      final averageOrderValue = ordersService.averageOrderValue;

      expect(averageOrderValue.toStringAsFixed(2), 3171.88.toStringAsFixed(2));
    });

    test('should calculate max order value correctly', () async {
      await ordersService.getOrders();
      final maxOrderValue = ordersService.maxOrderValue;

      expect(maxOrderValue, 5200.50);
    });

    test('should calculate active orders correctly', () async {
      await ordersService.getOrders();
      final activeOrders = ordersService.activeOrders;

      expect(activeOrders, 2);
    });

    test('should calculate inactive orders correctly', () async {
      await ordersService.getOrders();
      final inactiveOrders = ordersService.inactiveOrders;

      expect(inactiveOrders, 1);
    });

    test('should calculate active percentage correctly', () async {
      await ordersService.getOrders();
      final activePercentage = ordersService.activePercentage;

      expect(activePercentage.toStringAsFixed(2), 66.67.toStringAsFixed(2));
    });

    test('should calculate inactive percentage correctly', () async {
      await ordersService.getOrders();
      final inactivePercentage = ordersService.inactivePercentage;

      expect(inactivePercentage.toStringAsFixed(2), 33.33.toStringAsFixed(2));
    });

    test('should return time of day distribution correctly', () async {
      await ordersService.getOrders();
      final distribution = ordersService.timeOfDayDistributions();

      // Based on the registered times, we expect:
      // - 0 orders in Morning (12 AM - 6 AM)
      // - 0 orders in Afternoon (6 AM - 12 PM)
      // - 3 orders in Evening (12 PM - 6 PM) (this would depend on time of the day from the mock)
      // - 0 orders in Night (6 PM - 12 AM)

      expect(distribution['Morning (12 AM - 6 AM)'], 0);
      expect(distribution['Afternoon (6 AM - 12 PM)'], 0);
      expect(distribution['Evening (12 PM - 6 PM)'], 3);
      expect(distribution['Night (6 PM - 12 AM)'], 0);
    });
  });
}
