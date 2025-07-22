import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/ui/expense_item_ui.dart';
import 'package:flutter/material.dart';

class ExpensesListUi extends StatelessWidget {

  const ExpensesListUi({
    super.key,
    required this.expenses,
    required this.removeExpense,
  });

  final List<ExpenseModel> expenses;
  
  final void Function(ExpenseModel expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        child: ExpenseItemUi(expense: expenses[index]),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
      ),
      itemCount: expenses.length,
    );
  }
}
