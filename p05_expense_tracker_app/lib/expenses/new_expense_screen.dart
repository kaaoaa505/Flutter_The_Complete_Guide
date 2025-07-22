import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key, required this.addExpense});

  final void Function(ExpenseModel expense) addExpense;

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _dateValue;

  CategoryEnum _categoryValue = CategoryEnum.leisure;

  void _datePicker() async {
    final now = DateTime.now();

    var value = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    setState(() {
      _dateValue = value;
    });
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      widget.addExpense(expense);
    });

    Navigator.pop(context);
  }

  void _submitExpenseData() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid title.'),
          content: Text('Please make sure a valid title was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );

      return;
    }

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid amount.'),
          content: Text('Please make sure a valid amount was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );

      return;
    }

    final amount = double.tryParse(amountText);

    if (_dateValue == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid date.'),
          content: Text('Please make sure a valid date was selected.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );

      return;
    }

    final date = _dateValue;

    final ExpenseModel expense = ExpenseModel(
      title: title,
      amount: amount!,
      createdAt: date!,
      categoryEnum: _categoryValue,
    );
    _addExpense(expense);
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15,50,15,15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefix: Text('\$'),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _dateValue != null
                          ? formatter.format(_dateValue!)
                          : 'No date selected!.',
                    ),
                    IconButton(
                      onPressed: _datePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              DropdownButton(
                value: _categoryValue,
                items: CategoryEnum.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _categoryValue = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
