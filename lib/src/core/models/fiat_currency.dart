class FiatCurrency {
  const FiatCurrency({
    required this.code,
    required this.assetPath,
    this.currencyId,
    this.externalId,
  });

  final String code;
  final String assetPath;
  final String? currencyId;
  final String? externalId;

  factory FiatCurrency.fromMap(Map<String, dynamic> map) {
    return FiatCurrency(
      code: map['symbol'] as String,
      assetPath: map['iconUrl'] as String? ?? '',
      currencyId: map['id'] as String?,
      externalId: map['externalId'] as String?,
    );
  }
}
