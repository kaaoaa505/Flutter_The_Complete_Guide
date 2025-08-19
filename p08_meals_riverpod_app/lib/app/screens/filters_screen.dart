import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/enums/filters_enum.dart';
import 'package:p07_meals_app/app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key, required this.selectScreen});
  final void Function(String identifier) selectScreen;
  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _isSetGlutenFreeFilter = false;
  bool _isSetLactoseFreeFilter = false;
  bool _isSetVegetarianFreeFilter = false;
  bool _isSetVeganFreeFilter = false;

  @override
  void initState() {
    super.initState();

    final currentFilters = ref.read(filtersProvider);

    _isSetGlutenFreeFilter = currentFilters[FiltersEnum.glutenFree]!;
    _isSetLactoseFreeFilter = currentFilters[FiltersEnum.lactoseFree]!;
    _isSetVegetarianFreeFilter = currentFilters[FiltersEnum.vegetarian]!;
    _isSetVeganFreeFilter = currentFilters[FiltersEnum.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            ref.read(filtersProvider.notifier).setAllFilters({
              FiltersEnum.glutenFree: _isSetGlutenFreeFilter,
              FiltersEnum.lactoseFree: _isSetLactoseFreeFilter,
              FiltersEnum.vegetarian: _isSetVegetarianFreeFilter,
              FiltersEnum.vegan: _isSetVeganFreeFilter,
            });
            
            Navigator.of(context).pop();
          }
        },
        child: ListView(
          children: [
            _buildSwitchTile(
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              value: _isSetGlutenFreeFilter,
              onChanged: (val) => setState(() => _isSetGlutenFreeFilter = val),
            ),
            _buildSwitchTile(
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              value: _isSetLactoseFreeFilter,
              onChanged: (val) => setState(() => _isSetLactoseFreeFilter = val),
            ),
            _buildSwitchTile(
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              value: _isSetVegetarianFreeFilter,
              onChanged: (val) =>
                  setState(() => _isSetVegetarianFreeFilter = val),
            ),
            _buildSwitchTile(
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              value: _isSetVeganFreeFilter,
              onChanged: (val) => setState(() => _isSetVeganFreeFilter = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34),
    );
  }
}
