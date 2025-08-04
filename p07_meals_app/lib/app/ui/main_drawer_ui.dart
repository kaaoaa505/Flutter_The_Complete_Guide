import 'package:flutter/material.dart';

class MainDrawerUi extends StatelessWidget {
  const MainDrawerUi({super.key, required this.selectScreen});

  final void Function(String identifier) selectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
                SizedBox(width: 18),
                Text(
                  'Cooking up!.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              selectScreen('meals');
            },
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
            title: Text('Meals', style: Theme.of(context).textTheme.titleSmall),
          ),
          ListTile(
            onTap: () {
              selectScreen('filters');
            },
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
