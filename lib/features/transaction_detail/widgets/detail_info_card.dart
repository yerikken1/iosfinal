import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/transaction.dart';

/// Shows the transaction's category, card, status and note as label/value rows.
class DetailInfoCard extends StatelessWidget {
  const DetailInfoCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Details', style: AppTextStyles.cardTitle),
            const SizedBox(height: AppSpacing.sm),
            _InfoRow(label: 'Category', value: transaction.category.name),
            const Divider(),
            _InfoRow(
              label: 'Payment card',
              value:
                  '${transaction.card.bankName} ${transaction.card.maskedNumber}',
            ),
            const Divider(),
            _InfoRow(label: 'Status', value: transaction.status.label),
            const Divider(),
            _InfoRow(label: 'Note', value: transaction.note),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.infoLabel),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.infoValue,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
