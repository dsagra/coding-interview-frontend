import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/fiat_currency.dart';
import '../../../../core/models/orderbook_quote.dart';
import '../../../../core/models/orderbook_quote_request.dart';
import '../../../../core/models/selectable_currencies.dart';
import '../../../../core/setup/service_locator.dart';
import '../../../../core/services/orderbook_recommendations_service.dart';
import '../../../../core/utils/amount_text_sanitizer.dart';
import '../../domain/entities/home.dart';
import '../../domain/repositories/home_repository.dart';

part 'home_provider.g.dart';

Duration? noProviderRetry(int retryCount, Object error) => null;

final homeAmountControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final controller = TextEditingController();
      ref.onDispose(controller.dispose);
      return controller;
    });

final homeScreenControllerProvider =
    NotifierProvider<HomeScreenController, HomeScreenState>(
      HomeScreenController.new,
    );

class HomeScreenController extends Notifier<HomeScreenState> {
  @override
  HomeScreenState build() {
    return const HomeScreenState();
  }

  void toggleSwap() {
    state = state.copyWith(
      isSwapped: !state.isSwapped,
      lastNoOffersToastMessage: null,
    );
  }

  void selectCurrency(FiatCurrency currency) {
    state = state.copyWith(
      selectedCurrency: currency,
      lastNoOffersToastMessage: null,
    );
  }

  void selectCrypto(FiatCurrency currency) {
    state = state.copyWith(
      selectedCrypto: currency,
      lastNoOffersToastMessage: null,
    );
  }

  void setAmountText(String amountText) {
    final sanitizedAmountText = sanitizeAmountText(amountText);

    state = state.copyWith(
      amountText: sanitizedAmountText,
      lastNoOffersToastMessage: null,
    );
  }

  void reset() {
    state = const HomeScreenState();
  }

  void clearNoOffersToastMessage() {
    if (state.lastNoOffersToastMessage == null) {
      return;
    }

    state = state.copyWith(lastNoOffersToastMessage: null);
  }

  bool shouldShowNoOffersToast(String message) {
    if (state.lastNoOffersToastMessage == message) {
      return false;
    }

    state = state.copyWith(lastNoOffersToastMessage: message);
    return true;
  }
}

class HomeScreenState {
  const HomeScreenState({
    this.isSwapped = false,
    this.selectedCurrency,
    this.selectedCrypto,
    this.amountText = '',
    this.lastNoOffersToastMessage,
  });

  final bool isSwapped;
  final FiatCurrency? selectedCurrency;
  final FiatCurrency? selectedCrypto;
  final String amountText;
  final String? lastNoOffersToastMessage;

  HomeScreenState copyWith({
    bool? isSwapped,
    FiatCurrency? selectedCurrency,
    FiatCurrency? selectedCrypto,
    String? amountText,
    String? lastNoOffersToastMessage,
  }) {
    return HomeScreenState(
      isSwapped: isSwapped ?? this.isSwapped,
      selectedCurrency: identical(selectedCurrency, null)
          ? this.selectedCurrency
          : selectedCurrency as FiatCurrency?,
      selectedCrypto: identical(selectedCrypto, null)
          ? this.selectedCrypto
          : selectedCrypto as FiatCurrency?,
      amountText: amountText ?? this.amountText,
      lastNoOffersToastMessage: identical(lastNoOffersToastMessage, null)
          ? this.lastNoOffersToastMessage
          : lastNoOffersToastMessage as String?,
    );
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  return getIt<HomeRepository>();
}

@riverpod
Future<Home> home(Ref ref) {
  return ref.watch(homeRepositoryProvider).getHome();
}

@Riverpod(retry: noProviderRetry)
Future<OrderbookQuote> orderbookQuote(Ref ref, OrderbookQuoteRequest request) {
  final service = getIt<OrderbookRecommendationsService>();
  return service.fetchQuote(request);
}

@riverpod
Future<SelectableCurrencies> selectableCurrencies(Ref ref) {
  final service = getIt<OrderbookRecommendationsService>();
  return service.fetchSelectableCurrencies();
}
