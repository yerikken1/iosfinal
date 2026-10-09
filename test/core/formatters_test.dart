import 'package:flutter_test/flutter_test.dart';
import 'package:pocket/core/constants/app_constants.dart';
import 'package:pocket/core/utils/formatters.dart';

void main() {
  const symbol = AppConstants.currencySymbol;
  const space = '\u00A0';

  group('formatMoney', () {
    test('puts the currency symbol after the amount', () {
      expect(formatMoney(500), '500$space$symbol');
      expect(formatMoney(0), '0$space$symbol');
    });

    test('groups thousands with spaces', () {
      expect(formatMoney(999), '999$space$symbol');
      expect(formatMoney(18400), '18${space}400$space$symbol');
      expect(formatMoney(1234567), '1${space}234${space}567$space$symbol');
    });

    test('shows a comma fraction only when there is one', () {
      expect(formatMoney(1234.5), '1${space}234,50$space$symbol');
      expect(formatMoney(86.4), '86,40$space$symbol');
      expect(formatMoney(86), '86$space$symbol');
    });

    test('puts the minus sign first', () {
      expect(formatMoney(-2500), '-2${space}500$space$symbol');
    });
  });

  group('formatSignedMoney', () {
    test('prefixes income with a plus', () {
      expect(
        formatSignedMoney(650000, isIncome: true),
        '+650${space}000$space$symbol',
      );
    });

    test('prefixes expenses with a minus', () {
      expect(
        formatSignedMoney(2500, isIncome: false),
        '-2${space}500$space$symbol',
      );
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
