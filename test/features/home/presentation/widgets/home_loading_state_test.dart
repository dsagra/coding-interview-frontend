import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/home_loading_state.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/money_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp() {
    return MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: HomeLoadingState()),
    );
  }

  testWidgets('renders the branded loading screen', (tester) async {
    await tester.pumpWidget(buildTestApp());

    expect(find.byType(HomeLoadingState), findsOneWidget);
    expect(find.byType(MoneyLoader), findsOneWidget);
    expect(find.text(r'$'), findsOneWidget);
    expect(find.text('Cargando...'), findsOneWidget);
  });
}