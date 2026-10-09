import 'package:flutter/material.dart';

/// A bank card shown in the "My cards" carousel.
class PaymentCard {
  const PaymentCard({
    required this.id,
    required this.bankName,
    required this.network,
    required this.lastFour,
    required this.balance,
    required this.gradient,
  });

  final String id;
  final String bankName;
  final String network;
  final String lastFour;
  final double balance;
  final List<Color> gradient;

  /// Card number with everything but the last four digits hidden.
  String get maskedNumber => '•••• $lastFour';

  /// Compact label used in tags and detail rows, e.g. `Visa •• 4821`.
  String get shortLabel => '$network •• $lastFour';
}
