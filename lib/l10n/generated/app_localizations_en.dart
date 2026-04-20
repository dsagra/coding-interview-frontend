// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Currency Exchange';

  @override
  String get haveLabel => 'HAVE';

  @override
  String get wantLabel => 'WANT';

  @override
  String get cryptoLabel => 'Crypto';

  @override
  String get fiatLabel => 'Fiat';

  @override
  String get estimatedRateLabel => 'Estimated rate';

  @override
  String get receiveLabel => 'You will receive';

  @override
  String get estimatedTimeLabel => 'Estimated time';

  @override
  String get changeButtonLabel => 'Swap';

  @override
  String get operationSummaryTitle => 'Operation summary';

  @override
  String get sellingLabel => 'You\'re selling';

  @override
  String get buyingLabel => 'You\'re buying';

  @override
  String get summaryReceiveLabel => 'You will receive';

  @override
  String get summaryRateLabel => 'Rate';

  @override
  String get summaryStatusLabel => 'Status';

  @override
  String get summaryTimeLabel => 'Time';

  @override
  String get summaryQuoteReady => 'Quote ready';

  @override
  String get summaryQuoteMissing => 'No quote';

  @override
  String get summaryCloseAndResetButton => 'Close and reset';

  @override
  String get summaryDescription =>
      'The Swap button confirms the operation and resets the screen when you close this summary.';

  @override
  String get loadingLabel => 'Loading...';

  @override
  String get noOffersToast => 'No offers are available for this combination.';

  @override
  String get unavailableTitle => 'We cannot operate right now';

  @override
  String get unavailableLoadFailedDescription =>
      'We couldn\'t load the available currencies. Please try again in a few seconds.';

  @override
  String get unavailableEmptyDescription =>
      'There are no enabled currencies available right now.';

  @override
  String get unavailableInvalidDescription =>
      'The received currency configuration is invalid. Try refreshing to load it again.';

  @override
  String get unavailableRetryAction => 'Retry';

  @override
  String get unavailableUpdateAction => 'Refresh';

  @override
  String get currencySubtitleVES => 'Venezuelan bolívars (Bs)';

  @override
  String get currencySubtitleCOP => 'Colombian pesos (COP\$)';

  @override
  String get currencySubtitlePEN => 'Peruvian soles (S/)';

  @override
  String get currencySubtitleBRL => 'Brazilian real (R\$)';

  @override
  String genericErrorMessage(String error) {
    return 'Error: $error';
  }
}
