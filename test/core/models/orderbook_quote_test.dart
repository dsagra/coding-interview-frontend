import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/models/orderbook_quote.dart';

void main() {
  group('OrderbookQuote.fromMap', () {
    test('maps quote values and formats estimated time', () {
      final quote = OrderbookQuote.fromMap({
        'rate': '12.34',
        'receiveAmount': 50.0,
        'offerMakerStats': {'marketMakerOrderTime': 2.2},
      });

      expect(quote.fiatToCryptoExchangeRate, 12.34);
      expect(quote.estimatedRate, 12.34);
      expect(quote.receiveAmount, 50.0);
      expect(quote.estimatedTime, '3 Min');
    });

    test('uses safe defaults for missing values', () {
      final quote = OrderbookQuote.fromMap({});

      expect(quote.fiatToCryptoExchangeRate, 0);
      expect(quote.estimatedRate, 0);
      expect(quote.receiveAmount, 0.0);
      expect(quote.estimatedTime, '0 Min');
    });
  });
}
