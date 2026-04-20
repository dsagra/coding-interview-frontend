import 'dart:async';

import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/core/models/fiat_currency.dart';
import 'package:coding_interview_frontend/src/core/models/selectable_currencies.dart';
import 'package:coding_interview_frontend/src/features/home/domain/entities/home.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/providers/home_provider.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/screens/home_screen.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/home_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget appShell() => MaterialApp(
    locale: const Locale('es'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const HomeScreen(),
  );

  const baseHome = Home(
    estimatedRate: 10,
    receiveAmount: 20,
    estimatedTime: '2 Min',
  );

  const fiat = FiatCurrency(code: 'USD', assetPath: '', currencyId: 'usd-id');

  const crypto = FiatCurrency(code: 'BTC', assetPath: '', currencyId: 'btc-id');

  testWidgets('shows loading state while home is pending', (tester) async {
    final completer = Completer<Home>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeProvider.overrideWith((ref) => completer.future),
          selectableCurrenciesProvider.overrideWith(
            (ref) async => const SelectableCurrencies(
              fiatCurrencies: [fiat],
              cryptoCurrencies: [crypto],
            ),
          ),
        ],
        child: appShell(),
      ),
    );

    expect(find.byType(HomeLoadingState), findsOneWidget);
  });

  testWidgets('shows localized error when home provider fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeProvider.overrideWith((ref) async => throw Exception('boom')),
          selectableCurrenciesProvider.overrideWith(
            (ref) async => const SelectableCurrencies(
              fiatCurrencies: [fiat],
              cryptoCurrencies: [crypto],
            ),
          ),
        ],
        child: appShell(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Error: Exception: boom'), findsOneWidget);
  });

  testWidgets('shows unavailable load failed state when currencies fail', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeProvider.overrideWith((ref) async => baseHome),
          selectableCurrenciesProvider.overrideWith(
            (ref) async => throw Exception('currencies error'),
          ),
        ],
        child: appShell(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('En estos momentos no podemos operar'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets(
    'shows unavailable empty state when no currencies are available',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeProvider.overrideWith((ref) async => baseHome),
            selectableCurrenciesProvider.overrideWith(
              (ref) async => const SelectableCurrencies(
                fiatCurrencies: [],
                cryptoCurrencies: [],
              ),
            ),
          ],
          child: appShell(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('En estos momentos no podemos operar'), findsOneWidget);
      expect(
        find.text('No hay monedas habilitadas para operar en este momento.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('renders exchange card when data and currencies are available', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeProvider.overrideWith((ref) async => baseHome),
          selectableCurrenciesProvider.overrideWith(
            (ref) async => const SelectableCurrencies(
              fiatCurrencies: [fiat],
              cryptoCurrencies: [crypto],
            ),
          ),
        ],
        child: appShell(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Cambiar'), findsOneWidget);
    expect(find.text('Tasa estimada'), findsOneWidget);
    expect(find.text('Tiempo estimado'), findsAtLeastNWidgets(1));
  });
}
