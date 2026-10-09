import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/category.dart';

/// Shows the gradient banner with back and favorite buttons and the category
/// icon overlapping the banner's bottom edge.
class DetailBanner extends StatelessWidget {
  const DetailBanner({
    super.key,
    required this.category,
    required this.isFavorite,
    required this.onBack,
    required this.onToggleFavorite,
  });

  final Category category;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onToggleFavorite;

  static const double _iconOverlap = AppConstants.bannerIconSize / 2;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top + AppSpacing.sm;

    return SizedBox(
      height: AppConstants.bannerHeight + _iconOverlap,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: AppConstants.bannerHeight,
            child: _BannerBackground(color: category.color),
          ),
          Positioned(
            top: topInset,
            left: AppSpacing.sm,
            child: _BannerButton(
              icon: Icons.arrow_back,
              tooltip: 'Артқа',
              onPressed: onBack,
            ),
          ),
          Positioned(
            top: topInset,
            right: AppSpacing.sm,
            child: _BannerButton(
              icon: isFavorite ? Icons.star : Icons.star_border,
              tooltip: isFavorite
                  ? 'Таңдаулылардан алып тастау'
                  : 'Таңдаулыларға қосу',
              iconColor: isFavorite ? AppColors.favorite : AppColors.white,
              onPressed: onToggleFavorite,
            ),
          ),
          Positioned(
            top: AppConstants.bannerHeight - _iconOverlap,
            left: 0,
            right: 0,
            child: Center(child: _BannerIcon(category: category)),
          ),
        ],
      ),
    );
  }
}

class _BannerBackground extends StatelessWidget {
  const _BannerBackground({required this.color});

  final Color color;

  static const double _darkenAmount = 0.35;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            Color.lerp(color, AppColors.black, _darkenAmount) ?? color,
          ],
        ),
      ),
    );
  }
}

class _BannerButton extends StatelessWidget {
  const _BannerButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.iconColor = AppColors.white,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon),
      color: iconColor,
      style: IconButton.styleFrom(backgroundColor: AppColors.whiteOverlay),
    );
  }
}

class _BannerIcon extends StatelessWidget {
  const _BannerIcon({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.bannerIconSize,
      height: AppConstants.bannerIconSize,
      decoration: BoxDecoration(
        color: category.color,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.background,
          width: AppConstants.bannerIconBorder,
        ),
      ),
      child: Icon(
        category.icon,
        color: AppColors.white,
        size: AppConstants.bannerIconSize / 2,
      ),
    );
  }
}
