import 'package:flutter_test/flutter_test.dart';
import 'package:insight_orders/core/constants/strings.dart';
import 'package:insight_orders/features/orders/repositories/orders_repository.dart';
import 'package:insight_orders/core/exceptions/exception.dart';
import 'package:insight_orders/features/orders/models/order_status.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock for IAssetLoader
class MockAssetLoader extends Mock implements IAssetLoader {}

void main() {
  late OrdersRepository ordersRepository;
  late MockAssetLoader mockAssetLoader;

  setUp(() {
    // Initialize the mock and the repository
    mockAssetLoader = MockAssetLoader();
    ordersRepository = OrdersRepository(assetLoader: mockAssetLoader);
  });

  group('OrdersRepository', () {
    test('should call asset loader and parse JSON in getOrders', () async {
      // Arrange: Mock the asset loader to return a predefined JSON string
      when(() => mockAssetLoader.loadString(ConstStrings.ordersDataFilePath))
          .thenAnswer((_) async => '''
        [
          {"id": "1", "price": "100.0", "company": "Company A", "buyer": "Buyer A", "status": "ordered", "registered": "2024-01-01", "isActive": true, "tags": ["tag1", "tag2"], "picture": "image.jpg"},
          {"id": "2", "price": "150.0", "company": "Company B", "buyer": "Buyer B", "status": "delivered", "registered": "2024-01-02", "isActive": false, "tags": ["tag3", "tag4"], "picture": "image2.jpg"}
        ]
      ''');

      // Act: Call getOrders
      final orders = await ordersRepository.getOrders();

      // Assert: Verify that the parsed orders match the expected result
      expect(orders.length, 2);
      expect(orders[0].id, '1');
      expect(orders[0].status, OrderStatus.ordered);
      expect(orders[1].status, OrderStatus.delivered);
    });

    test('should throw FormatException if JSON is malformed', () async {
      // Arrange: Mock the asset loader to return malformed JSON
      when(() => mockAssetLoader.loadString(ConstStrings.ordersDataFilePath))
          .thenAnswer((_) async => '''
        [
          {"id": "1", "price": "100.0", "company": "Company A", "buyer": "Buyer A", "status": "ordered", "registered": "2024-01-01", "isActive": true, "tags": ["tag1", "tag2"], "picture": "image.jpg"},
          {"id": "2", "price": "150.0", "company": "Company B", "buyer": "Buyer B", "status": "delivered", "registered": "2024-01-02", "isActive": false, "tags": ["tag3", "tag4"], "picture": "image2.jpg"
        ''');

      // Act & Assert: Expecting the getOrders function to throw a FormatException
      expect(() async => await ordersRepository.getOrders(),
          throwsA(isA<FormatException>()));
    });

    test('should return an empty list if JSON is empty', () async {
      // Arrange: Mock the asset loader to return an empty JSON array
      when(() => mockAssetLoader.loadString(ConstStrings.ordersDataFilePath))
          .thenAnswer((_) async => '[]');

      // Act: Call getOrders
      final orders = await ordersRepository.getOrders();

      // Assert: Verify that the result is an empty list
      expect(orders, isEmpty);
    });

    test('should throw InvalidStatusException if status is invalid', () async {
      // Arrange: Mock the asset loader to return JSON with an invalid status
      when(() => mockAssetLoader.loadString(ConstStrings.ordersDataFilePath))
          .thenAnswer((_) async => '''
        [
          {"id": "1", "price": "100.0", "company": "Company A", "buyer": "Buyer A", "status": "invalid_status", "registered": "2024-01-01", "isActive": true, "tags": ["tag1", "tag2"], "picture": "image.jpg"}
        ]
      ''');

      // Act & Assert: Expecting the getOrders function to throw an InvalidStatusException
      expect(() async => await ordersRepository.getOrders(),
          throwsA(isA<InvalidStatusException>()));
    });
  });
}
