import 'package:flutter/cupertino.dart';
import '../../models/expense.dart';

import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
      required this.expenses,
        super.key,
        required this.onRemoveExpense
      }
  );

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]
              );
            },

            child: ExpenseItem(expenses[index]) ),
    );
  }
}