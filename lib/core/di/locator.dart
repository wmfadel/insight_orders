import 'package:get_it/get_it.dart';
import 'package:insight_orders/core/localization/controller/localization_cubit.dart';
import 'package:insight_orders/features/orders/services/orders_service.dart';

import '../services/local_cache.dart';

class Locator {
  setupLocator() {
    final ICacheProvider cacheProvider = CacheProviderImpl();
    final cache = LocalCache(cacheProvider);
    GetIt.instance.registerSingleton<LocalCache>(cache);
    GetIt.instance.registerSingleton<LocalizationCubit>(
      LocalizationCubit(cache: cache),
    );
    GetIt.instance.registerSingleton<OrdersService>(OrdersService());
  }
}
