import 'package:flutter/material.dart';

/// A spending or income category with its own icon, color and monthly budget.
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.monthlyBudget,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color color;

  /// Spending limit for expense categories, earning goal for income ones.
  final double monthlyBudget;
}
