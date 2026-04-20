// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderbook_recommendations_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orderbookRecommendationsService)
final orderbookRecommendationsServiceProvider =
    OrderbookRecommendationsServiceProvider._();

final class OrderbookRecommendationsServiceProvider
    extends
        $FunctionalProvider<
          OrderbookRecommendationsService,
          OrderbookRecommendationsService,
          OrderbookRecommendationsService
        >
    with $Provider<OrderbookRecommendationsService> {
  OrderbookRecommendationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderbookRecommendationsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderbookRecommendationsServiceHash();

  @$internal
  @override
  $ProviderElement<OrderbookRecommendationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OrderbookRecommendationsService create(Ref ref) {
    return orderbookRecommendationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderbookRecommendationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderbookRecommendationsService>(
        value,
      ),
    );
  }
}

String _$orderbookRecommendationsServiceHash() =>
    r'fa21b53128bb4fa50fa07ea304624d7a1a30a6fc';
