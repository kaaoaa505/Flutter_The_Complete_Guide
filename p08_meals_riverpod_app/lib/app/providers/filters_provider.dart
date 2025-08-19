import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/enums/filters_enum.dart';
import 'package:p07_meals_app/app/global/k_initial_filters.dart';

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
