import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/enums/filters_enum.dart';
import 'package:p07_meals_app/app/global/k_initial_filters.dart';
import 'package:p07_meals_app/app/models/meal_model.dart';
import 'package:p07_meals_app/app/providers/favorites_provider.dart';
import 'package:p07_meals_app/app/providers/meals_provider.dart';
import 'package:p07_meals_app/app/screens/categories_screen.dart';
import 'package:p07_meals_app/app/screens/filters_screen.dart';
import 'package:p07_meals_app/app/screens/meals_screen.dart';
import 'package:p07_meals_app/app/ui/main_drawer_ui.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<MealModel> favorites = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<FiltersEnum, bool> _selectedFilters = kInitialFilters;

  Future<void> selectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FiltersEnum, bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return FiltersScreen(
              selectScreen: selectScreen,
              currentFilters: _selectedFilters,
            );
          },
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }

    if (identifier == 'meals') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return TabsScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(mealsProvider).where((meal) {
      if (_selectedFilters[FiltersEnum.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[FiltersEnum.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[FiltersEnum.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[FiltersEnum.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    var activePageTitle = 'Categories';
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(
        title: '',
        meals: ref.watch(favoritesProvider),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawerUi(selectScreen: selectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
