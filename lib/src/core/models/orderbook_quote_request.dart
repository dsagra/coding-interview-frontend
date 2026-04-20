class OrderbookQuoteRequest {
  const OrderbookQuoteRequest({
    required this.type,
    required this.cryptoCurrencyId,
    required this.fiatCurrencyId,
    required this.amount,
    required this.amountCurrencyId,
  });

  final int type;
  final String cryptoCurrencyId;
  final String fiatCurrencyId;
  final double amount;
  final String amountCurrencyId;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OrderbookQuoteRequest &&
            runtimeType == other.runtimeType &&
            type == other.type &&
            cryptoCurrencyId == other.cryptoCurrencyId &&
            fiatCurrencyId == other.fiatCurrencyId &&
            amount == other.amount &&
            amountCurrencyId == other.amountCurrencyId;
  }

  @override
  int get hashCode {
    return Object.hash(
      type,
      cryptoCurrencyId,
      fiatCurrencyId,
      amount,
      amountCurrencyId,
    );
  }

  factory OrderbookQuoteRequest.fromMap(Map<String, dynamic> map) {
    return OrderbookQuoteRequest(
      type: map['type'] as int,
      cryptoCurrencyId: map['cryptoCurrencyId'] as String,
      fiatCurrencyId: map['fiatCurrencyId'] as String,
      amount: (map['amount'] as num).toDouble(),
      amountCurrencyId: map['amountCurrencyId'] as String,
    );
  }
}
