import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/data/available_categories_data.dart';
import 'package:p07_meals_app/app/models/category_model.dart';
import 'package:p07_meals_app/app/models/meal_model.dart';
import 'package:p07_meals_app/app/screens/meals_screen.dart';
import 'package:p07_meals_app/app/ui/category_grid_item_ui.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<MealModel> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void selectCategory(CategoryModel categoryModel) {
      List<MealModel> meals = widget.availableMeals
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
          builder: (ctx) =>
              MealsScreen(title: categoryModel.title, meals: meals),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (ctx, child) {
        return Padding(
          padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
          child: child,
        );
      },
    );
  }
}
