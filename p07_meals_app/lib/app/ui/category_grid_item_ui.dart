import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/models/category_model.dart';

class CategoryGridItemUi extends StatelessWidget {
  const CategoryGridItemUi({
    super.key,
    required this.categoryModel,
    required this.selectCategory,
  });

  final CategoryModel categoryModel;
  final void Function(CategoryModel categoryModel) selectCategory;

  @override
  Widget build(BuildContext context) {
    var colors = [
      categoryModel.color.withAlpha(150),
      categoryModel.color.withAlpha(200),
    ];

    return InkWell(
      onTap: () {
        selectCategory(categoryModel);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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
      ),
    );
  }
}
