import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/data/available_categories_data.dart';
import 'package:p07_meals_app/app/models/category_model.dart';
import 'package:p07_meals_app/app/models/meal_model.dart';
import 'package:p07_meals_app/app/screens/meals_screen.dart';
import 'package:p07_meals_app/app/ui/category_grid_item_ui.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<MealModel> availableMeals;

  @override
  Widget build(BuildContext context) {
    void selectCategory(CategoryModel categoryModel) {
      List<MealModel> meals = availableMeals
          .where(
            (meal) =>
                meal.categories.indexWhere(
                  (categoryId) => categoryId == categoryModel.id,
                ) >
                0,
          )
          .toList();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealsScreen(
            title: categoryModel.title,
            meals: meals,
          ),
        ),
      );
    }

    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final categoryData in availableCategoriesData)
          CategoryGridItemUi(
            categoryModel: categoryData,
            selectCategory: selectCategory,
          ),
      ],
    );
  }
}
