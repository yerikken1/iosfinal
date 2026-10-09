import 'category.dart';
import 'payment_card.dart';

/// Whether money left or entered the account.
enum TransactionType { expense, income }

/// Processing state of a transaction.
enum TransactionStatus {
  completed('Completed'),
  pending('Pending');

  const TransactionStatus(this.label);

  final String label;
}

/// A single expense or income entry.
class Transaction {
  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.card,
    required this.date,
    required this.status,
    required this.note,
    this.labels = const [],
  });

  final String id;
  final String title;

  /// Always positive; [type] decides the sign shown in the UI.
  final double amount;
  final TransactionType type;
  final Category category;
  final PaymentCard card;
  final DateTime date;
  final TransactionStatus status;
  final String note;

  /// Extra descriptive labels such as `Recurring` or `Business`.
  final List<String> labels;

  bool get isIncome => type == TransactionType.income;

  /// Everything shown as a chip on the detail screen.
  List<String> get tags => [category.name, ...labels, card.shortLabel];
}
