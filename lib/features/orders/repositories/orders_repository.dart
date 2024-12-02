import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:insight_orders/core/constants/strings.dart';
import 'package:insight_orders/features/orders/models/order.dart';

/// AssetLoader typedef to safely inject the `rootBundle.loadString` function
/// for usage without tight coupling simplifying testing
typedef AssetLoader = Future<String> Function(String key);

class OrdersRepository {
  final AssetLoader _assetLoader;

  OrdersRepository({AssetLoader? assetLoader})
      : _assetLoader = assetLoader ?? rootBundle.loadString;

  // Function to parse the JSON string into a list of orders
  static Future<List<Order>> _parseOrders(String jsonString) async {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((item) => Order.fromJson(item)).toList();
  }

  // Function to get orders using compute for isolate-based background work
  Future<List<Order>> getOrders() async {
    // Load the JSON file from the assets
    final String response = await _assetLoader(ConstStrings.ordersDataFilePath);

    // Use compute to run the _parseOrders function in a background isolate
    return compute(_parseOrders, response);
  }
}
