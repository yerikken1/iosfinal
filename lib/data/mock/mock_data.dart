import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/category.dart';
import '../models/payment_card.dart';
import '../models/transaction.dart';

/// The only data source for Milestone 1: everything lives in memory.
abstract final class MockData {
  static const String userName = 'Айдана Еркенгазина';

  static const String _recurring = 'Тұрақты';
  static const String _business = 'Жұмыс';

  static const Category food = Category(
    id: 'food',
    name: 'Тамақ',
    icon: Icons.restaurant,
    color: AppColors.food,
    monthlyBudget: 150000,
  );
  static const Category transport = Category(
    id: 'transport',
    name: 'Көлік',
    icon: Icons.directions_bus,
    color: AppColors.transport,
    monthlyBudget: 40000,
  );
  static const Category shopping = Category(
    id: 'shopping',
    name: 'Сауда',
    icon: Icons.shopping_bag,
    color: AppColors.shopping,
    monthlyBudget: 100000,
  );
  static const Category bills = Category(
    id: 'bills',
    name: 'Төлемдер',
    icon: Icons.receipt_long,
    color: AppColors.bills,
    monthlyBudget: 80000,
  );
  static const Category salary = Category(
    id: 'salary',
    name: 'Жалақы',
    icon: Icons.account_balance_wallet,
    color: AppColors.salary,
    monthlyBudget: 1000000,
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
    bankName: 'Алтын Банк',
    network: 'Visa',
    lastFour: '4821',
    balance: 1250400,
    gradient: AppColors.cardGradientTeal,
  );
  static const PaymentCard creditCard = PaymentCard(
    id: 'card-2',
    bankName: 'Дала Кредит',
    network: 'Mastercard',
    lastFour: '7730',
    balance: 480000,
    gradient: AppColors.cardGradientIndigo,
  );
  static const PaymentCard savingsCard = PaymentCard(
    id: 'card-3',
    bankName: 'Шың Жинақ',
    network: 'Visa',
    lastFour: '1005',
    balance: 815750,
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
      title: 'Береке маркеті',
      amount: 18400,
      type: TransactionType.expense,
      category: food,
      card: everydayCard,
      date: DateTime(2026, 10, 9),
      status: TransactionStatus.pending,
      note: 'Демалыс күнгі азық-түлік пен тіскебасар.',
    ),
    Transaction(
      id: 't2',
      title: 'Қала таксиі',
      amount: 2300,
      type: TransactionType.expense,
      category: transport,
      card: creditCard,
      date: DateTime(2026, 10, 8),
      status: TransactionStatus.completed,
      note: 'Клиент кеңсесіне дейінгі жол.',
      labels: const [_business],
    ),
    Transaction(
      id: 't3',
      title: 'Фриланс жоба',
      amount: 120000,
      type: TransactionType.income,
      category: salary,
      card: savingsCard,
      date: DateTime(2026, 10, 7),
      status: TransactionStatus.completed,
      note: 'Жергілікті студияға арналған лендинг дизайны.',
      labels: const [_business],
    ),
    Transaction(
      id: 't4',
      title: 'Көк шәйнек кофеханасы',
      amount: 2500,
      type: TransactionType.expense,
      category: food,
      card: everydayCard,
      date: DateTime(2026, 10, 7),
      status: TransactionStatus.completed,
      note: 'Флэт уайт пен круассан.',
    ),
    Transaction(
      id: 't5',
      title: 'Спорт әлемі',
      amount: 42990,
      type: TransactionType.expense,
      category: shopping,
      card: creditCard,
      date: DateTime(2026, 10, 6),
      status: TransactionStatus.completed,
      note: 'Жүгіруге арналған аяқ киім.',
    ),
    Transaction(
      id: 't6',
      title: 'Электр энергиясы',
      amount: 12300,
      type: TransactionType.expense,
      category: bills,
      card: everydayCard,
      date: DateTime(2026, 10, 5),
      status: TransactionStatus.completed,
      note: 'Қыркүйек айының төлемі, автотөлеммен төленді.',
      labels: const [_recurring],
    ),
    Transaction(
      id: 't7',
      title: 'Суши Дзен',
      amount: 14600,
      type: TransactionType.expense,
      category: food,
      card: creditCard,
      date: DateTime(2026, 10, 4),
      status: TransactionStatus.completed,
      note: 'Өнім командасымен кешкі ас.',
      labels: const [_business],
    ),
    Transaction(
      id: 't8',
      title: 'Метро айлық билеті',
      amount: 9000,
      type: TransactionType.expense,
      category: transport,
      card: everydayCard,
      date: DateTime(2026, 10, 3),
      status: TransactionStatus.completed,
      note: 'Қазан айына шексіз жол жүру.',
      labels: const [_recurring],
    ),
    Transaction(
      id: 't9',
      title: 'Онлайн кино жазылымы',
      amount: 3490,
      type: TransactionType.expense,
      category: bills,
      card: creditCard,
      date: DateTime(2026, 10, 2),
      status: TransactionStatus.completed,
      note: 'Стандартты тариф.',
      labels: const [_recurring],
    ),
    Transaction(
      id: 't10',
      title: 'Интернет-дүкен тапсырысы',
      amount: 15600,
      type: TransactionType.expense,
      category: shopping,
      card: everydayCard,
      date: DateTime(2026, 10, 2),
      status: TransactionStatus.completed,
      note: 'Үстел шамы мен сым реттегіштер.',
    ),
    Transaction(
      id: 't11',
      title: 'Айлық жалақы',
      amount: 650000,
      type: TransactionType.income,
      category: salary,
      card: everydayCard,
      date: DateTime(2026, 10, 1),
      status: TransactionStatus.completed,
      note: 'Қазан айының жалақысы.',
      labels: const [_recurring],
    ),
    Transaction(
      id: 't12',
      title: 'Апталық азық-түлік',
      amount: 60500,
      type: TransactionType.expense,
      category: food,
      card: everydayCard,
      date: DateTime(2026, 10, 1),
      status: TransactionStatus.completed,
      note: 'Бір айға азық-түлік қоры.',
      labels: const [_recurring],
    ),
  ]);
}
