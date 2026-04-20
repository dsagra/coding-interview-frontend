import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:coding_interview_frontend/src/core/models/no_orderbook_recommendations_exception.dart';
import 'package:coding_interview_frontend/src/core/models/orderbook_quote_request.dart';
import 'package:coding_interview_frontend/src/core/services/orderbook_recommendations_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }
}

ResponseBody _jsonBody(Object data, int statusCode) {
  return ResponseBody.fromString(
    jsonEncode(data),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

void main() {
  const request = OrderbookQuoteRequest(
    type: 0,
    cryptoCurrencyId: 'btc-id',
    fiatCurrencyId: 'usd-id',
    amount: 2,
    amountCurrencyId: 'btc-id',
  );

  test('fetchSelectableCurrencies parses enabled fiat and crypto', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      if (options.path.contains('/currencies')) {
        return _jsonBody({
          'data': {
            'currencies': [
              {
                'type': 0,
                'symbol': 'USD',
                'id': 'usd-id',
                'iconUrl': '',
                'enabled': true,
                'apiDisabled': false,
              },
              {
                'type': 1,
                'symbol': 'BTC',
                'id': 'btc-id',
                'iconUrl': '',
                'enabled': true,
                'apiDisabled': false,
              },
            ],
          },
        }, 200);
      }
      return _jsonBody({}, 404);
    });

    final service = OrderbookRecommendationsService(dio: dio);
    final result = await service.fetchSelectableCurrencies();

    expect(result.fiatCurrencies, hasLength(1));
    expect(result.cryptoCurrencies, hasLength(1));
    expect(result.fiatCurrencies.first.code, 'USD');
    expect(result.cryptoCurrencies.first.code, 'BTC');
  });

  test('fetchSelectableCurrencies throws on invalid payload', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      return _jsonBody([], 200);
    });

    final service = OrderbookRecommendationsService(dio: dio);

    expect(service.fetchSelectableCurrencies(), throwsA(isA<Exception>()));
  });

  test('fetchQuote throws invalidAmount for non-positive amount', () async {
    final service = OrderbookRecommendationsService(dio: Dio());

    expect(
      service.fetchQuote(
        const OrderbookQuoteRequest(
          type: 0,
          cryptoCurrencyId: 'btc-id',
          fiatCurrencyId: 'usd-id',
          amount: 0,
          amountCurrencyId: 'btc-id',
        ),
      ),
      throwsA(
        isA<NoOrderbookRecommendationsException>().having(
          (e) => e.reason,
          'reason',
          NoOrderbookRecommendationsReason.invalidAmount,
        ),
      ),
    );
  });

  test('fetchQuote returns quote for buy request', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      if (options.path.contains('/recommendations')) {
        return _jsonBody({
          'data': {
            'byPrice': {
              'fiatToCryptoExchangeRate': 10,
              'offerMakerStats': {'marketMakerOrderTime': 1.2},
            },
          },
        }, 200);
      }
      return _jsonBody({}, 404);
    });

    final service = OrderbookRecommendationsService(dio: dio);
    final quote = await service.fetchQuote(request);

    expect(quote.estimatedRate, 10);
    expect(quote.receiveAmount, 20);
    expect(quote.estimatedTime, '2 Min');
  });

  test('fetchQuote returns quote for sell request', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      return _jsonBody({
        'data': {
          'byPrice': {
            'fiatToCryptoExchangeRate': 4,
            'offerMakerStats': {'marketMakerOrderTime': 0.1},
          },
        },
      }, 200);
    });

    final service = OrderbookRecommendationsService(dio: dio);
    final quote = await service.fetchQuote(
      const OrderbookQuoteRequest(
        type: 1,
        cryptoCurrencyId: 'btc-id',
        fiatCurrencyId: 'usd-id',
        amount: 20,
        amountCurrencyId: 'usd-id',
      ),
    );

    expect(quote.receiveAmount, 5);
  });

  test('fetchQuote throws noOffers when byPrice is missing', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      return _jsonBody({
        'data': {'byPrice': {}},
      }, 200);
    });

    final service = OrderbookRecommendationsService(dio: dio);

    expect(
      service.fetchQuote(request),
      throwsA(
        isA<NoOrderbookRecommendationsException>().having(
          (e) => e.reason,
          'reason',
          NoOrderbookRecommendationsReason.noOffers,
        ),
      ),
    );
  });

  test('translates invalid crypto error from API', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      return _jsonBody({'reason': 'invalid crypto currency id'}, 400);
    });

    final service = OrderbookRecommendationsService(dio: dio);

    expect(
      service.fetchQuote(request),
      throwsA(
        isA<NoOrderbookRecommendationsException>().having(
          (e) => e.reason,
          'reason',
          NoOrderbookRecommendationsReason.unsupportedCrypto,
        ),
      ),
    );
  });

  test('translates generic 500 into noOffers', () async {
    final dio = Dio();
    dio.httpClientAdapter = _FakeAdapter((options) async {
      return _jsonBody({'message': 'internal error'}, 500);
    });

    final service = OrderbookRecommendationsService(dio: dio);

    expect(
      service.fetchQuote(request),
      throwsA(
        isA<NoOrderbookRecommendationsException>().having(
          (e) => e.reason,
          'reason',
          NoOrderbookRecommendationsReason.noOffers,
        ),
      ),
    );
  });
}
