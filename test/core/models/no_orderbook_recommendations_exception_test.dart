import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/models/no_orderbook_recommendations_exception.dart';

void main() {
  test('noOffers factory sets reason and deduplication key', () {
    const error = NoOrderbookRecommendationsException.noOffers(
      cryptoCurrencyId: 'btc',
      fiatCurrencyId: 'usd',
    );

    expect(error.reason, NoOrderbookRecommendationsReason.noOffers);
    expect(error.deduplicationKey, contains('btc:usd'));
    expect(error.toString(), contains('No offers'));
  });

  test('invalidAmount factory sets expected reason', () {
    const error = NoOrderbookRecommendationsException.invalidAmount();

    expect(error.reason, NoOrderbookRecommendationsReason.invalidAmount);
    expect(error.deduplicationKey, contains('invalidAmount'));
  });
}
