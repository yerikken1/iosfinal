import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket/core/theme/app_theme.dart';
import 'package:pocket/core/utils/formatters.dart';
import 'package:pocket/data/mock/mock_data.dart';
import 'package:pocket/data/models/transaction.dart';
import 'package:pocket/features/transaction_detail/transaction_detail_screen.dart';
import 'package:pocket/features/transaction_detail/widgets/budget_progress_card.dart';
import 'package:pocket/features/transaction_detail/widgets/detail_info_card.dart';

void main() {
  const phone = Size(360, 800);
  const tablet = Size(1024, 768);

  // The transaction with the most tags is the hardest case for wrapping.
  final transaction = MockData.transactions.reduce(
    (a, b) => b.tags.length > a.tags.length ? b : a,
  );

  Future<void> pumpDetail(
    WidgetTester tester, {
    required Size size,
    Transaction? shown,
    bool isFavorite = false,
    VoidCallback? onToggleFavorite,
  }) async {
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: TransactionDetailScreen(
          transaction: shown ?? transaction,
          isFavorite: isFavorite,
          categoryTotal: 96000,
          onToggleFavorite: onToggleFavorite ?? () {},
        ),
      ),
    );
  }

  testWidgets('shows title, tags and budget', (tester) async {
    await pumpDetail(tester, size: phone, shown: MockData.transactions.first);

    expect(find.text(MockData.transactions.first.title), findsOneWidget);
    for (final tag in MockData.transactions.first.tags) {
      expect(find.widgetWithText(Chip, tag), findsOneWidget);
    }
    expect(find.text('Тамақ бюджеті'), findsOneWidget);
    expect(
      find.text('${formatMoney(96000)} / ${formatMoney(150000)}'),
      findsOneWidget,
    );
  });

  testWidgets('renders every transaction without overflow at 360x800', (
    tester,
  ) async {
    for (final shown in MockData.transactions) {
      await pumpDetail(tester, size: phone, shown: shown);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('stacks the cards in one column on a phone', (tester) async {
    await pumpDetail(tester, size: phone);

    final info = tester.getRect(find.byType(DetailInfoCard));
    final budget = tester.getRect(find.byType(BudgetProgressCard));

    expect(tester.takeException(), isNull);
    expect(budget.top, greaterThanOrEqualTo(info.bottom));
    expect(budget.left, info.left);
  });

  testWidgets('puts the cards side by side at 1024x768', (tester) async {
    await pumpDetail(tester, size: tablet);

    final info = tester.getRect(find.byType(DetailInfoCard));
    final budget = tester.getRect(find.byType(BudgetProgressCard));

    expect(tester.takeException(), isNull);
    expect(budget.top, info.top);
    expect(budget.left, greaterThanOrEqualTo(info.right));
  });

  testWidgets('star reflects the initial favorite state', (tester) async {
    await pumpDetail(tester, size: phone, isFavorite: true);

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsNothing);
  });

  testWidgets('tapping the star fills it and notifies the owner', (
    tester,
  ) async {
    var toggles = 0;
    await pumpDetail(tester, size: phone, onToggleFavorite: () => toggles++);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pump();

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(toggles, 1);
  });
}
