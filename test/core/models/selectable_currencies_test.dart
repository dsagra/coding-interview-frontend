import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/models/selectable_currencies.dart';

void main() {
  group('SelectableCurrencies.fromCurrenciesList', () {
    test('splits enabled fiat and crypto currencies by type', () {
      final result = SelectableCurrencies.fromCurrenciesList([
        {
          'type': 0,
          'symbol': 'USD',
          'id': 'usd-id',
          'iconUrl': 'usd.png',
          'enabled': true,
          'apiDisabled': false,
        },
        {
          'type': 1,
          'symbol': 'BTC',
          'id': 'btc-id',
          'iconUrl': 'btc.png',
          'enabled': true,
          'apiDisabled': false,
        },
      ]);

      expect(result.fiatCurrencies, hasLength(1));
      expect(result.cryptoCurrencies, hasLength(1));
      expect(result.fiatCurrencies.first.code, 'USD');
      expect(result.cryptoCurrencies.first.code, 'BTC');
    });

    test('filters disabled and invalid entries', () {
      final result = SelectableCurrencies.fromCurrenciesList([
        {
          'type': 0,
          'symbol': 'USD',
          'id': 'usd-id',
          'enabled': false,
          'apiDisabled': false,
        },
        {
          'type': 1,
          'symbol': 'BTC',
          'id': 'btc-id',
          'enabled': true,
          'apiDisabled': true,
        },
        {
          'type': 1,
          'symbol': 123,
          'id': 'bad',
          'enabled': true,
          'apiDisabled': false,
        },
        'not-a-map',
      ]);

      expect(result.fiatCurrencies, isEmpty);
      expect(result.cryptoCurrencies, isEmpty);
    });
  });
}
