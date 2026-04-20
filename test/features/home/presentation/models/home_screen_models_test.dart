import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/models/home_screen_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UnavailableStateCopy returns localized values for each type', (
    tester,
  ) async {
    late AppLocalizations l10n;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    final loadFailed = UnavailableStateCopy.fromType(
      UnavailableStateType.loadFailed,
      l10n,
    );
    final empty = UnavailableStateCopy.fromType(
      UnavailableStateType.empty,
      l10n,
    );
    final invalid = UnavailableStateCopy.fromType(
      UnavailableStateType.invalidConfiguration,
      l10n,
    );

    expect(loadFailed.title, 'En estos momentos no podemos operar');
    expect(loadFailed.actionLabel, 'Reintentar');

    expect(
      empty.description,
      'No hay monedas habilitadas para operar en este momento.',
    );
    expect(empty.actionLabel, 'Actualizar');

    expect(
      invalid.description,
      'La configuración de monedas recibida no es válida. Intenta actualizar para volver a cargarla.',
    );
  });
}
