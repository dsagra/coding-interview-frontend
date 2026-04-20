import 'package:coding_interview_frontend/src/core/services/orderbook_recommendations_service.dart';
import 'package:coding_interview_frontend/src/core/setup/service_locator.dart';
import 'package:coding_interview_frontend/src/features/home/domain/repositories/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await getIt.reset();
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('registers required dependencies', () {
    setupServiceLocator();

    expect(getIt.isRegistered<Dio>(), isTrue);
    expect(getIt.isRegistered<OrderbookRecommendationsService>(), isTrue);
    expect(getIt.isRegistered<HomeRepository>(), isTrue);
  });

  test('is idempotent when called more than once', () {
    setupServiceLocator();

    final dioInstance = getIt<Dio>();
    final recommendationsService = getIt<OrderbookRecommendationsService>();
    final homeRepository = getIt<HomeRepository>();

    setupServiceLocator();

    expect(identical(getIt<Dio>(), dioInstance), isTrue);
    expect(
      identical(
        getIt<OrderbookRecommendationsService>(),
        recommendationsService,
      ),
      isTrue,
    );
    expect(identical(getIt<HomeRepository>(), homeRepository), isTrue);
  });
}
