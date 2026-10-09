import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Named text styles; amounts use tabular figures so digits line up.
abstract final class AppTextStyles {
  static const List<FontFeature> _tabular = [FontFeature.tabularFigures()];

  static const TextStyle greeting = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  static const TextStyle userName = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle avatarInitials = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle balanceLabel = TextStyle(
    fontSize: 14,
    color: AppColors.whiteMuted,
  );
  static const TextStyle balanceAmount = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    fontFeatures: _tabular,
  );
  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    color: AppColors.whiteMuted,
  );
  static const TextStyle statAmount = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFeatures: _tabular,
  );

  static const TextStyle cardBank = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const TextStyle cardNetwork = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
    color: AppColors.whiteMuted,
  );
  static const TextStyle cardNumber = TextStyle(
    fontSize: 14,
    letterSpacing: 2,
    color: AppColors.whiteMuted,
    fontFeatures: _tabular,
  );
  static const TextStyle cardBalance = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFeatures: _tabular,
  );

  static const TextStyle tileTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle tileSubtitle = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
  static const TextStyle tileAmount = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFeatures: _tabular,
  );

  static const TextStyle emptyMessage = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle detailTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle detailAmount = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    fontFeatures: _tabular,
  );
  static const TextStyle detailDate = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  static const TextStyle tag = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const TextStyle infoLabel = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  static const TextStyle infoValue = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle budgetAmount = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFeatures: _tabular,
  );
}
