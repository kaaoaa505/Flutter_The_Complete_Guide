import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/models/meal_model.dart';

class FavoritesProviderStateNotifier extends StateNotifier<List<MealModel>> {
  FavoritesProviderStateNotifier() : super([]);

  bool toggleMealFavorite(MealModel meal) {
    if (state.contains(meal)) {
      // remove it
      state = state.where((oneMeal) => oneMeal.id != meal.id).toList();
      return false;
    } else {
      // add it
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesProviderStateNotifier, List<MealModel>>((
      ref,
    ) {
      return FavoritesProviderStateNotifier();
    });
