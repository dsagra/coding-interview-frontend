import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../functions/functions.dart';
import '../models/no_orderbook_recommendations_exception.dart';
import '../models/orderbook_quote.dart';
import '../models/orderbook_quote_request.dart';
import '../models/selectable_currencies.dart';
import 'logger_service.dart';

part 'orderbook_recommendations_service.g.dart';

@Riverpod(keepAlive: true)
OrderbookRecommendationsService orderbookRecommendationsService(Ref ref) {
  return OrderbookRecommendationsService();
}

class OrderbookRecommendationsService {
  OrderbookRecommendationsService({Dio? dio})
    : _apiClient = _OrderbookApiClient(dio: dio ?? Dio()),
      _responseParser = const _OrderbookResponseParser(),
      _errorTranslator = const _OrderbookErrorTranslator();

  final _OrderbookApiClient _apiClient;
  final _OrderbookResponseParser _responseParser;
  final _OrderbookErrorTranslator _errorTranslator;
  static const String _tag = 'OrderbookRecommendationsService';

  Future<SelectableCurrencies> fetchSelectableCurrencies() async {
    LoggerService.instance.info(
      _tag,
      'Fetching selectable currencies from API',
    );

    final payload = await _apiClient.fetchCurrenciesPayload();
    final result = _responseParser.parseSelectableCurrencies(payload);

    LoggerService.instance.info(
      _tag,
      'Loaded ${result.fiatCurrencies.length} fiat and ${result.cryptoCurrencies.length} crypto currencies',
    );

    return result;
  }

  Future<OrderbookQuote> fetchQuote(OrderbookQuoteRequest request) async {
    if (request.amount <= 0) {
      LoggerService.instance.warning(
        _tag,
        'Skipping quote request because amount is not valid: ${request.amount}',
      );
      throw const NoOrderbookRecommendationsException.invalidAmount();
    }

    LoggerService.instance.info(
      _tag,
      'Fetching quote for crypto=${request.cryptoCurrencyId}, fiat=${request.fiatCurrencyId}, amount=${request.amount}',
    );

    late final Object payload;
    try {
      payload = await _apiClient.fetchQuotePayload(request);
    } on DioException catch (error) {
      final translatedError = _errorTranslator.toException(error, request);
      if (translatedError is NoOrderbookRecommendationsException) {
        LoggerService.instance.warning(_tag, translatedError.message);
      } else {
        LoggerService.instance.error(
          _tag,
          'Orderbook API error: ${error.message}',
          error.stackTrace,
        );
      }
      throw translatedError;
    }

    final quote = _responseParser.parseQuote(payload, request);

    LoggerService.instance.info(
      _tag,
      'Quote received - Rate: ${quote.estimatedRate}, Receive: ${quote.receiveAmount}, Time: ${quote.estimatedTime}',
    );

    return quote;
  }
}

class _OrderbookApiClient {
  _OrderbookApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static const String _quoteEndpoint =
      'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations';
  static const String _currenciesEndpoint =
      'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/currencies';

  Future<Object> fetchCurrenciesPayload() async {
    final response = await _dio.get<Object>(_currenciesEndpoint);
    return response.data as Object;
  }

  Future<Object> fetchQuotePayload(OrderbookQuoteRequest request) async {
    final response = await _dio.get<Object>(
      _quoteEndpoint,
      queryParameters: {
        'type': request.type,
        'cryptoCurrencyId': request.cryptoCurrencyId,
        'fiatCurrencyId': request.fiatCurrencyId,
        'amount': request.amount,
        'amountCurrencyId': request.amountCurrencyId,
      },
    );

    return response.data as Object;
  }
}

class _OrderbookResponseParser {
  const _OrderbookResponseParser();

  SelectableCurrencies parseSelectableCurrencies(Object payload) {
    if (payload is! Map<String, dynamic>) {
      throw Exception('Currencies API error: invalid response payload');
    }

    final data = payload['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Currencies API error: missing data field');
    }

    final currencies = data['currencies'];
    if (currencies is! List) {
      throw Exception('Currencies API error: missing currencies list');
    }

    return SelectableCurrencies.fromCurrenciesList(currencies);
  }

  OrderbookQuote parseQuote(Object payload, OrderbookQuoteRequest request) {
    if (payload is! Map<String, dynamic>) {
      throw Exception('Orderbook API error: invalid response payload');
    }

    final data = payload['data'] as Map<String, dynamic>?;
    final byPrice = data?['byPrice'] as Map<String, dynamic>?;
    if (byPrice == null || byPrice.isEmpty) {
      throw NoOrderbookRecommendationsException.noOffers(
        cryptoCurrencyId: request.cryptoCurrencyId,
        fiatCurrencyId: request.fiatCurrencyId,
      );
    }

    final rawRate = byPrice['fiatToCryptoExchangeRate'];
    final rate = asDouble(rawRate);
    final offerMakerStats = byPrice['offerMakerStats'] as Map<String, dynamic>?;
    final receiveAmount = request.type == 0
        ? request.amount * rate
        : (rate == 0 ? 0.0 : request.amount / rate);

    return OrderbookQuote.fromMap({
      'rate': rawRate,
      'offerMakerStats': offerMakerStats,
      'receiveAmount': receiveAmount,
    });
  }
}

class _OrderbookErrorTranslator {
  const _OrderbookErrorTranslator();

  Exception toException(DioException error, OrderbookQuoteRequest request) {
    final responseData = error.response?.data;
    final reason = responseData is Map<String, dynamic>
        ? (responseData['reason']?.toString() ?? '')
        : '';
    final message = responseData is Map<String, dynamic>
        ? (responseData['message']?.toString() ?? '')
        : responseData?.toString() ?? '';
    final statusCode = error.response?.statusCode;
    final dioMessage = error.message ?? '';
    final statusMessage = error.response?.statusMessage ?? '';
    final combinedErrorText =
        '${reason.toLowerCase()} ${message.toLowerCase()} ${dioMessage.toLowerCase()} ${statusMessage.toLowerCase()}';

    NoOrderbookRecommendationsException noOffersException() {
      return NoOrderbookRecommendationsException.noOffers(
        cryptoCurrencyId: request.cryptoCurrencyId,
        fiatCurrencyId: request.fiatCurrencyId,
      );
    }

    if (reason.contains('invalid crypto currency id')) {
      return const NoOrderbookRecommendationsException.unsupportedCrypto();
    }

    if (combinedErrorText.contains('no offers for crypto=')) {
      return noOffersException();
    }

    if (statusCode == 500 && combinedErrorText.contains('no offers')) {
      return noOffersException();
    }

    if (statusCode == 500) {
      return noOffersException();
    }

    return Exception('Orderbook API error: ${error.message}');
  }
}
