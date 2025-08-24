import 'package:flutter/material.dart';
import 'package:p11_favorite_places_app/models/place_model.dart';

class PlacesListUI extends StatelessWidget {
  const PlacesListUI({super.key, required this.places});

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Text(
              'No Places Found.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Try adding some places first.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
