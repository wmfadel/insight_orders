import 'package:flutter_test/flutter_test.dart';
import 'package:insight_orders/features/models/order.dart';
import 'package:insight_orders/features/models/order_status.dart';

void main() {
  group('Order', () {
    // Test for `fromJson` constructor
    test('should create Order from JSON', () {
      // Sample JSON to create Order (using the new format)
      final json = {
        "id": "617ec833bef0e90a852d5b6d",
        "isActive": false,
        "price": "\$3,066.58",
        "company": "WARETEL",
        "picture": "http://placehold.it/32x32",
        "buyer": "Marcia Weiss",
        "tags": [
          "#proident",
          "#magna",
          "#eiusmod",
          "#fugiat",
          "#sunt",
          "#excepteur",
          "#ullamco"
        ],
        "status": "RETURNED",
        "registered": "2021-01-15T01:37:46 -02:00"
      };

      // Create the Order object using fromJson
      final order = Order.fromJson(json);

      // Assert that all fields are correctly parsed from the JSON
      expect(order.id, '617ec833bef0e90a852d5b6d');
      expect(order.isActive, false);
      expect(order.price, '\$3,066.58');
      expect(order.company, 'WARETEL');
      expect(order.picture, 'http://placehold.it/32x32');
      expect(order.buyer, 'Marcia Weiss');
      expect(order.tags, [
        '#proident',
        '#magna',
        '#eiusmod',
        '#fugiat',
        '#sunt',
        '#excepteur',
        '#ullamco'
      ]);
      expect(order.status, OrderStatus.returned); // Ensure "RETURNED" is mapped to OrderStatus.returned
      expect(order.registered, '2021-01-15T01:37:46 -02:00');
    });

    // Test for `copyWith` method
    test('should create a copy of Order with updated fields', () {
      // Create the initial Order object
      final originalOrder = Order(
        id: '617ec833bef0e90a852d5b6d',
        isActive: false,
        price: '\$3,066.58',
        company: 'WARETEL',
        picture: 'http://placehold.it/32x32',
        buyer: 'Marcia Weiss',
        tags: const [
          '#proident',
          '#magna',
          '#eiusmod',
          '#fugiat',
          '#sunt',
          '#excepteur',
          '#ullamco'
        ],
        status: OrderStatus.returned,
        registered: '2021-01-15T01:37:46 -02:00',
      );

      // Create a copy of the Order with some fields changed
      final updatedOrder = originalOrder.copyWith(price: '\$4,000.00', status: OrderStatus.delivered);

      // Assert that the fields are updated correctly
      expect(updatedOrder.id, '617ec833bef0e90a852d5b6d');
      expect(updatedOrder.isActive, false);
      expect(updatedOrder.price, '\$4,000.00');
      expect(updatedOrder.company, 'WARETEL');
      expect(updatedOrder.picture, 'http://placehold.it/32x32');
      expect(updatedOrder.buyer, 'Marcia Weiss');
      expect(updatedOrder.tags, [
        '#proident',
        '#magna',
        '#eiusmod',
        '#fugiat',
        '#sunt',
        '#excepteur',
        '#ullamco'
      ]);
      expect(updatedOrder.status, OrderStatus.delivered);
      expect(updatedOrder.registered, '2021-01-15T01:37:46 -02:00');
    });

    // Test for `toJson` method
    test('should convert Order to JSON', () {
      // Create an Order object
      final order = Order(
        id: '617ec833bef0e90a852d5b6d',
        isActive: false,
        price: '\$3,066.58',
        company: 'WARETEL',
        picture: 'http://placehold.it/32x32',
        buyer: 'Marcia Weiss',
        tags: const [
          '#proident',
          '#magna',
          '#eiusmod',
          '#fugiat',
          '#sunt',
          '#excepteur',
          '#ullamco'
        ],
        status: OrderStatus.returned,
        registered: '2021-01-15T01:37:46 -02:00',
      );

      // Convert the Order object back to JSON
      final json = order.toJson();

      // Assert that the JSON matches the Order object fields
      expect(json['id'], '617ec833bef0e90a852d5b6d');
      expect(json['isActive'], false);
      expect(json['price'], '\$3,066.58');
      expect(json['company'], 'WARETEL');
      expect(json['picture'], 'http://placehold.it/32x32');
      expect(json['buyer'], 'Marcia Weiss');
      expect(json['tags'], [
        '#proident',
        '#magna',
        '#eiusmod',
        '#fugiat',
        '#sunt',
        '#excepteur',
        '#ullamco'
      ]);
      expect(json['status'], 'returned'); // Enum's string value
      expect(json['registered'], '2021-01-15T01:37:46 -02:00');
    });

    // Test for `Equatable` equality check
    test('should be equal when two Orders have the same data', () {
      // Create two identical Order objects
      final order1 = Order(
        id: '617ec833bef0e90a852d5b6d',
        isActive: false,
        price: '\$3,066.58',
        company: 'WARETEL',
        picture: 'http://placehold.it/32x32',
        buyer: 'Marcia Weiss',
        tags: const [
          '#proident',
          '#magna',
          '#eiusmod',
          '#fugiat',
          '#sunt',
          '#excepteur',
          '#ullamco'
        ],
        status: OrderStatus.returned,
        registered: '2021-01-15T01:37:46 -02:00',
      );

      final order2 = Order(
        id: '617ec833bef0e90a852d5b6d',
        isActive: false,
        price: '\$3,066.58',
        company: 'WARETEL',
        picture: 'http://placehold.it/32x32',
        buyer: 'Marcia Weiss',
        tags: const [
          '#proident',
          '#magna',
          '#eiusmod',
          '#fugiat',
          '#sunt',
          '#excepteur',
          '#ullamco'
        ],
        status: OrderStatus.returned,
        registered: '2021-01-15T01:37:46 -02:00',
      );

      // Assert that both orders are considered equal
      expect(order1, equals(order2));
    });

    // Test for `Equatable` inequality check
    test('should be unequal when two Orders have different data', () {
      // Create two different Order objects
      final order1 = Order(
        id: '617ec833bef0e90a852d5b6d',
        isActive: false,
        price: '\$3,066.58',
        company: 'WARETEL',
        picture: 'http://placehold.it/32x32',
        buyer: 'Marcia Weiss',
        tags: const [
          '#proident',
          '#magna',
          '#eiusmod',
          '#fugiat',
          '#sunt',
          '#excepteur',
          '#ullamco'
        ],
        status: OrderStatus.returned,
        registered: '2021-01-15T01:37:46 -02:00',
      );

      final order2 = Order(
        id: '617ec833bef0e90a852d5b6d', // Same ID
        isActive: true, // Different value
        price: '\$3,000.00', // Different price
        company: 'NEW COMPANY', // Different company
        picture: 'http://placehold.it/64x64', // Different picture
        buyer: 'New Buyer', // Different buyer
        tags: const ['#newtag'], // Different tags
        status: OrderStatus.delivered, // Different status
        registered: '2021-01-15T01:37:46 -02:00', // Same date
      );

      // Assert that the orders are considered unequal
      expect(order1, isNot(equals(order2)));
    });
  });
}
