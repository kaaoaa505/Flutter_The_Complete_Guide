import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/enums/filters_enum.dart';
import 'package:p07_meals_app/app/global/k_initial_filters.dart';
import 'package:p07_meals_app/app/providers/meals_provider.dart';

class FiltersStateNotifierProvider
    extends StateNotifier<Map<FiltersEnum, bool>> {
  FiltersStateNotifierProvider() : super(kInitialFilters);

  void setFilter(FiltersEnum filter, bool value) {
    state = {...state, filter: value};
  }

  void setAllFilters(Map<FiltersEnum, bool> filters) {
    state = {...filters};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersStateNotifierProvider, Map<FiltersEnum, bool>>(
      (ref) => FiltersStateNotifierProvider(),
    );

final filteredMealsProvider = Provider((ref) {
  final selectedFilters = ref.watch(filtersProvider);
  final availableMeals = ref.watch(mealsProvider);

  return availableMeals.where((meal) {
    if (selectedFilters[FiltersEnum.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (selectedFilters[FiltersEnum.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (selectedFilters[FiltersEnum.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (selectedFilters[FiltersEnum.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
