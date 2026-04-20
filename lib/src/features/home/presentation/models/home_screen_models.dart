import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';

import '../../../../core/models/fiat_currency.dart';
import '../../../../core/models/orderbook_quote.dart';
import '../../../../core/models/orderbook_quote_request.dart';

enum UnavailableStateType { loadFailed, empty, invalidConfiguration }

class UnavailableStateCopy {
  const UnavailableStateCopy({
    required this.title,
    required this.description,
    required this.actionLabel,
  });

  final String title;
  final String description;
  final String actionLabel;

  factory UnavailableStateCopy.fromType(
    UnavailableStateType type,
    AppLocalizations l10n,
  ) {
    switch (type) {
      case UnavailableStateType.loadFailed:
        return UnavailableStateCopy(
          title: l10n.unavailableTitle,
          description: l10n.unavailableLoadFailedDescription,
          actionLabel: l10n.unavailableRetryAction,
        );
      case UnavailableStateType.empty:
        return UnavailableStateCopy(
          title: l10n.unavailableTitle,
          description: l10n.unavailableEmptyDescription,
          actionLabel: l10n.unavailableUpdateAction,
        );
      case UnavailableStateType.invalidConfiguration:
        return UnavailableStateCopy(
          title: l10n.unavailableTitle,
          description: l10n.unavailableInvalidDescription,
          actionLabel: l10n.unavailableUpdateAction,
        );
    }
  }
}

class ActiveSelection {
  const ActiveSelection.available({
    required this.activeFiat,
    required this.activeCrypto,
  }) : unavailableType = null;

  const ActiveSelection.unavailable(this.unavailableType)
    : activeFiat = null,
      activeCrypto = null;

  final FiatCurrency? activeFiat;
  final FiatCurrency? activeCrypto;
  final UnavailableStateType? unavailableType;
}

class QuoteViewData {
  const QuoteViewData({
    required this.request,
    required this.amount,
    required this.hasValidAmount,
    required this.quoteAsync,
    required this.estimatedTime,
  });

  final OrderbookQuoteRequest? request;
  final double amount;
  final bool hasValidAmount;
  final AsyncValue<OrderbookQuote> quoteAsync;
  final String estimatedTime;
}
