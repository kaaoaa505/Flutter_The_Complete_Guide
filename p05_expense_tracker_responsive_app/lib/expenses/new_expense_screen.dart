import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final DateFormat _formatter = DateFormat.yMd();

  void _datePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        _dateValue = pickedDate;
      });
    }
  }

  void _addExpense(ExpenseModel expense) {
    widget.addExpense(expense);
    Navigator.pop(context);
  }

  void _submitExpenseData() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      _showErrorDialog('Invalid title', 'Please make sure a valid title was entered.');
      return;
    }

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      _showErrorDialog('Invalid amount', 'Please make sure a valid amount was entered.');
      return;
    }

    final amount = double.tryParse(amountText)!;
    if (_dateValue == null) {
      _showErrorDialog('Invalid date', 'Please make sure a valid date was selected.');
      return;
    }

    final expense = ExpenseModel(
      title: title,
      amount: amount,
      createdAt: _dateValue!,
      categoryEnum: _categoryValue,
    );
    _addExpense(expense);
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15 + keyboardSpace),
              child: Column(
                children: [
                  if (constraints.maxWidth >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(label: Text('Title')),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              label: Text('Amount'),
                              prefix: Text('\$'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text('Title')),
                    ),
                  const SizedBox(height: 16),
                  if (constraints.maxWidth >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<CategoryEnum>(
                            value: _categoryValue,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                            ),
                            items: CategoryEnum.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
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
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  _dateValue != null
                                      ? _formatter.format(_dateValue!)
                                      : 'No date selected',
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              IconButton(
                                onPressed: _datePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              label: Text('Amount'),
                              prefix: Text('\$'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  _dateValue != null
                                      ? _formatter.format(_dateValue!)
                                      : 'No date selected',
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              IconButton(
                                onPressed: _datePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (constraints.maxWidth >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<CategoryEnum>(
                            value: _categoryValue,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                            ),
                            items: CategoryEnum.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
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
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}