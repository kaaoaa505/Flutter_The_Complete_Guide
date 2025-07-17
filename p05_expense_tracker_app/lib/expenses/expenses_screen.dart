import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.inactiveGray,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.blueGrey),
      body: Column(children: [Text('The CHART'), Text('Expenses List...')]),
    );
  }
}
