import '../functions/functions.dart';

class OrderbookQuote {
  const OrderbookQuote({
    required this.fiatToCryptoExchangeRate,
    required this.estimatedRate,
    required this.receiveAmount,
    required this.estimatedTime,
  });

  final double fiatToCryptoExchangeRate;
  final double estimatedRate;
  final double receiveAmount;
  final String estimatedTime;

  factory OrderbookQuote.fromMap(Map<String, dynamic> map) {
    final fiatToCryptoExchangeRate = asDouble(map['rate']);
    final marketMakerOrderTime = asDouble(
      map['offerMakerStats']?['marketMakerOrderTime'],
    );
    final estimatedRate = fiatToCryptoExchangeRate;
    final receiveAmount = map['receiveAmount'] as double? ?? 0.0;
    final estimatedTime = formatMinutes(marketMakerOrderTime);

    return OrderbookQuote(
      fiatToCryptoExchangeRate: fiatToCryptoExchangeRate,
      estimatedRate: estimatedRate,
      receiveAmount: receiveAmount,
      estimatedTime: estimatedTime,
    );
  }
}
