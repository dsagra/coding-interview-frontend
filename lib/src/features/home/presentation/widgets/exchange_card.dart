import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/fiat_currency.dart';
import '../../../../core/models/orderbook_quote.dart';
import '../../domain/entities/home.dart';
import 'amount_field.dart';
import 'exchange_header.dart';
import 'primary_action_button.dart';
import 'shimmer_value_placeholder.dart';

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({
    super.key,
    required this.home,
    required this.isSwapped,
    required this.fiatCurrencies,
    required this.cryptoCurrencies,
    required this.selectedCrypto,
    required this.selectedCurrency,
    required this.amountController,
    required this.quoteAsync,
    required this.estimatedTime,
    required this.onToggleSwap,
    required this.onConfirmChange,
    required this.onSelectedCrypto,
    required this.onSelectedCurrency,
    required this.onAmountChanged,
  });

  final Home home;
  final bool isSwapped;
  final List<FiatCurrency> fiatCurrencies;
  final List<FiatCurrency> cryptoCurrencies;
  final FiatCurrency selectedCrypto;
  final FiatCurrency selectedCurrency;
  final TextEditingController amountController;
  final AsyncValue<OrderbookQuote> quoteAsync;
  final String estimatedTime;
  final VoidCallback onToggleSwap;
  final VoidCallback onConfirmChange;
  final ValueChanged<FiatCurrency> onSelectedCrypto;
  final ValueChanged<FiatCurrency> onSelectedCurrency;
  final ValueChanged<String> onAmountChanged;

  String _formatQuoteValue({
    required String targetCode,
    required double fallback,
    required double Function(OrderbookQuote quote) selector,
  }) {
    final fallbackValue = '${fallback.toStringAsFixed(2)} $targetCode';

    return quoteAsync.when(
      data: (quote) => '${selector(quote).toStringAsFixed(2)} $targetCode',
      loading: () => fallbackValue,
      error: (error, _) => fallbackValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final targetCode = isSwapped ? selectedCrypto.code : selectedCurrency.code;
    final isQuoteLoading = quoteAsync.isLoading;
    final fallbackRate = home.estimatedRate;
    final fallbackReceive = home.receiveAmount;
    final canConfirmChange = quoteAsync.when(
      data: (quote) => quote.estimatedRate > 0 && quote.receiveAmount > 0,
      loading: () => false,
      error: (error, _) => false,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExchangeHeader(
            fiatCurrencies: fiatCurrencies,
            cryptoCurrencies: cryptoCurrencies,
            isSwapped: isSwapped,
            selectedCrypto: selectedCrypto,
            selectedCurrency: selectedCurrency,
            onSwap: onToggleSwap,
            onSelectedCrypto: onSelectedCrypto,
            onSelectedCurrency: onSelectedCurrency,
          ),
          const SizedBox(height: 20),
          AmountField(
            code: isSwapped ? selectedCurrency.code : selectedCrypto.code,
            controller: amountController,
            onChanged: onAmountChanged,
          ),
          const SizedBox(height: 28),
          _EstimateRow(
            label: l10n.estimatedRateLabel,
            value: _formatQuoteValue(
              targetCode: targetCode,
              fallback: fallbackRate,
              selector: (quote) => quote.estimatedRate,
            ),
            isLoading: isQuoteLoading,
          ),
          const SizedBox(height: 18),
          _EstimateRow(
            label: l10n.receiveLabel,
            value: _formatQuoteValue(
              targetCode: targetCode,
              fallback: fallbackReceive,
              selector: (quote) => quote.receiveAmount,
            ),
            isLoading: isQuoteLoading,
          ),
          const SizedBox(height: 18),
          _EstimateRow(
            label: l10n.estimatedTimeLabel,
            value: estimatedTime,
            isLoading: isQuoteLoading,
          ),
          const SizedBox(height: 26),
          PrimaryActionButton(
            text: l10n.changeButtonLabel,
            onPressed: canConfirmChange ? onConfirmChange : null,
          ),
        ],
      ),
    );
  }
}

class _EstimateRow extends StatelessWidget {
  const _EstimateRow({
    required this.label,
    required this.value,
    this.isLoading = false,
  });

  final String label;
  final String value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.estimateLabel)),
        Text('≈ ', style: AppTextStyles.estimateApprox),
        if (isLoading)
          const ShimmerValuePlaceholder()
        else
          Text(value, style: AppTextStyles.estimateValue),
      ],
    );
  }
}
