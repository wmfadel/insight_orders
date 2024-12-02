import 'package:flutter_test/flutter_test.dart';
import 'package:insight_orders/core/exceptions/exception.dart';
import 'package:insight_orders/features/orders/models/order_status.dart';

void main() {
  group('OrderStatus', () {
    test('should return OrderStatus.ordered for "ordered"', () {
      // Test that "ordered" string is correctly parsed to OrderStatus.ordered
      expect(orderStatusFromString('ordered'), OrderStatus.ordered);
    });

    test('should return OrderStatus.delivered for "delivered"', () {
      // Test that "delivered" string is correctly parsed to OrderStatus.delivered
      expect(orderStatusFromString('delivered'), OrderStatus.delivered);
    });

    test('should return OrderStatus.returned for "returned"', () {
      // Test that "returned" string is correctly parsed to OrderStatus.returned
      expect(orderStatusFromString('returned'), OrderStatus.returned);
    });

    test('should return OrderStatus.ordered for "Ordered" (case insensitive)', () {
      // Test case insensitivity for "Ordered"
      expect(orderStatusFromString('Ordered'), OrderStatus.ordered);
    });

    test('should return OrderStatus.delivered for "DELIVERED" (case insensitive)', () {
      // Test case insensitivity for "DELIVERED"
      expect(orderStatusFromString('DELIVERED'), OrderStatus.delivered);
    });

    test('should return OrderStatus.returned for "Returned" (case insensitive)', () {
      // Test case insensitivity for "Returned"
      expect(orderStatusFromString('Returned'), OrderStatus.returned);
    });

    test('should throw InvalidStatusException for invalid status', () {
      // Test that an invalid status string throws an InvalidStatusException
      expect(() => orderStatusFromString('shipped'), throwsA(isA<InvalidStatusException>()));
      expect(() => orderStatusFromString('pending'), throwsA(isA<InvalidStatusException>()));
    });

    test('should throw InvalidStatusException for empty string', () {
      // Test that an empty string throws an InvalidStatusException
      expect(() => orderStatusFromString(''), throwsA(isA<InvalidStatusException>()));
    });
  });
}
