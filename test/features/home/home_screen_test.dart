import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket/app.dart';
import 'package:pocket/data/mock/mock_data.dart';
import 'package:pocket/features/home/widgets/empty_state.dart';
import 'package:pocket/features/home/widgets/type_toggle.dart';
import 'package:pocket/features/transaction_detail/transaction_detail_screen.dart';
import 'package:pocket/features/transaction_detail/widgets/detail_banner.dart';

void main() {
  final expense = MockData.transactions.firstWhere((t) => !t.isIncome);
  final income = MockData.transactions.firstWhere((t) => t.isIncome);

  Finder segment(String label) =>
      find.descendant(of: find.byType(TypeToggle), matching: find.text(label));

  Finder iconInTile(String id, IconData icon) => find.descendant(
    of: find.byKey(ValueKey(id)),
    matching: find.byIcon(icon),
  );

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('shows every mock transaction without layout errors', (
    tester,
  ) async {
    await tester.pumpWidget(const PocketApp());

    for (final transaction in MockData.transactions) {
      expect(find.text(transaction.title), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders without overflow at 360 and 1024 wide', (tester) async {
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1;

    for (final size in const [Size(360, 800), Size(1024, 768)]) {
      tester.view.physicalSize = size;
      await tester.pumpWidget(const PocketApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('Expenses hides income and All restores it', (tester) async {
    await tester.pumpWidget(const PocketApp());

    await tapVisible(tester, segment(TransactionFilter.expenses.label));
    expect(find.text(income.title), findsNothing);
    expect(find.text(expense.title), findsOneWidget);

    await tapVisible(tester, segment(TransactionFilter.all.label));
    expect(find.text(income.title), findsOneWidget);
  });

  testWidgets('Income hides expenses', (tester) async {
    await tester.pumpWidget(const PocketApp());

    await tapVisible(tester, segment(TransactionFilter.income.label));

    expect(find.text(expense.title), findsNothing);
    expect(find.text(income.title), findsOneWidget);
  });

  testWidgets('tapping a star switches it from outline to filled', (
    tester,
  ) async {
    await tester.pumpWidget(const PocketApp());
    expect(iconInTile(expense.id, Icons.star), findsNothing);

    await tapVisible(tester, iconInTile(expense.id, Icons.star_border));

    expect(iconInTile(expense.id, Icons.star), findsOneWidget);
    expect(iconInTile(expense.id, Icons.star_border), findsNothing);
  });

  testWidgets('tapping a tile opens its detail screen', (tester) async {
    await tester.pumpWidget(const PocketApp());

    await tapVisible(tester, find.text(expense.title));

    expect(find.byType(TransactionDetailScreen), findsOneWidget);
    expect(find.text(expense.title), findsOneWidget);
  });

  testWidgets('favoriting on detail shows a filled star back on home', (
    tester,
  ) async {
    await tester.pumpWidget(const PocketApp());
    await tapVisible(tester, find.text(expense.title));

    await tester.tap(
      find.descendant(
        of: find.byType(DetailBanner),
        matching: find.byIcon(Icons.star_border),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(DetailBanner),
        matching: find.byIcon(Icons.star),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Артқа'));
    await tester.pumpAndSettle();

    expect(find.byType(TransactionDetailScreen), findsNothing);
    expect(iconInTile(expense.id, Icons.star), findsOneWidget);
  });

  testWidgets('a favorite set on home is already filled on detail', (
    tester,
  ) async {
    await tester.pumpWidget(const PocketApp());
    await tapVisible(tester, iconInTile(expense.id, Icons.star_border));

    await tapVisible(tester, find.text(expense.title));

    expect(
      find.descendant(
        of: find.byType(DetailBanner),
        matching: find.byIcon(Icons.star),
      ),
      findsOneWidget,
    );
  });

  testWidgets('favorites-only chip shows the empty state, then favorites', (
    tester,
  ) async {
    await tester.pumpWidget(const PocketApp());

    await tapVisible(tester, find.text('Таңдаулылар'));
    expect(find.byType(EmptyState), findsOneWidget);

    await tapVisible(tester, find.text('Таңдаулылар'));
    await tapVisible(tester, iconInTile(expense.id, Icons.star_border));
    await tapVisible(tester, find.text('Таңдаулылар'));

    expect(find.byType(EmptyState), findsNothing);
    expect(find.text(expense.title), findsOneWidget);
    expect(find.text(income.title), findsNothing);
  });
}
