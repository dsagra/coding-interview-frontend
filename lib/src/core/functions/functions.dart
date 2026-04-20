double asDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

double parseAmount(String value) {
  final normalized = value.replaceAll(',', '.').trim();
  return double.tryParse(normalized) ?? 0;
}

String formatMinutes(double minutes) {
  if (minutes <= 0) {
    return '0 Min';
  }

  return '${minutes.ceil()} Min';
}
