import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/models/category_model.dart';

class CategoryGridItemUi extends StatelessWidget {
  const CategoryGridItemUi({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    var colors = [
      categoryModel.color.withAlpha(150),
      categoryModel.color.withAlpha(200),
    ];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Text(
        categoryModel.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
