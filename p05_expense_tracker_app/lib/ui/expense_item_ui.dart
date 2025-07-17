import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItemUi extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseItemUi({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(height: 10),
            Text(expense.id),
            SizedBox(height: 10),
            Text(expense.categoryEnum.name),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${expense.amount.toStringAsFixed(1)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.categoryEnum]),
                    SizedBox(width: 5),
                    Text(expense.createdAtFormatted),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
