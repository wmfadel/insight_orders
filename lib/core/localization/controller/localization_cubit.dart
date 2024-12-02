import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insight_orders/core/localization/app_localizations.dart';
import 'package:insight_orders/core/services/local_cache.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final LocalCache _localCache;

  LocalizationCubit({required LocalCache cache})
      : _localCache = cache,
        super(LocalizationInitial()) {
    _localCache.getLanguage().then((value) {
      if (value != null) {
        setLocale(Locale(value));
      }
    });
  }

  Locale _locale = AppLocalizations.supportedLocales.first;

  List<Locale> supportedLocales = AppLocalizations.supportedLocales;

  Locale get locale => _locale;

  setLocale(Locale value) async {
    if (AppLocalizations.supportedLocales.contains(value)) {
      _locale = value;
      AppLocalizations.instance?.local = value;
    }

    await _localCache.setLanguage(value.languageCode);

    emit(LocalizationUpdate(value));
  }
}
