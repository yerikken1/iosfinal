/// App-wide constants that are not spacing or colors.
abstract final class AppConstants {
  static const String appName = 'Pocket';

  /// Change the currency for the whole app here.
  static const String currencySymbol = r'$';

  /// Width at which the detail screen switches to two columns.
  static const double tabletBreakpoint = 600;

  /// Content never grows wider than this on large screens.
  static const double maxContentWidth = 960;

  static const double cardRadius = 16;
  static const double cardElevation = 1;

  static const double avatarSize = 48;
  static const double tileIconSize = 44;
  static const double statIconSize = 36;
  static const double emptyStateIconSize = 56;

  static const double paymentCardWidth = 250;
  static const double paymentCardHeight = 150;

  static const double bannerHeight = 200;
  static const double bannerIconSize = 96;
  static const double bannerIconBorder = 4;

  static const double progressBarHeight = 10;
}
