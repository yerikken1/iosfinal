import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';

/// Shows how much of a monthly budget (or income goal) has been used.
class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({
    super.key,
    required this.title,
    required this.spent,
    required this.limit,
    required this.color,
  });

  final String title;
  final double spent;
  final double limit;
  final Color color;

  double get _progress => limit <= 0 ? 0 : (spent / limit).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    final percent = (_progress * 100).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.cardTitle),
            const SizedBox(height: AppSpacing.md),
            Text(
              '${formatMoney(spent)} / '
              '${formatMoney(limit)}',
              style: AppTextStyles.budgetAmount,
            ),
            const SizedBox(height: AppSpacing.md),
            LinearProgressIndicator(
              value: _progress,
              minHeight: AppConstants.progressBarHeight,
              color: color,
              backgroundColor: AppColors.divider,
              borderRadius: BorderRadius.circular(
                AppConstants.progressBarHeight,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Осы айда $percent%',
                    style: AppTextStyles.infoLabel,
                  ),
                ),
                Text(
                  '${formatMoney((limit - spent).abs())} '
                  '${spent > limit ? 'артық' : 'қалды'}',
                  style: AppTextStyles.infoValue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
