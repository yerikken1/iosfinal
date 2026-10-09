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

/// Formats [amount] as money with thousands separators, e.g. `$1,234.50`.
///
/// Pass `decimals: false` for a rounded whole amount, e.g. `$1,235`.
String formatMoney(double amount, {bool decimals = true}) {
  final fixed = amount.abs().toStringAsFixed(decimals ? 2 : 0);
  final parts = fixed.split('.');
  final digits = parts.first;

  final grouped = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      grouped.write(',');
    }
    grouped.write(digits[i]);
  }

  final sign = amount < 0 ? '-' : '';
  final fraction = decimals ? '.${parts.last}' : '';
  return '$sign${AppConstants.currencySymbol}$grouped$fraction';
}

/// Formats a transaction amount with an explicit sign: `+` income, `-` expense.
String formatSignedMoney(double amount, {required bool isIncome}) {
  return '${isIncome ? '+' : '-'}${formatMoney(amount.abs())}';
}

/// Formats [date] as a readable Kazakh date, e.g. `9 қазан 2026`.
String formatDate(DateTime date) {
  return '${date.day} ${_monthNames[date.month - 1]} ${date.year}';
}
