import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/confirm_change_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('renders localized summary and quote ready state', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        ConfirmChangeDialog(
          isSell: true,
          fromCurrencyCode: 'BTC',
          toCurrencyCode: 'USD',
          amount: 2,
          estimatedReceive: 100,
          estimatedRate: 50,
          estimatedTime: '3 Min',
          quoteReady: true,
          onConfirm: () {},
        ),
      ),
    );

    expect(find.text('Resumen de operación'), findsOneWidget);
    expect(find.text('Vas a vender'), findsNWidgets(2));
    expect(find.text('Cotización lista'), findsOneWidget);
    expect(find.text('Cerrar y reiniciar'), findsOneWidget);
    expect(find.textContaining('1 BTC = 50.0000 USD'), findsOneWidget);
  });

  testWidgets('invokes onConfirm when close button is tapped', (tester) async {
    var wasClosed = false;

    await tester.pumpWidget(
      buildTestApp(
        ConfirmChangeDialog(
          isSell: false,
          fromCurrencyCode: 'USD',
          toCurrencyCode: 'BTC',
          amount: 10,
          estimatedReceive: 0,
          estimatedRate: 0,
          estimatedTime: '0 Min',
          quoteReady: false,
          onConfirm: () {
            wasClosed = true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Cerrar y reiniciar'));
    await tester.pump();

    expect(wasClosed, isTrue);
    expect(find.text('Sin cotización'), findsOneWidget);
  });
}
