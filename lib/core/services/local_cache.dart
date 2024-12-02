import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insight_orders/core/utils/app_logger.dart';

class LocalCache {
  final ICacheProvider _cacheProvider;

  LocalCache(this._cacheProvider);

  final String _languageKey = 'language';

  Future<String?> getLanguage() async {
    try {
      return await _cacheProvider.read(key: _languageKey);
    } on Exception catch (e) {
      AppLogger.e(e);
      return null;
    }
  }

  Future<void> setLanguage(String language) async {
    try {
      return _cacheProvider.write(key: _languageKey, value: language);
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }
}

abstract class ICacheProvider {
  Future<String?> read({required String key});

  Future<void> write({required String key, required String value});
}

class CacheProviderImpl implements ICacheProvider {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    return await _storage.write(key: key, value: value);
  }
}
