import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/providers/app_locale_provider.dart';

void main() {
  test('starts with spanish locale and can change it', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appLocaleProvider), const Locale('es'));

    container.read(appLocaleProvider.notifier).setLocale(const Locale('en'));

    expect(container.read(appLocaleProvider), const Locale('en'));
  });
}
