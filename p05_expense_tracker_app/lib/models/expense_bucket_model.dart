import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/models/expense_model.dart';

class ExpenseBucketModel {
  // Main constructor
  ExpenseBucketModel({required this.categoryEnum, required this.expensesList});

  // Constructor that filters expenses by category
  ExpenseBucketModel.forCategory(
    List<ExpenseModel> expenses,
    this.categoryEnum, // Changed to categoryEnum parameter
  ) : expensesList = expenses
        .where((expense) => expense.categoryEnum == categoryEnum) // Filter expenses by categoryEnum
        .toList();

  // The category the expenses belong to
  CategoryEnum categoryEnum;

  // List of expenses filtered by the category
  List<ExpenseModel> expensesList;

  // Calculate total expenses for the given category
  double get totalExpenses {
    double sum = 0;

    for (var expense in expensesList) {
      sum += expense.amount;
    }

    return sum;
  }
}
