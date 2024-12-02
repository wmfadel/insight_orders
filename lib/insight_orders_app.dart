import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:insight_orders/core/localization/controller/localization_cubit.dart';
import 'package:insight_orders/router/app_router.dart';

import 'core/localization/app_localizations.dart';

class InsightOrdersApp extends StatelessWidget {
  const InsightOrdersApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCubit = GetIt.instance.get<LocalizationCubit>();
    return MaterialApp.router(
      title: 'Insight Orders',
      routerConfig: AppRouter().router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      locale: localizationCubit.locale,
      supportedLocales: const [Locale('en')],
    );
  }
}
