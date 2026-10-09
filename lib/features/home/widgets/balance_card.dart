import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';

/// Shows the total balance with this month's income and expenses side by side.
class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.monthlyIncome,
    required this.monthlyExpenses,
  });

  final double totalBalance;
  final double monthlyIncome;
  final double monthlyExpenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Жалпы баланс', style: AppTextStyles.balanceLabel),
            const SizedBox(height: AppSpacing.xs),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                formatMoney(totalBalance),
                style: AppTextStyles.balanceAmount,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Осы ай', style: AppTextStyles.statLabel),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _BalanceStat(
                    icon: Icons.south_west,
                    label: 'Кіріс',
                    amount: monthlyIncome,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _BalanceStat(
                    icon: Icons.north_east,
                    label: 'Шығыс',
                    amount: monthlyExpenses,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceStat extends StatelessWidget {
  const _BalanceStat({
    required this.icon,
    required this.label,
    required this.amount,
  });

  final IconData icon;
  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppConstants.statIconSize,
          height: AppConstants.statIconSize,
          decoration: const BoxDecoration(
            color: AppColors.whiteOverlay,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.white, size: AppSpacing.lg),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.statLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  formatMoney(amount),
                  style: AppTextStyles.statAmount,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
