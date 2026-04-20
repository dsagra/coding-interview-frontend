import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle homeUnavailableTitle = TextStyle(
    color: AppColors.text,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );

  static const TextStyle homeUnavailableDescription = TextStyle(
    color: AppColors.mutedText,
    fontSize: 15,
    height: 1.4,
  );

  static const TextStyle homeUnavailableAction = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle dialogTitle = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle dialogActionType = TextStyle(
    color: AppColors.white70,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle dialogDescription = TextStyle(
    color: AppColors.white70,
    fontSize: 13,
    height: 1.35,
  );

  static const TextStyle dialogCloseButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle summaryLabel({required bool emphasize}) {
    return TextStyle(
      color: AppColors.white72,
      fontSize: emphasize ? 14 : 13,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle summaryValue({required bool emphasize}) {
    return TextStyle(
      color: AppColors.white,
      fontSize: emphasize ? 16 : 14,
      fontWeight: emphasize ? FontWeight.w700 : FontWeight.w600,
    );
  }

  static const TextStyle selectorCurrencyCode = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static const TextStyle selectorLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
    color: AppColors.label,
  );

  static const TextStyle languageSelectorCode = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    letterSpacing: 0.4,
  );

  static const TextStyle bottomSheetTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static const TextStyle currencyCodeLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static const TextStyle currencyCodeLargeCompact = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    height: 1,
  );

  static const TextStyle currencySubtitle = TextStyle(
    fontSize: 12,
    color: AppColors.mutedText,
  );

  static const TextStyle primaryActionButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle amountCode = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBorder,
  );

  static const TextStyle amountInput = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.amountText,
  );

  static const TextStyle estimateLabel = TextStyle(
    fontSize: 18,
    color: AppColors.mutedText,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle estimateValue = TextStyle(
    fontSize: 18,
    color: AppColors.estimateText,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle estimateApprox = TextStyle(
    fontSize: 18,
    color: AppColors.estimateText,
  );

  static const TextStyle moneyLoaderSymbol = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle moneyLoaderLabel = TextStyle(
    color: AppColors.mutedText,
    fontWeight: FontWeight.w500,
  );
}
