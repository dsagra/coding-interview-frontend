import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Currency Exchange'**
  String get appTitle;

  /// No description provided for @haveLabel.
  ///
  /// In en, this message translates to:
  /// **'HAVE'**
  String get haveLabel;

  /// No description provided for @wantLabel.
  ///
  /// In en, this message translates to:
  /// **'WANT'**
  String get wantLabel;

  /// No description provided for @cryptoLabel.
  ///
  /// In en, this message translates to:
  /// **'Crypto'**
  String get cryptoLabel;

  /// No description provided for @fiatLabel.
  ///
  /// In en, this message translates to:
  /// **'Fiat'**
  String get fiatLabel;

  /// No description provided for @estimatedRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated rate'**
  String get estimatedRateLabel;

  /// No description provided for @receiveLabel.
  ///
  /// In en, this message translates to:
  /// **'You will receive'**
  String get receiveLabel;

  /// No description provided for @estimatedTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated time'**
  String get estimatedTimeLabel;

  /// No description provided for @changeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get changeButtonLabel;

  /// No description provided for @operationSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Operation summary'**
  String get operationSummaryTitle;

  /// No description provided for @sellingLabel.
  ///
  /// In en, this message translates to:
  /// **'You\'re selling'**
  String get sellingLabel;

  /// No description provided for @buyingLabel.
  ///
  /// In en, this message translates to:
  /// **'You\'re buying'**
  String get buyingLabel;

  /// No description provided for @summaryReceiveLabel.
  ///
  /// In en, this message translates to:
  /// **'You will receive'**
  String get summaryReceiveLabel;

  /// No description provided for @summaryRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get summaryRateLabel;

  /// No description provided for @summaryStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get summaryStatusLabel;

  /// No description provided for @summaryTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get summaryTimeLabel;

  /// No description provided for @summaryQuoteReady.
  ///
  /// In en, this message translates to:
  /// **'Quote ready'**
  String get summaryQuoteReady;

  /// No description provided for @summaryQuoteMissing.
  ///
  /// In en, this message translates to:
  /// **'No quote'**
  String get summaryQuoteMissing;

  /// No description provided for @summaryCloseAndResetButton.
  ///
  /// In en, this message translates to:
  /// **'Close and reset'**
  String get summaryCloseAndResetButton;

  /// No description provided for @summaryDescription.
  ///
  /// In en, this message translates to:
  /// **'The Swap button confirms the operation and resets the screen when you close this summary.'**
  String get summaryDescription;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingLabel;

  /// No description provided for @noOffersToast.
  ///
  /// In en, this message translates to:
  /// **'No offers are available for this combination.'**
  String get noOffersToast;

  /// No description provided for @unavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'We cannot operate right now'**
  String get unavailableTitle;

  /// No description provided for @unavailableLoadFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the available currencies. Please try again in a few seconds.'**
  String get unavailableLoadFailedDescription;

  /// No description provided for @unavailableEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'There are no enabled currencies available right now.'**
  String get unavailableEmptyDescription;

  /// No description provided for @unavailableInvalidDescription.
  ///
  /// In en, this message translates to:
  /// **'The received currency configuration is invalid. Try refreshing to load it again.'**
  String get unavailableInvalidDescription;

  /// No description provided for @unavailableRetryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get unavailableRetryAction;

  /// No description provided for @unavailableUpdateAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get unavailableUpdateAction;

  /// No description provided for @currencySubtitleVES.
  ///
  /// In en, this message translates to:
  /// **'Venezuelan bolívars (Bs)'**
  String get currencySubtitleVES;

  /// No description provided for @currencySubtitleCOP.
  ///
  /// In en, this message translates to:
  /// **'Colombian pesos (COP\$)'**
  String get currencySubtitleCOP;

  /// No description provided for @currencySubtitlePEN.
  ///
  /// In en, this message translates to:
  /// **'Peruvian soles (S/)'**
  String get currencySubtitlePEN;

  /// No description provided for @currencySubtitleBRL.
  ///
  /// In en, this message translates to:
  /// **'Brazilian real (R\$)'**
  String get currencySubtitleBRL;

  /// No description provided for @genericErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String genericErrorMessage(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
