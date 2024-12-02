import 'package:flutter/material.dart';
import 'package:insight_orders/core/services/locator.dart';
import 'package:insight_orders/insight_orders_app.dart';

void main() {
  Locator().setupLocator();
  runApp(const InsightOrdersApp());
}

