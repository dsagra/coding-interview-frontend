import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../services/orderbook_recommendations_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<OrderbookRecommendationsService>(
    () => OrderbookRecommendationsService(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<HomeRepository>(HomeRepositoryImpl.new);
}
