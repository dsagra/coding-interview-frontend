import 'package:flutter_test/flutter_test.dart';
import 'package:coding_interview_frontend/src/core/functions/functions.dart';

void main() {
  group('asDouble', () {
    test('returns numeric values as double', () {
      expect(asDouble(5), 5.0);
      expect(asDouble(2.5), 2.5);
    });

    test('parses valid string values', () {
      expect(asDouble('3.14'), 3.14);
    });

    test('returns zero for invalid values', () {
      expect(asDouble('abc'), 0);
      expect(asDouble(null), 0);
      expect(asDouble(const {}), 0);
    });
  });

  group('parseAmount', () {
    test('parses dot decimal values', () {
      expect(parseAmount('10.5'), 10.5);
    });

    test('parses comma decimal values', () {
      expect(parseAmount('10,5'), 10.5);
    });

    test('trims surrounding spaces', () {
      expect(parseAmount('  7.25  '), 7.25);
    });

    test('returns zero for invalid values', () {
      expect(parseAmount(''), 0);
      expect(parseAmount('hola'), 0);
    });
  });

  group('formatMinutes', () {
    test('returns zero minutes for non-positive values', () {
      expect(formatMinutes(0), '0 Min');
      expect(formatMinutes(-1), '0 Min');
    });

    test('rounds up positive minute values', () {
      expect(formatMinutes(1.1), '2 Min');
      expect(formatMinutes(2.0), '2 Min');
    });
  });
}
