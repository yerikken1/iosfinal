import 'package:flutter/material.dart';

import '../../../data/models/transaction.dart';

/// Which transactions the home list shows.
enum TransactionFilter {
  all('Барлығы'),
  expenses('Шығыстар'),
  income('Кірістер');

  const TransactionFilter(this.label);

  final String label;

  bool matches(Transaction transaction) {
    return switch (this) {
      TransactionFilter.all => true,
      TransactionFilter.expenses => !transaction.isIncome,
      TransactionFilter.income => transaction.isIncome,
    };
  }
}

/// Shows the all / expenses / income segmented control.
class TypeToggle extends StatelessWidget {
  const TypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TransactionFilter selected;
  final ValueChanged<TransactionFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TransactionFilter>(
      showSelectedIcon: false,
      segments: [
        for (final filter in TransactionFilter.values)
          ButtonSegment(value: filter, label: Text(filter.label)),
      ],
      selected: {selected},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
