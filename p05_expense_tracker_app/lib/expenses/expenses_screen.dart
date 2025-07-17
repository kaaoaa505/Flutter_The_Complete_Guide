import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/ui/expenses_list_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<ExpenseModel> expenses = [
    ExpenseModel(
      title: 'ChatGPT',
      amount: 20.99,
      createdAt: DateTime.now(),
      categoryEnum: CategoryEnum.work,
    ),
    ExpenseModel(
      title: 'Cinema',
      amount: 12.34,
      createdAt: DateTime.now(),
      categoryEnum: CategoryEnum.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.blueGrey),
      body: Column(
        children: [
          Text('The CHART'),
          Text('Expenses List...'),
          Expanded(child: ExpensesListUi(expenses: expenses)),
        ],
      ),
    );
  }
}
