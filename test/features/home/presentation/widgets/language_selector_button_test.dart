import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/core/providers/app_locale_provider.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/language_selector_button.dart';

void main() {
  Widget buildTestApp({required ProviderContainer container}) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        locale: container.read(appLocaleProvider),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: Center(child: LanguageSelectorButton())),
      ),
    );
  }

  testWidgets('shows spanish by default', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(buildTestApp(container: container));

    expect(find.text('ES'), findsOneWidget);
  });

  testWidgets('changes to english when selected from menu', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(buildTestApp(container: container));

    await tester.tap(find.byType(PopupMenuButton<Locale?>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(container.read(appLocaleProvider), const Locale('en'));
    expect(find.text('EN'), findsOneWidget);
  });
}
