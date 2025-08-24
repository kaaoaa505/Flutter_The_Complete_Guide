import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p11_favorite_places_app/providers/user_places_provider.dart';
import 'package:p11_favorite_places_app/screens/add_place_screen.dart';
import 'package:p11_favorite_places_app/ui/places_list_ui.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(userPlacesProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AddPlaceScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: PlacesListUI(places: places));
  }
}
