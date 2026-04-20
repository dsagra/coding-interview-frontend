import 'package:coding_interview_frontend/src/features/home/presentation/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('renders label and triggers callback when enabled', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      buildTestApp(
        PrimaryActionButton(
          text: 'Acción',
          onPressed: () {
            tapped = true;
          },
        ),
      ),
    );

    expect(find.text('Acción'), findsOneWidget);

    await tester.tap(find.text('Acción'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('is disabled when onPressed is null', (tester) async {
    await tester.pumpWidget(
      buildTestApp(const PrimaryActionButton(text: 'Acción', onPressed: null)),
    );

    final elevatedButton = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    expect(elevatedButton.onPressed, isNull);
  });
}
