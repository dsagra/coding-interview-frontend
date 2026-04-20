import 'package:flutter/material.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/fiat_currency.dart';
import 'currency_image.dart';

class ExchangeHeader extends StatelessWidget {
  const ExchangeHeader({
    super.key,
    required this.fiatCurrencies,
    required this.cryptoCurrencies,
    required this.isSwapped,
    required this.selectedCrypto,
    required this.selectedCurrency,
    required this.onSwap,
    required this.onSelectedCrypto,
    required this.onSelectedCurrency,
  });

  final List<FiatCurrency> fiatCurrencies;
  final List<FiatCurrency> cryptoCurrencies;
  final bool isSwapped;
  final FiatCurrency selectedCrypto;
  final FiatCurrency selectedCurrency;
  final VoidCallback onSwap;
  final ValueChanged<FiatCurrency> onSelectedCrypto;
  final ValueChanged<FiatCurrency> onSelectedCurrency;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final leftIsCrypto = !isSwapped;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryBorder, width: 2),
            borderRadius: BorderRadius.circular(34),
          ),
          child: Row(
            children: [
              Expanded(
                child: leftIsCrypto
                    ? _CurrencySelector(
                        label: l10n.haveLabel,
                        selectedCurrency: selectedCrypto,
                        currencies: cryptoCurrencies,
                        onSelected: onSelectedCrypto,
                        isLeft: true,
                        modalTitle: l10n.cryptoLabel,
                        isFiat: false,
                        labelPadding: 6,
                      )
                    : _CurrencySelector(
                        label: l10n.haveLabel,
                        selectedCurrency: selectedCurrency,
                        currencies: fiatCurrencies,
                        onSelected: onSelectedCurrency,
                        isLeft: true,
                        modalTitle: l10n.fiatLabel,
                        isFiat: true,
                        labelPadding: 6,
                      ),
              ),
              const SizedBox(width: 36),
              Expanded(
                child: leftIsCrypto
                    ? _CurrencySelector(
                        label: l10n.wantLabel,
                        selectedCurrency: selectedCurrency,
                        currencies: fiatCurrencies,
                        onSelected: onSelectedCurrency,
                        isLeft: false,
                        modalTitle: l10n.fiatLabel,
                        isFiat: true,
                        labelPadding: 5,
                      )
                    : _CurrencySelector(
                        label: l10n.wantLabel,
                        selectedCurrency: selectedCrypto,
                        currencies: cryptoCurrencies,
                        onSelected: onSelectedCrypto,
                        isLeft: false,
                        modalTitle: l10n.cryptoLabel,
                        isFiat: false,
                        labelPadding: 6,
                      ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onSwap,
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.swap_horiz,
              color: AppColors.white,
              size: 34,
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  const _CurrencySelector({
    required this.label,
    required this.selectedCurrency,
    required this.currencies,
    required this.onSelected,
    required this.isLeft,
    required this.modalTitle,
    required this.isFiat,
    required this.labelPadding,
  });

  final String label;
  final FiatCurrency selectedCurrency;
  final List<FiatCurrency> currencies;
  final ValueChanged<FiatCurrency> onSelected;
  final bool isLeft;
  final String modalTitle;
  final bool isFiat;
  final double labelPadding;

  Future<void> _openCurrencyBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bottomSheetBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return _CurrencyBottomSheet(
          title: modalTitle,
          isFiat: isFiat,
          currencies: currencies,
          selectedCode: selectedCurrency.code,
          onSelected: (currency) {
            onSelected(currency);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _openCurrencyBottomSheet(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CurrencyImage(
                      path: selectedCurrency.assetPath,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      selectedCurrency.code,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: AppTextStyles.selectorCurrencyCode.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.mutedText,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -7,
            left: isLeft ? 0 : null,
            right: isLeft ? null : 0,
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: labelPadding),
              child: Text(
                label,
                style: AppTextStyles.selectorLabel.copyWith(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyBottomSheet extends StatelessWidget {
  const _CurrencyBottomSheet({
    required this.title,
    required this.isFiat,
    required this.currencies,
    required this.selectedCode,
    required this.onSelected,
  });

  final String title;
  final bool isFiat;
  final List<FiatCurrency> currencies;
  final String selectedCode;
  final ValueChanged<FiatCurrency> onSelected;

  String _getCurrencySubtitle(String code, AppLocalizations l10n) {
    switch (code) {
      case 'VES':
        return l10n.currencySubtitleVES;
      case 'COP':
        return l10n.currencySubtitleCOP;
      case 'PEN':
        return l10n.currencySubtitlePEN;
      case 'BRL':
        return l10n.currencySubtitleBRL;
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.bottomSheetHandle,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 22),
            Text(title, style: AppTextStyles.bottomSheetTitle),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: currencies.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final currency = currencies[index];
                  final isSelected = currency.code == selectedCode;

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => onSelected(currency),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CurrencyImage(
                              path: currency.assetPath,
                              width: 36,
                              height: 36,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: isFiat
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        currency.code,
                                        style: AppTextStyles
                                            .currencyCodeLargeCompact,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _getCurrencySubtitle(
                                          currency.code,
                                          l10n,
                                        ),
                                        style: AppTextStyles.currencySubtitle,
                                      ),
                                    ],
                                  )
                                : Text(
                                    currency.code,
                                    style: AppTextStyles.currencyCodeLarge,
                                  ),
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.selectorBorder,
                                width: 1.6,
                              ),
                            ),
                            child: isSelected
                                ? const Center(
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: AppColors.primary,
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
