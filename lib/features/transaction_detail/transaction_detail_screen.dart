import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/transaction.dart';
import 'widgets/budget_progress_card.dart';
import 'widgets/detail_banner.dart';
import 'widgets/detail_info_card.dart';
import 'widgets/tag_wrap.dart';

/// Shows one transaction in full: banner, amount, tags, details and budget.
class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({
    super.key,
    required this.transaction,
    required this.isFavorite,
    required this.categoryTotal,
    required this.onToggleFavorite,
  });

  final Transaction transaction;
  final bool isFavorite;

  /// This month's total for the transaction's category.
  final double categoryTotal;

  /// Tells the home screen, which owns the favorites, to flip this one.
  final VoidCallback onToggleFavorite;

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late bool _isFavorite = widget.isFavorite;

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onToggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= AppConstants.tabletBreakpoint;

          return SingleChildScrollView(
            child: Column(
              children: [
                DetailBanner(
                  category: transaction.category,
                  isFavorite: _isFavorite,
                  onBack: () => Navigator.of(context).pop(),
                  onToggleFavorite: _toggleFavorite,
                ),
                _DetailBody(
                  transaction: transaction,
                  categoryTotal: widget.categoryTotal,
                  isWide: isWide,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.transaction,
    required this.categoryTotal,
    required this.isWide,
  });

  final Transaction transaction;
  final double categoryTotal;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final category = transaction.category;
    final infoCard = DetailInfoCard(transaction: transaction);
    final budgetCard = BudgetProgressCard(
      title: '${category.name} ${transaction.isIncome ? 'goal' : 'budget'}',
      spent: categoryTotal,
      limit: category.monthlyBudget,
      color: category.color,
    );

    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                _TitleBlock(transaction: transaction),
                const SizedBox(height: AppSpacing.lg),
                TagWrap(tags: transaction.tags, color: category.color),
                const SizedBox(height: AppSpacing.xl),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: infoCard),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(child: budgetCard),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      infoCard,
                      const SizedBox(height: AppSpacing.lg),
                      budgetCard,
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          transaction.title,
          style: AppTextStyles.detailTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            formatSignedMoney(
              transaction.amount,
              isIncome: transaction.isIncome,
            ),
            style: AppTextStyles.detailAmount.copyWith(
              color: transaction.isIncome
                  ? AppColors.income
                  : AppColors.expense,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(formatDate(transaction.date), style: AppTextStyles.detailDate),
      ],
    );
  }
}
