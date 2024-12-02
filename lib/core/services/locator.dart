import 'package:get_it/get_it.dart';
import 'package:insight_orders/core/localization/controller/localization_cubit.dart';

import 'local_cache.dart';

class Locator {
  setupLocator() {
    final ICacheProvider cacheProvider = CacheProviderImpl();
    final cache = LocalCache(cacheProvider);
    GetIt.instance.registerSingleton<LocalCache>(cache);
    GetIt.instance.registerSingleton<LocalizationCubit>(
      LocalizationCubit(cache: cache),
    );
  }
}
