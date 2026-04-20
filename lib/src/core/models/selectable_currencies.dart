import 'fiat_currency.dart';

class SelectableCurrencies {
  const SelectableCurrencies({
    required this.fiatCurrencies,
    required this.cryptoCurrencies,
  });

  final List<FiatCurrency> fiatCurrencies;
  final List<FiatCurrency> cryptoCurrencies;

  static SelectableCurrencies fromCurrenciesList(List<dynamic> currencies) {
    final fiatCurrencies = <FiatCurrency>[];
    final cryptoCurrencies = <FiatCurrency>[];

    for (final item in currencies) {
      if (item is! Map<String, dynamic>) continue;

      final type = item['type'];
      final symbol = item['symbol'];
      final id = item['id'];
      final enabled = item['enabled'] == true;
      final apiDisabled = item['apiDisabled'] == true;

      if (!enabled || apiDisabled || symbol is! String || id is! String) {
        continue;
      }

      final currency = FiatCurrency.fromMap(item);

      if (type == 0) fiatCurrencies.add(currency);
      if (type == 1) cryptoCurrencies.add(currency);
    }

    return SelectableCurrencies(
      fiatCurrencies: fiatCurrencies,
      cryptoCurrencies: cryptoCurrencies,
    );
  }
}
