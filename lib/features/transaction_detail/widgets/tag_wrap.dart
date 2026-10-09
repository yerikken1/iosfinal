import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Shows tags as chips that wrap onto extra lines instead of overflowing.
class TagWrap extends StatelessWidget {
  const TagWrap({super.key, required this.tags, required this.color});

  final List<String> tags;
  final Color color;

  static const double _backgroundAlpha = 0.12;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final tag in tags)
          Chip(
            label: Text(tag),
            labelStyle: AppTextStyles.tag.copyWith(color: color),
            backgroundColor: color.withValues(alpha: _backgroundAlpha),
            side: BorderSide.none,
            shape: const StadiumBorder(),
          ),
      ],
    );
  }
}
