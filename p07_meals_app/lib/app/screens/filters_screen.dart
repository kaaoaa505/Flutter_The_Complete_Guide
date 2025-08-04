import 'package:flutter/material.dart';
import 'package:p07_meals_app/app/ui/main_drawer_ui.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.selectScreen});
  final void Function(String identifier) selectScreen;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isSetGlutenFreeFilter = false;
  var _isSetLactoseFreeFilter = false;
  var _isSetVegetarianFreeFilter = false;
  var _isSetVeganFreeFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Filters')),
      drawer: MainDrawerUi(selectScreen: widget.selectScreen),
      body: Column(
        children: [
          SwitchListTile(
            value: _isSetGlutenFreeFilter,
            onChanged: (isChecked) {
              setState(() {
                _isSetGlutenFreeFilter = isChecked;
              });
            },
            title: Text('Gluten-free'),
            subtitle: Text('Only include gluten-free meals.'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34),
          ),
          SwitchListTile(
            value: _isSetLactoseFreeFilter,
            onChanged: (isChecked) {
              setState(() {
                _isSetLactoseFreeFilter = isChecked;
              });
            },
            title: Text('Lactose-free'),
            subtitle: Text('Only include lactose-free meals.'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34),
          ),
          // Added Vegetarian Filter
          SwitchListTile(
            value: _isSetVegetarianFreeFilter,
            onChanged: (isChecked) {
              setState(() {
                _isSetVegetarianFreeFilter = isChecked;
              });
            },
            title: Text('Vegetarian'),
            subtitle: Text('Only include vegetarian meals.'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34),
          ),
          // Added Vegan Filter
          SwitchListTile(
            value: _isSetVeganFreeFilter,
            onChanged: (isChecked) {
              setState(() {
                _isSetVeganFreeFilter = isChecked;
              });
            },
            title: Text('Vegan'),
            subtitle: Text('Only include vegan meals.'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34),
          ),
        ],
      ),
    );
  }
}
