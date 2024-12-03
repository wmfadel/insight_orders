import 'package:flutter/material.dart';
import 'package:insight_orders/core/constants/localization_keys.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';

extension XErrorMessage on BuildContext {
  showError({String? message}) {
    ErrorMessage.show(this, message: message);
  }
}

class ErrorMessage {
  static show(BuildContext context, {String? message}) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? context.translate(L10nKeys.someThingWentWrong),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
