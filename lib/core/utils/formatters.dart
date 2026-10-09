import '../constants/app_constants.dart';

const List<String> _monthNames = [
  'қаңтар',
  'ақпан',
  'наурыз',
  'сәуір',
  'мамыр',
  'маусым',
  'шілде',
  'тамыз',
  'қыркүйек',
  'қазан',
  'қараша',
  'желтоқсан',
];

/// Non-breaking space, so an amount never wraps in the middle.
const String _space = '\u00A0';

/// Formats [amount] the Kazakh way, e.g. `1 234,50 ₸`.
///
/// Thousands are separated by spaces, the decimal mark is a comma, the
/// currency symbol follows the number, and whole amounts show no fraction.
String formatMoney(double amount) {
  final parts = amount.abs().toStringAsFixed(2).split('.');
  final digits = parts.first;

  final grouped = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      grouped.write(_space);
    }
    grouped.write(digits[i]);
  }

  final sign = amount < 0 ? '-' : '';
  final fraction = parts.last == '00' ? '' : ',${parts.last}';
  return '$sign$grouped$fraction$_space${AppConstants.currencySymbol}';
}

/// Formats a transaction amount with an explicit sign: `+` income, `-` expense.
String formatSignedMoney(double amount, {required bool isIncome}) {
  return '${isIncome ? '+' : '-'}${formatMoney(amount.abs())}';
}

/// Formats [date] as a readable Kazakh date, e.g. `9 қазан 2026`.
String formatDate(DateTime date) {
  return '${date.day} ${_monthNames[date.month - 1]} ${date.year}';
}
