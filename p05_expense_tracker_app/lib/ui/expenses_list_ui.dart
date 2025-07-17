import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/ui/expense_item_ui.dart';
import 'package:flutter/material.dart';

class ExpensesListUi extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ExpensesListUi({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => ExpenseItemUi(expense: expenses[index]),
      itemCount: expenses.length,
    );
  }
}
