import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/category.dart';
import '../models/payment_card.dart';
import '../models/transaction.dart';

/// The only data source for Milestone 1: everything lives in memory.
abstract final class MockData {
  static const String userName = 'Alex Morgan';

  static const Category food = Category(
    id: 'food',
    name: 'Food',
    icon: Icons.restaurant,
    color: AppColors.food,
    monthlyBudget: 500,
  );
  static const Category transport = Category(
    id: 'transport',
    name: 'Transport',
    icon: Icons.directions_bus,
    color: AppColors.transport,
    monthlyBudget: 150,
  );
  static const Category shopping = Category(
    id: 'shopping',
    name: 'Shopping',
    icon: Icons.shopping_bag,
    color: AppColors.shopping,
    monthlyBudget: 300,
  );
  static const Category bills = Category(
    id: 'bills',
    name: 'Bills',
    icon: Icons.receipt_long,
    color: AppColors.bills,
    monthlyBudget: 400,
  );
  static const Category salary = Category(
    id: 'salary',
    name: 'Salary',
    icon: Icons.account_balance_wallet,
    color: AppColors.salary,
    monthlyBudget: 5000,
  );

  static const List<Category> categories = [
    food,
    transport,
    shopping,
    bills,
    salary,
  ];

  static const PaymentCard everydayCard = PaymentCard(
    id: 'card-1',
    bankName: 'Northwind Bank',
    network: 'Visa',
    lastFour: '4821',
    balance: 5240.50,
    gradient: AppColors.cardGradientTeal,
  );
  static const PaymentCard creditCard = PaymentCard(
    id: 'card-2',
    bankName: 'Aurora Credit',
    network: 'Mastercard',
    lastFour: '7730',
    balance: 1890.00,
    gradient: AppColors.cardGradientIndigo,
  );
  static const PaymentCard savingsCard = PaymentCard(
    id: 'card-3',
    bankName: 'Summit Savings',
    network: 'Visa',
    lastFour: '1005',
    balance: 3412.75,
    gradient: AppColors.cardGradientSunset,
  );

  static const List<PaymentCard> cards = [
    everydayCard,
    creditCard,
    savingsCard,
  ];

  static final List<Transaction> transactions = List.unmodifiable([
    Transaction(
      id: 't1',
      title: 'Whole Harvest Market',
      amount: 86.40,
      type: TransactionType.expense,
      category: food,
      card: everydayCard,
      date: DateTime(2026, 10, 9),
      status: TransactionStatus.pending,
      note: 'Weekend groceries and snacks.',
    ),
    Transaction(
      id: 't2',
      title: 'City Ride',
      amount: 18.75,
      type: TransactionType.expense,
      category: transport,
      card: creditCard,
      date: DateTime(2026, 10, 8),
      status: TransactionStatus.completed,
      note: 'Ride to the client office.',
      labels: const ['Business'],
    ),
    Transaction(
      id: 't3',
      title: 'Freelance project',
      amount: 650.00,
      type: TransactionType.income,
      category: salary,
      card: savingsCard,
      date: DateTime(2026, 10, 7),
      status: TransactionStatus.completed,
      note: 'Landing page design for a local studio.',
      labels: const ['Business'],
    ),
    Transaction(
      id: 't4',
      title: 'Blue Kettle Coffee',
      amount: 12.50,
      type: TransactionType.expense,
      category: food,
      card: everydayCard,
      date: DateTime(2026, 10, 7),
      status: TransactionStatus.completed,
      note: 'Flat white and a croissant.',
    ),
    Transaction(
      id: 't5',
      title: 'Stride Sportswear',
      amount: 129.99,
      type: TransactionType.expense,
      category: shopping,
      card: creditCard,
      date: DateTime(2026, 10, 6),
      status: TransactionStatus.completed,
      note: 'Running shoes.',
    ),
    Transaction(
      id: 't6',
      title: 'Electricity bill',
      amount: 92.30,
      type: TransactionType.expense,
      category: bills,
      card: everydayCard,
      date: DateTime(2026, 10, 5),
      status: TransactionStatus.completed,
      note: 'September usage, paid by auto-debit.',
      labels: const ['Recurring'],
    ),
    Transaction(
      id: 't7',
      title: 'Sushi Zen',
      amount: 64.10,
      type: TransactionType.expense,
      category: food,
      card: creditCard,
      date: DateTime(2026, 10, 4),
      status: TransactionStatus.completed,
      note: 'Dinner with the product team.',
      labels: const ['Business'],
    ),
    Transaction(
      id: 't8',
      title: 'Metro monthly pass',
      amount: 45.00,
      type: TransactionType.expense,
      category: transport,
      card: everydayCard,
      date: DateTime(2026, 10, 3),
      status: TransactionStatus.completed,
      note: 'Unlimited rides for October.',
      labels: const ['Recurring'],
    ),
    Transaction(
      id: 't9',
      title: 'Streamly subscription',
      amount: 15.99,
      type: TransactionType.expense,
      category: bills,
      card: creditCard,
      date: DateTime(2026, 10, 2),
      status: TransactionStatus.completed,
      note: 'Standard plan.',
      labels: const ['Recurring'],
    ),
    Transaction(
      id: 't10',
      title: 'Parcel Depot order',
      amount: 54.20,
      type: TransactionType.expense,
      category: shopping,
      card: everydayCard,
      date: DateTime(2026, 10, 2),
      status: TransactionStatus.completed,
      note: 'Desk lamp and cable organizers.',
    ),
    Transaction(
      id: 't11',
      title: 'Monthly salary',
      amount: 4200.00,
      type: TransactionType.income,
      category: salary,
      card: everydayCard,
      date: DateTime(2026, 10, 1),
      status: TransactionStatus.completed,
      note: 'October payroll.',
      labels: const ['Recurring'],
    ),
    Transaction(
      id: 't12',
      title: 'Weekly groceries',
      amount: 157.00,
      type: TransactionType.expense,
      category: food,
      card: everydayCard,
      date: DateTime(2026, 10, 1),
      status: TransactionStatus.completed,
      note: 'Stocking up for the month.',
      labels: const ['Recurring'],
    ),
  ]);
}
