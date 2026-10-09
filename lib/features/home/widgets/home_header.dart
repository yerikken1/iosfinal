import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Shows a greeting with the user's name and their avatar initials.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.userName});

  final String userName;

  String get _initials => userName
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome back,', style: AppTextStyles.greeting),
              const SizedBox(height: AppSpacing.xs),
              Text(
                userName,
                style: AppTextStyles.userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        CircleAvatar(
          radius: AppConstants.avatarSize / 2,
          backgroundColor: AppColors.primary,
          child: Text(_initials, style: AppTextStyles.avatarInitials),
        ),
      ],
    );
  }
}
