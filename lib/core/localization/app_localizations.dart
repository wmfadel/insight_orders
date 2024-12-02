import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension XAppLocalizations on BuildContext {
  AppLocalizations get localization =>
      AppLocalizations.of(this) ?? AppLocalizations(const Locale('en'));

  String translate(String key) {
    return localization.translate(key);
  }
}

class AppLocalizations {
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? get instance => _AppLocalizationsDelegate.instance;
  Locale locale;

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
  ];

  set local(Locale locale) {
    this.locale = locale;
  }

  Map<String, String> _localizedStrings = {};

  Future<void> _fetchLocalTranslation() async {
    String jsonString = await rootBundle
        .loadString('assets/language/${locale.languageCode}.json');
    _localTranslation = json.decode(jsonString);
  }

  Map<String, dynamic> _localTranslation = {};
  String jsonString = '';

  Future<void> load() async {
    await _fetchLocalTranslation();
    _localizedStrings = _localTranslation.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    return _localizedStrings[key] ?? '';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .any((element) => element == locale);
  }

  static AppLocalizations? instance;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    instance = localizations;
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
