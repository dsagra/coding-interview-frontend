// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Intercambio de divisas';

  @override
  String get haveLabel => 'TENGO';

  @override
  String get wantLabel => 'QUIERO';

  @override
  String get cryptoLabel => 'Cripto';

  @override
  String get fiatLabel => 'FIAT';

  @override
  String get estimatedRateLabel => 'Tasa estimada';

  @override
  String get receiveLabel => 'Recibirás';

  @override
  String get estimatedTimeLabel => 'Tiempo estimado';

  @override
  String get changeButtonLabel => 'Cambiar';

  @override
  String get operationSummaryTitle => 'Resumen de operación';

  @override
  String get sellingLabel => 'Vas a vender';

  @override
  String get buyingLabel => 'Vas a comprar';

  @override
  String get summaryReceiveLabel => 'Recibirás';

  @override
  String get summaryRateLabel => 'Tasa';

  @override
  String get summaryStatusLabel => 'Estado';

  @override
  String get summaryTimeLabel => 'Tiempo';

  @override
  String get summaryQuoteReady => 'Cotización lista';

  @override
  String get summaryQuoteMissing => 'Sin cotización';

  @override
  String get summaryCloseAndResetButton => 'Cerrar y reiniciar';

  @override
  String get summaryDescription =>
      'El botón Cambiar confirma la operación y reinicia la pantalla al cerrar este resumen.';

  @override
  String get loadingLabel => 'Cargando...';

  @override
  String get noOffersToast =>
      'No hay ofertas disponibles para esa combinación.';

  @override
  String get unavailableTitle => 'En estos momentos no podemos operar';

  @override
  String get unavailableLoadFailedDescription =>
      'No pudimos cargar las monedas disponibles. Por favor, intenta nuevamente en unos segundos.';

  @override
  String get unavailableEmptyDescription =>
      'No hay monedas habilitadas para operar en este momento.';

  @override
  String get unavailableInvalidDescription =>
      'La configuración de monedas recibida no es válida. Intenta actualizar para volver a cargarla.';

  @override
  String get unavailableRetryAction => 'Reintentar';

  @override
  String get unavailableUpdateAction => 'Actualizar';

  @override
  String get currencySubtitleVES => 'Bolivares (Bs)';

  @override
  String get currencySubtitleCOP => 'Pesos Colombianos (COL\$)';

  @override
  String get currencySubtitlePEN => 'Soles Peruanos (S/)';

  @override
  String get currencySubtitleBRL => 'Real Brasileno (R\$)';

  @override
  String genericErrorMessage(String error) {
    return 'Error: $error';
  }
}
