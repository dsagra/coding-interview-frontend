// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository>
    with $Provider<HomeRepository> {
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'ce9ee2d8cf9bc68363059dbb15ca7ede14b7395e';

@ProviderFor(home)
final homeProvider = HomeProvider._();

final class HomeProvider
    extends $FunctionalProvider<AsyncValue<Home>, Home, FutureOr<Home>>
    with $FutureModifier<Home>, $FutureProvider<Home> {
  HomeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeHash();

  @$internal
  @override
  $FutureProviderElement<Home> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Home> create(Ref ref) {
    return home(ref);
  }
}

String _$homeHash() => r'019095a8016581285ead403262dcb387c750aa01';

@ProviderFor(orderbookQuote)
final orderbookQuoteProvider = OrderbookQuoteFamily._();

final class OrderbookQuoteProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrderbookQuote>,
          OrderbookQuote,
          FutureOr<OrderbookQuote>
        >
    with $FutureModifier<OrderbookQuote>, $FutureProvider<OrderbookQuote> {
  OrderbookQuoteProvider._({
    required OrderbookQuoteFamily super.from,
    required OrderbookQuoteRequest super.argument,
  }) : super(
         retry: noProviderRetry,
         name: r'orderbookQuoteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderbookQuoteHash();

  @override
  String toString() {
    return r'orderbookQuoteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<OrderbookQuote> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OrderbookQuote> create(Ref ref) {
    final argument = this.argument as OrderbookQuoteRequest;
    return orderbookQuote(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderbookQuoteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderbookQuoteHash() => r'c8fde0a909e04cb428d337a9533bffdcddeb7ca6';

final class OrderbookQuoteFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<OrderbookQuote>,
          OrderbookQuoteRequest
        > {
  OrderbookQuoteFamily._()
    : super(
        retry: noProviderRetry,
        name: r'orderbookQuoteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrderbookQuoteProvider call(OrderbookQuoteRequest request) =>
      OrderbookQuoteProvider._(argument: request, from: this);

  @override
  String toString() => r'orderbookQuoteProvider';
}

@ProviderFor(selectableCurrencies)
final selectableCurrenciesProvider = SelectableCurrenciesProvider._();

final class SelectableCurrenciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SelectableCurrencies>,
          SelectableCurrencies,
          FutureOr<SelectableCurrencies>
        >
    with
        $FutureModifier<SelectableCurrencies>,
        $FutureProvider<SelectableCurrencies> {
  SelectableCurrenciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectableCurrenciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectableCurrenciesHash();

  @$internal
  @override
  $FutureProviderElement<SelectableCurrencies> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SelectableCurrencies> create(Ref ref) {
    return selectableCurrencies(ref);
  }
}

String _$selectableCurrenciesHash() =>
    r'78254d5b72591144db6231462b8eaac61faeffc5';
