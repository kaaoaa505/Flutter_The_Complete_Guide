import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItemUi extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseItemUi({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(expense.id),
          Text(expense.title),
          Text('${expense.amount}\$'),
          Text(expense.createdAt.toString()),
          Text(expense.categoryEnum.name),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
