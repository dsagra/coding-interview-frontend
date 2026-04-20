import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/utils/amount_text_sanitizer.dart';

void main() {
  group('sanitizeAmountText', () {
    test('keeps numbers and one decimal dot', () {
      expect(sanitizeAmountText('12.34.56abc'), '12.3456');
    });

    test('drops leading zeros in integer part', () {
      expect(sanitizeAmountText('00012'), '12');
    });

    test('allows decimals after leading zeros', () {
      expect(sanitizeAmountText('00012.50'), '12.50');
    });

    test('returns empty for invalid-only text', () {
      expect(sanitizeAmountText('abc'), '');
      expect(sanitizeAmountText('.'), '');
    });

    test('ignores dot when there is no integer part yet', () {
      expect(sanitizeAmountText('.5'), '5');
    });
  });
}
