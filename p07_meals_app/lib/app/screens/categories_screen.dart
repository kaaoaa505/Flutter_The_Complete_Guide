import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/data/available_categories_data.dart';
import 'package:p07_meals_app/app/ui/category_grid_item_ui.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick a category:')),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final categoryData in availableCategoriesData)
            CategoryGridItemUi(categoryModel: categoryData),
        ],
      ),
    );
  }
}
