import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';
import '../transaction_detail/transaction_detail_screen.dart';
import 'widgets/balance_card.dart';
import 'widgets/empty_state.dart';
import 'widgets/home_header.dart';
import 'widgets/payment_card_carousel.dart';
import 'widgets/transaction_tile.dart';
import 'widgets/type_toggle.dart';

/// Shows the balance, payment cards and a filterable list of transactions.
///
/// Owns the selected filter and the set of favorite transaction ids.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = MockData.transactions;
  final Set<String> _favoriteIds = <String>{};
  TransactionFilter _filter = TransactionFilter.all;
  bool _favoritesOnly = false;

  List<Transaction> get _visibleTransactions => _transactions
      .where(_filter.matches)
      .where((t) => !_favoritesOnly || _favoriteIds.contains(t.id))
      .toList();

  double get _totalBalance =>
      MockData.cards.fold(0, (sum, card) => sum + card.balance);

  double _totalOfType(TransactionType type) => _transactions
      .where((t) => t.type == type)
      .fold(0, (sum, t) => sum + t.amount);

  double _totalInCategory(Category category) => _transactions
      .where((t) => t.category.id == category.id)
      .fold(0, (sum, t) => sum + t.amount);

  void _selectFilter(TransactionFilter filter) {
    setState(() => _filter = filter);
  }

  void _toggleFavoritesOnly(bool value) {
    setState(() => _favoritesOnly = value);
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (!_favoriteIds.remove(id)) {
        _favoriteIds.add(id);
      }
    });
  }

  void _openDetail(Transaction transaction) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => TransactionDetailScreen(
          transaction: transaction,
          isFavorite: _favoriteIds.contains(transaction.id),
          categoryTotal: _totalInCategory(transaction.category),
          onToggleFavorite: () => _toggleFavorite(transaction.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeHeader(userName: MockData.userName),
                  const SizedBox(height: AppSpacing.xl),
                  BalanceCard(
                    totalBalance: _totalBalance,
                    monthlyIncome: _totalOfType(TransactionType.income),
                    monthlyExpenses: _totalOfType(TransactionType.expense),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const Text(
                    'Менің карталарым',
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const PaymentCardCarousel(cards: MockData.cards),
                  const SizedBox(height: AppSpacing.xl),
                  TypeToggle(selected: _filter, onChanged: _selectFilter),
                  const SizedBox(height: AppSpacing.md),
                  _TransactionsHeader(
                    favoritesOnly: _favoritesOnly,
                    onFavoritesOnlyChanged: _toggleFavoritesOnly,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _TransactionList(
                    transactions: _visibleTransactions,
                    favoriteIds: _favoriteIds,
                    onOpen: _openDetail,
                    onToggleFavorite: _toggleFavorite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionsHeader extends StatelessWidget {
  const _TransactionsHeader({
    required this.favoritesOnly,
    required this.onFavoritesOnlyChanged,
  });

  final bool favoritesOnly;
  final ValueChanged<bool> onFavoritesOnlyChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text('Транзакциялар', style: AppTextStyles.sectionTitle),
        ),
        FilterChip(
          label: const Text('Таңдаулылар'),
          selected: favoritesOnly,
          onSelected: onFavoritesOnlyChanged,
        ),
      ],
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({
    required this.transactions,
    required this.favoriteIds,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  final List<Transaction> transactions;
  final Set<String> favoriteIds;
  final ValueChanged<Transaction> onOpen;
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const EmptyState(message: 'Бұл сүзгіге сәйкес транзакция жоқ.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final transaction in transactions)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: TransactionTile(
              key: ValueKey(transaction.id),
              transaction: transaction,
              isFavorite: favoriteIds.contains(transaction.id),
              onTap: () => onOpen(transaction),
              onToggleFavorite: () => onToggleFavorite(transaction.id),
            ),
          ),
      ],
    );
  }
}
