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
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
      final meals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryModel.id))
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

    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        return SlideTransition(
          position: _slideAnimation,
          child: child,
        );
      },
    );
  }
}
