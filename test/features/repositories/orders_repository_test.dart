import 'package:flutter_test/flutter_test.dart';
import 'package:insight_orders/core/exceptions/exception.dart';
import 'package:insight_orders/features/models/order_status.dart';
import 'package:insight_orders/features/repositories/orders_repository.dart';

void main() {
  late OrdersRepository ordersRepository;

  // Create a mock AssetLoader function that returns predefined JSON
  Future<String> mockAssetLoader(String key) {
    return Future.value('''
      [
        {"id": "1", "price": "100.0", "company": "Company A", "buyer": "Buyer A", "status": "ordered", "registered": "2024-01-01", "isActive": true, "tags": ["tag1", "tag2"], "picture": "image.jpg"},
        {"id": "2", "price": "150.0", "company": "Company B", "buyer": "Buyer B", "status": "delivered", "registered": "2024-01-02", "isActive": false, "tags": ["tag3", "tag4"], "picture": "image2.jpg"}
      ]
    ''');
  }

  setUp(() {
    // Inject the mock AssetLoader function into the repository
    ordersRepository = OrdersRepository(assetLoader: mockAssetLoader);
  });

  group('OrdersRepository', () {
    test('should call asset loader and parse JSON in getOrders', () async {
      // Call getOrders
      final orders = await ordersRepository.getOrders();

      // Test that the parsed orders match the expected result
      expect(orders.length, 2);
      expect(orders[0].id, '1');
      expect(orders[0].status, OrderStatus.ordered);
      expect(orders[1].status, OrderStatus.delivered);
    });

    test('should throw FormatException if JSON is malformed', () async {
      // Custom mock function that returns malformed JSON
      Future<String> malformedMockLoader(String key) {
        return Future.value('''
          [
            {"id": "1", "price": "100.0", "company": "Company A", "buyer": "Buyer A", "status": "ordered", "registered": "2024-01-01", "isActive": true, "tags": ["tag1", "tag2"], "picture": "image.jpg"},
            {"id": "2", "price": "150.0", "company": "Company B", "buyer": "Buyer B", "status": "delivered", "registered": "2024-01-02", "isActive": false, "tags": ["tag3", "tag4"], "picture": "image2.jpg"
        ''');
      }

      // Inject the malformed mock function into the repository
      ordersRepository = OrdersRepository(assetLoader: malformedMockLoader);

      // Expecting the getOrders function to throw a FormatException
      expect(() async => await ordersRepository.getOrders(),
          throwsA(isA<FormatException>()));
    });

    test('should return an empty list if JSON is empty', () async {
      // Mock function returning an empty JSON array
      Future<String> emptyJsonMockLoader(String key) {
        return Future.value('[]');
      }

      // Inject the empty JSON mock function into the repository
      ordersRepository = OrdersRepository(assetLoader: emptyJsonMockLoader);

      // Call getOrders
      final orders = await ordersRepository.getOrders();

      // Verify that the result is an empty list
      expect(orders, isEmpty);
    });

    test('should throw InvalidStatusException if status is invalid', () async {
      // Custom mock function with invalid status in JSON
      Future<String> invalidStatusMockLoader(String key) {
        return Future.value('''
          [
            {"id": "1", "price": "100.0", "company": "Company A", "buyer": "Buyer A", "status": "invalid_status", "registered": "2024-01-01", "isActive": true, "tags": ["tag1", "tag2"], "picture": "image.jpg"}
          ]
        ''');
      }

      // Inject the invalid status mock function into the repository
      ordersRepository = OrdersRepository(assetLoader: invalidStatusMockLoader);

      // Expecting the getOrders function to throw an InvalidStatusException
      expect(() async => await ordersRepository.getOrders(),
          throwsA(isA<InvalidStatusException>()));
    });
  });
}
