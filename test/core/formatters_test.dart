import 'package:flutter_test/flutter_test.dart';
import 'package:pocket/core/constants/app_constants.dart';
import 'package:pocket/core/utils/formatters.dart';

void main() {
  const symbol = AppConstants.currencySymbol;

  group('formatMoney', () {
    test('always shows two decimals', () {
      expect(formatMoney(12.5), '${symbol}12.50');
      expect(formatMoney(0), '${symbol}0.00');
    });

    test('groups thousands with commas', () {
      expect(formatMoney(999), '${symbol}999.00');
      expect(formatMoney(1234.5), '${symbol}1,234.50');
      expect(formatMoney(1234567.89), '${symbol}1,234,567.89');
    });

    test('puts the minus sign before the currency symbol', () {
      expect(formatMoney(-86.4), '-${symbol}86.40');
    });

    test('drops decimals when asked', () {
      expect(formatMoney(320, decimals: false), '${symbol}320');
      expect(formatMoney(1499.6, decimals: false), '${symbol}1,500');
    });
  });

  group('formatSignedMoney', () {
    test('prefixes income with a plus', () {
      expect(formatSignedMoney(4200, isIncome: true), '+${symbol}4,200.00');
    });

    test('prefixes expenses with a minus', () {
      expect(formatSignedMoney(12.5, isIncome: false), '-${symbol}12.50');
    });
  });

  group('formatDate', () {
    test('uses day, Kazakh month name and year', () {
      expect(formatDate(DateTime(2026, 10, 9)), '9 қазан 2026');
      expect(formatDate(DateTime(2025, 1, 31)), '31 қаңтар 2025');
      expect(formatDate(DateTime(2024, 12, 1)), '1 желтоқсан 2024');
    });
  });
}
