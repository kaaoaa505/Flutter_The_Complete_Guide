import 'package:flutter/material.dart';
import 'package:p11_favorite_places_app/models/place_model.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final PlaceModel place;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: Text(place.title,
              style: Theme.of(context).textTheme.bodyLarge,),
      ),
    );
  }
}
