import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/core/models/fiat_currency.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/exchange_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const fiatCurrencies = [
    FiatCurrency(code: 'USD', assetPath: '', currencyId: 'usd'),
    FiatCurrency(code: 'COP', assetPath: '', currencyId: 'cop'),
  ];

  const cryptoCurrencies = [
    FiatCurrency(code: 'BTC', assetPath: '', currencyId: 'btc'),
    FiatCurrency(code: 'ETH', assetPath: '', currencyId: 'eth'),
  ];

  Widget buildTestApp({
    required bool isSwapped,
    required VoidCallback onSwap,
    required ValueChanged<FiatCurrency> onSelectedCrypto,
    required ValueChanged<FiatCurrency> onSelectedCurrency,
  }) {
    return MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(
          child: ExchangeHeader(
            fiatCurrencies: fiatCurrencies,
            cryptoCurrencies: cryptoCurrencies,
            isSwapped: isSwapped,
            selectedCrypto: cryptoCurrencies.first,
            selectedCurrency: fiatCurrencies.first,
            onSwap: onSwap,
            onSelectedCrypto: onSelectedCrypto,
            onSelectedCurrency: onSelectedCurrency,
          ),
        ),
      ),
    );
  }

  testWidgets('renders localized labels and triggers swap', (tester) async {
    var swapped = false;

    await tester.pumpWidget(
      buildTestApp(
        isSwapped: false,
        onSwap: () {
          swapped = true;
        },
        onSelectedCrypto: (_) {},
        onSelectedCurrency: (_) {},
      ),
    );

    expect(find.text('TENGO'), findsOneWidget);
    expect(find.text('QUIERO'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.swap_horiz));
    await tester.pump();

    expect(swapped, isTrue);
  });

  testWidgets('opens fiat bottom sheet and selects currency', (tester) async {
    FiatCurrency? selectedFiat;

    await tester.pumpWidget(
      buildTestApp(
        isSwapped: false,
        onSwap: () {},
        onSelectedCrypto: (_) {},
        onSelectedCurrency: (currency) {
          selectedFiat = currency;
        },
      ),
    );

    await tester.tap(find.text('USD'));
    await tester.pumpAndSettle();

    expect(find.text('FIAT'), findsOneWidget);
    expect(find.text('Pesos Colombianos (COL\$)'), findsOneWidget);

    await tester.tap(find.text('COP'));
    await tester.pumpAndSettle();

    expect(selectedFiat?.code, 'COP');
  });

  testWidgets('opens crypto bottom sheet and selects currency', (tester) async {
    FiatCurrency? selectedCrypto;

    await tester.pumpWidget(
      buildTestApp(
        isSwapped: true,
        onSwap: () {},
        onSelectedCrypto: (currency) {
          selectedCrypto = currency;
        },
        onSelectedCurrency: (_) {},
      ),
    );

    await tester.tap(find.text('BTC').first);
    await tester.pumpAndSettle();

    expect(find.text('Cripto'), findsOneWidget);

    await tester.tap(find.text('ETH'));
    await tester.pumpAndSettle();

    expect(selectedCrypto?.code, 'ETH');
  });
}
