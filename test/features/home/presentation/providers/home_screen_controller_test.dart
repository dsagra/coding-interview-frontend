import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coding_interview_frontend/src/core/models/fiat_currency.dart';
import 'package:coding_interview_frontend/src/features/home/presentation/providers/home_provider.dart';

void main() {
  group('HomeScreenController', () {
    test('toggleSwap flips isSwapped', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(homeScreenControllerProvider).isSwapped, isFalse);

      container.read(homeScreenControllerProvider.notifier).toggleSwap();

      expect(container.read(homeScreenControllerProvider).isSwapped, isTrue);
    });

    test('setAmountText sanitizes input', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(homeScreenControllerProvider.notifier)
          .setAmountText('00a1.2.3');

      expect(container.read(homeScreenControllerProvider).amountText, '1.23');
    });

    test('shouldShowNoOffersToast deduplicates message', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(homeScreenControllerProvider.notifier);

      expect(notifier.shouldShowNoOffersToast('same'), isTrue);
      expect(notifier.shouldShowNoOffersToast('same'), isFalse);
      expect(notifier.shouldShowNoOffersToast('other'), isTrue);
    });

    test('selectCurrency and selectCrypto update current selection', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      const fiat = FiatCurrency(
        code: 'USD',
        assetPath: 'usd.png',
        currencyId: '1',
      );
      const crypto = FiatCurrency(
        code: 'BTC',
        assetPath: 'btc.png',
        currencyId: '2',
      );

      final notifier = container.read(homeScreenControllerProvider.notifier);
      notifier.selectCurrency(fiat);
      notifier.selectCrypto(crypto);

      final state = container.read(homeScreenControllerProvider);
      expect(state.selectedCurrency?.code, 'USD');
      expect(state.selectedCrypto?.code, 'BTC');
    });

    test('reset returns to initial state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(homeScreenControllerProvider.notifier);

      notifier.toggleSwap();
      notifier.setAmountText('10');
      notifier.reset();

      final state = container.read(homeScreenControllerProvider);
      expect(state.isSwapped, isFalse);
      expect(state.amountText, isEmpty);
      expect(state.selectedCurrency, isNull);
      expect(state.selectedCrypto, isNull);
    });
  });
}
