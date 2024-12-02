import 'package:flutter/material.dart';

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
          message ?? 'Something went wrong', // TODO localize
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
