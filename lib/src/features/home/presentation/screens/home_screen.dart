import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';

import '../../../../core/functions/functions.dart';
import '../../../../core/models/fiat_currency.dart';
import '../../../../core/models/no_orderbook_recommendations_exception.dart';
import '../../../../core/models/orderbook_quote.dart';
import '../../../../core/models/orderbook_quote_request.dart';
import '../../../../core/models/selectable_currencies.dart';
import '../../domain/entities/home.dart';
import '../models/home_screen_models.dart';
import '../providers/home_provider.dart';
import '../widgets/confirm_change_dialog.dart';
import '../widgets/exchange_card.dart';
import '../widgets/home_content_layout.dart';
import '../widgets/home_loading_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final homeAsync = ref.watch(homeProvider);
    final selectableCurrenciesAsync = ref.watch(selectableCurrenciesProvider);
    final homeState = ref.watch(homeScreenControllerProvider);
    final homeController = ref.read(homeScreenControllerProvider.notifier);
    final amountController = ref.watch(homeAmountControllerProvider);

    return Scaffold(
      body: homeAsync.when(
        data: (home) => _buildContent(
          context: context,
          l10n: l10n,
          ref: ref,
          home: home,
          selectableCurrenciesAsync: selectableCurrenciesAsync,
          homeState: homeState,
          homeController: homeController,
          amountController: amountController,
        ),
        loading: () => const HomeLoadingState(),
        error: (error, stackTrace) =>
            Center(child: Text(l10n.genericErrorMessage(error.toString()))),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required AppLocalizations l10n,
    required WidgetRef ref,
    required Home home,
    required AsyncValue<SelectableCurrencies> selectableCurrenciesAsync,
    required HomeScreenState homeState,
    required HomeScreenController homeController,
    required TextEditingController amountController,
  }) {
    return selectableCurrenciesAsync.when(
      loading: () => const HomeLoadingState(),
      error: (error, _) => _buildUnavailableState(
        l10n: l10n,
        type: UnavailableStateType.loadFailed,
        onAction: () => ref.invalidate(selectableCurrenciesProvider),
      ),
      data: (currencies) => _buildExchangeContent(
        context: context,
        l10n: l10n,
        ref: ref,
        home: home,
        currencies: currencies,
        homeState: homeState,
        homeController: homeController,
        amountController: amountController,
      ),
    );
  }

  Widget _buildExchangeContent({
    required BuildContext context,
    required AppLocalizations l10n,
    required WidgetRef ref,
    required Home home,
    required SelectableCurrencies currencies,
    required HomeScreenState homeState,
    required HomeScreenController homeController,
    required TextEditingController amountController,
  }) {
    final activeSelection = _resolveActiveSelection(
      homeState: homeState,
      currencies: currencies,
    );

    if (activeSelection.unavailableType != null) {
      return _buildUnavailableState(
        l10n: l10n,
        type: activeSelection.unavailableType!,
        onAction: () => ref.invalidate(selectableCurrenciesProvider),
      );
    }

    final activeFiat = activeSelection.activeFiat!;
    final activeCrypto = activeSelection.activeCrypto!;

    final quoteViewData = _resolveQuoteViewData(
      ref: ref,
      home: home,
      homeState: homeState,
      activeFiat: activeFiat,
      activeCrypto: activeCrypto,
    );

    final request = quoteViewData.request;
    if (request != null) {
      ref.listen<AsyncValue<OrderbookQuote>>(
        orderbookQuoteProvider(request),
        (previous, next) {
          next.whenOrNull(
            data: (_) {
              homeController.clearNoOffersToastMessage();
            },
            error: (error, _) {
              if (error is NoOrderbookRecommendationsException &&
                  error.reason == NoOrderbookRecommendationsReason.noOffers) {
                if (homeController.shouldShowNoOffersToast(
                  error.deduplicationKey,
                )) {
                  _showNoOffersToast(context);
                }
              }
            },
          );
        },
      );
    }

    return HomeContentLayout(
      child: ExchangeCard(
        home: home,
        isSwapped: homeState.isSwapped,
        fiatCurrencies: currencies.fiatCurrencies,
        cryptoCurrencies: currencies.cryptoCurrencies,
        selectedCrypto: activeCrypto,
        selectedCurrency: activeFiat,
        amountController: amountController,
        quoteAsync: quoteViewData.quoteAsync,
        estimatedTime: quoteViewData.estimatedTime,
        onToggleSwap: homeController.toggleSwap,
        onConfirmChange: () => _handleConfirmChange(
          context: context,
          l10n: l10n,
          homeController: homeController,
          isSwapped: homeState.isSwapped,
          activeFiat: activeFiat,
          activeCrypto: activeCrypto,
          amount: quoteViewData.amount,
          quoteAsync: quoteViewData.quoteAsync,
          hasValidAmount: quoteViewData.hasValidAmount,
          estimatedTime: quoteViewData.estimatedTime,
          amountController: amountController,
        ),
        onSelectedCrypto: homeController.selectCrypto,
        onSelectedCurrency: homeController.selectCurrency,
        onAmountChanged: homeController.setAmountText,
      ),
    );
  }

  ActiveSelection _resolveActiveSelection({
    required HomeScreenState homeState,
    required SelectableCurrencies currencies,
  }) {
    if (currencies.fiatCurrencies.isEmpty ||
        currencies.cryptoCurrencies.isEmpty) {
      return const ActiveSelection.unavailable(UnavailableStateType.empty);
    }

    final activeFiat =
        homeState.selectedCurrency ?? currencies.fiatCurrencies.first;
    final activeCrypto =
        homeState.selectedCrypto ?? currencies.cryptoCurrencies.first;
    final cryptoId = activeCrypto.currencyId ?? '';
    final fiatId = activeFiat.currencyId ?? '';

    if (cryptoId.isEmpty || fiatId.isEmpty) {
      return const ActiveSelection.unavailable(
        UnavailableStateType.invalidConfiguration,
      );
    }

    return ActiveSelection.available(
      activeFiat: activeFiat,
      activeCrypto: activeCrypto,
    );
  }

  QuoteViewData _resolveQuoteViewData({
    required WidgetRef ref,
    required Home home,
    required HomeScreenState homeState,
    required FiatCurrency activeFiat,
    required FiatCurrency activeCrypto,
  }) {
    final amount = parseAmount(homeState.amountText);
    final hasValidAmount = homeState.amountText.isNotEmpty && amount > 0;

    OrderbookQuoteRequest? request;
    late AsyncValue<OrderbookQuote> quoteAsync;

    if (hasValidAmount) {
      request = _buildQuoteRequest(
        homeState: homeState,
        activeFiat: activeFiat,
        activeCrypto: activeCrypto,
        amount: amount,
      );

      quoteAsync = ref.watch(orderbookQuoteProvider(request));
    } else {
      quoteAsync = AsyncValue.data(
        OrderbookQuote(
          fiatToCryptoExchangeRate: 0,
          estimatedRate: 0,
          receiveAmount: 0,
          estimatedTime: home.estimatedTime,
        ),
      );
    }

    final estimatedTime = quoteAsync.when(
      data: (quote) => quote.estimatedTime,
      loading: () => home.estimatedTime,
      error: (error, _) => home.estimatedTime,
    );

    return QuoteViewData(
      request: request,
      amount: amount,
      hasValidAmount: hasValidAmount,
      quoteAsync: quoteAsync,
      estimatedTime: estimatedTime,
    );
  }

  OrderbookQuoteRequest _buildQuoteRequest({
    required HomeScreenState homeState,
    required FiatCurrency activeFiat,
    required FiatCurrency activeCrypto,
    required double amount,
  }) {
    final cryptoId = activeCrypto.currencyId ?? '';
    final fiatId = activeFiat.currencyId ?? '';
    final amountCurrencyId = homeState.isSwapped ? fiatId : cryptoId;

    return OrderbookQuoteRequest(
      type: homeState.isSwapped ? 1 : 0,
      cryptoCurrencyId: cryptoId,
      fiatCurrencyId: fiatId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );
  }

  Future<void> _handleConfirmChange({
    required BuildContext context,
    required AppLocalizations l10n,
    required HomeScreenController homeController,
    required bool isSwapped,
    required FiatCurrency activeFiat,
    required FiatCurrency activeCrypto,
    required double amount,
    required AsyncValue<OrderbookQuote> quoteAsync,
    required bool hasValidAmount,
    required String estimatedTime,
    required TextEditingController amountController,
  }) async {
    if (!context.mounted) {
      return;
    }

    final shouldReset = await showDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) {
            final isSell = !isSwapped;
            final fromCurrency = isSell ? activeCrypto : activeFiat;
            final toCurrency = isSell ? activeFiat : activeCrypto;
            final quote = quoteAsync.whenOrNull(data: (value) => value);
            final estimatedReceive = hasValidAmount && quote != null
                ? quote.receiveAmount
                : 0.0;
            final estimatedRate = hasValidAmount && quote != null
                ? quote.estimatedRate
                : 0.0;

            return ConfirmChangeDialog(
              isSell: isSell,
              fromCurrencyCode: fromCurrency.code,
              toCurrencyCode: toCurrency.code,
              amount: amount,
              estimatedReceive: estimatedReceive,
              estimatedRate: estimatedRate,
              estimatedTime: estimatedTime,
              quoteReady: hasValidAmount && quote != null,
              onConfirm: () => Navigator.of(dialogContext).pop(true),
            );
          },
        ) ??
        false;

    if (!context.mounted) {
      return;
    }

    if (!shouldReset) {
      return;
    }

    homeController.reset();
    amountController.clear();
  }

  void _showNoOffersToast(BuildContext context) {
    if (!context.mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.hideCurrentSnackBar();
    messenger?.showSnackBar(SnackBar(content: Text(l10n.noOffersToast)));
  }

  HomeUnavailableState _buildUnavailableState({
    required AppLocalizations l10n,
    required UnavailableStateType type,
    required VoidCallback onAction,
  }) {
    final copy = UnavailableStateCopy.fromType(type, l10n);
    return HomeUnavailableState(
      title: copy.title,
      description: copy.description,
      actionLabel: copy.actionLabel,
      onAction: onAction,
    );
  }
}
