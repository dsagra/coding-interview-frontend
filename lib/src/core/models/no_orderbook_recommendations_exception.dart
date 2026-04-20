enum NoOrderbookRecommendationsReason {
  noOffers,
  invalidAmount,
  unsupportedCrypto,
  unknown,
}

class NoOrderbookRecommendationsException implements Exception {
  const NoOrderbookRecommendationsException({
    required this.message,
    required this.reason,
    this.cryptoCurrencyId,
    this.fiatCurrencyId,
  });

  const NoOrderbookRecommendationsException.noOffers({
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
  }) : this(
         message:
             'No offers for crypto=$cryptoCurrencyId, fiat=$fiatCurrencyId',
         reason: NoOrderbookRecommendationsReason.noOffers,
         cryptoCurrencyId: cryptoCurrencyId,
         fiatCurrencyId: fiatCurrencyId,
       );

  const NoOrderbookRecommendationsException.invalidAmount()
    : this(
        message: 'Monto invalido',
        reason: NoOrderbookRecommendationsReason.invalidAmount,
      );

  const NoOrderbookRecommendationsException.unsupportedCrypto()
    : this(
        message: 'Cripto no soportada',
        reason: NoOrderbookRecommendationsReason.unsupportedCrypto,
      );

  final String message;
  final NoOrderbookRecommendationsReason reason;
  final String? cryptoCurrencyId;
  final String? fiatCurrencyId;

  String get deduplicationKey {
    return '$reason:${cryptoCurrencyId ?? ''}:${fiatCurrencyId ?? ''}';
  }

  @override
  String toString() => message;
}
