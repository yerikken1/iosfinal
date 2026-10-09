import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/transaction.dart';

/// Shows one transaction as a card with its icon, title, amount and star.
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final Transaction transaction;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final category = transaction.category;

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.xs,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: AppConstants.tileIconSize / 2,
                backgroundColor: category.color,
                child: Icon(category.icon, color: AppColors.white),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: AppTextStyles.tileTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${category.name} · ${formatDate(transaction.date)}',
                      style: AppTextStyles.tileSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                formatSignedMoney(
                  transaction.amount,
                  isIncome: transaction.isIncome,
                ),
                style: AppTextStyles.tileAmount.copyWith(
                  color: transaction.isIncome
                      ? AppColors.income
                      : AppColors.expense,
                ),
              ),
              IconButton(
                onPressed: onToggleFavorite,
                tooltip: isFavorite
                    ? 'Таңдаулылардан алып тастау'
                    : 'Таңдаулыларға қосу',
                icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                color: isFavorite
                    ? AppColors.favorite
                    : AppColors.favoriteInactive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
