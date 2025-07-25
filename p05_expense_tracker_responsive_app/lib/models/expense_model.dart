import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.createdAt,
    required this.categoryEnum,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime createdAt;
  final CategoryEnum categoryEnum;

  String get createdAtFormatted {
    return formatter.format(createdAt);
  }
}
