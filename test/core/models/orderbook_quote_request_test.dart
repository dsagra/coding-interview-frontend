import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/models/orderbook_quote_request.dart';

void main() {
  test('supports equality and hashCode for same values', () {
    const a = OrderbookQuoteRequest(
      type: 1,
      cryptoCurrencyId: 'btc',
      fiatCurrencyId: 'usd',
      amount: 10,
      amountCurrencyId: 'usd',
    );

    const b = OrderbookQuoteRequest(
      type: 1,
      cryptoCurrencyId: 'btc',
      fiatCurrencyId: 'usd',
      amount: 10,
      amountCurrencyId: 'usd',
    );

    expect(a, b);
    expect(a.hashCode, b.hashCode);
  });

  test('creates an instance from map', () {
    final request = OrderbookQuoteRequest.fromMap({
      'type': 0,
      'cryptoCurrencyId': 'eth',
      'fiatCurrencyId': 'eur',
      'amount': 20,
      'amountCurrencyId': 'eth',
    });

    expect(request.type, 0);
    expect(request.cryptoCurrencyId, 'eth');
    expect(request.fiatCurrencyId, 'eur');
    expect(request.amount, 20.0);
    expect(request.amountCurrencyId, 'eth');
  });
}
