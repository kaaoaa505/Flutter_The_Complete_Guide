import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/enums/filters_enum.dart';
import 'package:p07_meals_app/app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key, required this.selectScreen});
  final void Function(String identifier) selectScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilters = ref.watch(filtersProvider);
    final notifier = ref.read(filtersProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: ListView(
        children: [
          _buildSwitchTile(
            context: context,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            value: selectedFilters[FiltersEnum.glutenFree] ?? false,
            onChanged: (val) => notifier.setFilter(FiltersEnum.glutenFree, val),
          ),
          _buildSwitchTile(
            context: context,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            value: selectedFilters[FiltersEnum.lactoseFree] ?? false,
            onChanged: (val) => notifier.setFilter(FiltersEnum.lactoseFree, val),
          ),
          _buildSwitchTile(
            context: context,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            value: selectedFilters[FiltersEnum.vegetarian] ?? false,
            onChanged: (val) => notifier.setFilter(FiltersEnum.vegetarian, val),
          ),
          _buildSwitchTile(
            context: context,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            value: selectedFilters[FiltersEnum.vegan] ?? false,
            onChanged: (val) => notifier.setFilter(FiltersEnum.vegan, val),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34),
    );
  }
}
