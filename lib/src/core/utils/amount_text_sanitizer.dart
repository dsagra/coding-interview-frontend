String sanitizeAmountText(String value) {
  final buffer = StringBuffer();
  var hasDot = false;

  for (final rune in value.runes) {
    final character = String.fromCharCode(rune);

    if (RegExp(r'[0-9]').hasMatch(character)) {
      buffer.write(character);
      continue;
    }

    if (character == '.' && !hasDot && buffer.isNotEmpty) {
      hasDot = true;
      buffer.write(character);
    }
  }

  final sanitized = buffer.toString();
  if (sanitized.isEmpty) {
    return '';
  }

  final parts = sanitized.split('.');
  final integerPart = parts.first.replaceFirst(RegExp(r'^0+(?=\d)'), '');
  final decimalPart = parts.length > 1 ? parts.sublist(1).join() : '';

  if (integerPart.isEmpty && decimalPart.isEmpty) {
    return '';
  }

  if (decimalPart.isEmpty) {
    return integerPart;
  }

  return '$integerPart.$decimalPart';
}
