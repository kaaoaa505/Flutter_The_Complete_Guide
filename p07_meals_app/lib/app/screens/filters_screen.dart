import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/enums/filters_enum.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.selectScreen,
    required this.currentFilters,
  });
  final void Function(String identifier) selectScreen;
  final Map<FiltersEnum, bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isSetGlutenFreeFilter = false;
  var _isSetLactoseFreeFilter = false;
  var _isSetVegetarianFreeFilter = false;
  var _isSetVeganFreeFilter = false;

  @override
  void initState() {
    super.initState();

    _isSetGlutenFreeFilter = widget.currentFilters[FiltersEnum.glutenFree]!;
    _isSetLactoseFreeFilter = widget.currentFilters[FiltersEnum.lactoseFree]!;
    _isSetVegetarianFreeFilter = widget.currentFilters[FiltersEnum.vegetarian]!;
    _isSetVeganFreeFilter = widget.currentFilters[FiltersEnum.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            Navigator.of(context).pop({
              FiltersEnum.glutenFree: _isSetGlutenFreeFilter,
              FiltersEnum.lactoseFree: _isSetLactoseFreeFilter,
              FiltersEnum.vegetarian: _isSetVegetarianFreeFilter,
              FiltersEnum.vegan: _isSetVeganFreeFilter,
            });
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
