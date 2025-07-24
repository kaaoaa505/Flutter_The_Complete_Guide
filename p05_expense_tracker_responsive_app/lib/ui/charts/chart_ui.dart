import 'package:expense_tracker_app/enums/category_enum.dart';
import 'package:expense_tracker_app/models/expense_bucket_model.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/ui/charts/chart_bar_ui.dart';
import 'package:flutter/material.dart';

class ChartUi extends StatelessWidget {
  const ChartUi({super.key, required this.expenses});

  final List<ExpenseModel> expenses;

  List<ExpenseBucketModel> get buckets {
    return [
      ExpenseBucketModel.forCategory(expenses, CategoryEnum.food),
      ExpenseBucketModel.forCategory(expenses, CategoryEnum.leisure),
      ExpenseBucketModel.forCategory(expenses, CategoryEnum.travel),
      ExpenseBucketModel.forCategory(expenses, CategoryEnum.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withAlpha(60),
            Theme.of(context).colorScheme.primary.withAlpha(0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBarUi(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.categoryEnum],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(150),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}