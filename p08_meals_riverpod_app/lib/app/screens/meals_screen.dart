import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/models/meal_model.dart';
import 'package:p07_meals_app/app/ui/meal_item_ui.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.toggleMealFavorite,
  });

  final String title;
  final List<MealModel> meals;
  final void Function(MealModel meal) toggleMealFavorite;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (meals.isEmpty) {
      bodyContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No meals found.',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Try another category!.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    } else {
      bodyContent = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItemUi(mealModel: meals[index], toggleMealFavorite: toggleMealFavorite),
      );
    }

    if (title.isEmpty) return bodyContent;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: bodyContent,
    );
  }
}
