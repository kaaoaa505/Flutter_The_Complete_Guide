import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/expenses/new_expense_screen.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/ui/charts/chart_ui.dart';
import 'package:expense_tracker_app/ui/expenses_list_ui.dart';
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
      title: 'Test',
      amount: 12.34,
      createdAt: DateTime.now(),
      categoryEnum: CategoryEnum.leisure,
    ),
  ];

  void addExpense(ExpenseModel expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    final expenseIndex = expenses.indexOf(expense);

    setState(() {
      expenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense [${expense.title}] removed successfully.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void addExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseScreen(addExpense: addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget expensesList = ExpensesListUi(
      expenses: expenses,
      removeExpense: removeExpense,
    );

    Widget noExpensesFound = Center(child: Text('No expenses found.'));

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: addExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                ChartUi(expenses: expenses),
                Expanded(
                  child: expenses.isNotEmpty ? expensesList : noExpensesFound,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: ChartUi(expenses: expenses)),
                Expanded(
                  child: expenses.isNotEmpty ? expensesList : noExpensesFound,
                ),
              ],
            ),
    );
  }
}
