import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/payment_card.dart';

/// Shows the user's payment cards in a horizontally scrolling row.
class PaymentCardCarousel extends StatelessWidget {
  const PaymentCardCarousel({super.key, required this.cards});

  final List<PaymentCard> cards;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final card in cards)
            Padding(
              padding: EdgeInsets.only(
                right: card == cards.last ? 0 : AppSpacing.md,
              ),
              child: _PaymentCardView(card: card),
            ),
        ],
      ),
    );
  }
}

class _PaymentCardView extends StatelessWidget {
  const _PaymentCardView({required this.card});

  final PaymentCard card;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.paymentCardWidth,
      height: AppConstants.paymentCardHeight,
      child: Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: card.gradient,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        card.bankName,
                        style: AppTextStyles.cardBank,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      card.network.toUpperCase(),
                      style: AppTextStyles.cardNetwork,
                    ),
                  ],
                ),
                const Spacer(),
                Text(card.maskedNumber, style: AppTextStyles.cardNumber),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatMoney(card.balance),
                  style: AppTextStyles.cardBalance,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
