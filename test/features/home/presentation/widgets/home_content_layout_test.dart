import 'package:coding_interview_frontend/l10n/generated/app_localizations.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/home_content_layout.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/widgets/language_selector_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('renders child content and language selector', (tester) async {
    await tester.pumpWidget(
      buildTestApp(const HomeContentLayout(child: Text('contenido'))),
    );

    expect(find.text('contenido'), findsOneWidget);
    expect(find.byType(LanguageSelectorButton), findsOneWidget);
  });

  testWidgets('HomeUnavailableState renders copy and triggers action', (
    tester,
  ) async {
    var wasTapped = false;

    await tester.pumpWidget(
      buildTestApp(
        HomeUnavailableState(
          title: 'Sin servicio',
          description: 'No se puede operar ahora',
          actionLabel: 'Reintentar',
          onAction: () {
            wasTapped = true;
          },
        ),
      ),
    );

    expect(find.text('Sin servicio'), findsOneWidget);
    expect(find.text('No se puede operar ahora'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await tester.pump();

    expect(wasTapped, isTrue);
  });
}
