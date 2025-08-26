import 'package:flutter/material.dart';
import 'package:p11_favorite_places_app/config/env.dart';
import 'package:p11_favorite_places_app/models/place_model.dart';
import 'package:p11_favorite_places_app/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({super.key, required this.place});

  final PlaceModel place;

  final String googleMapsKey = Env.googleMapsApiKey;

  String get locationImage {
    final lat = place.locationModel.latitude;
    final lng = place.locationModel.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&markers=color:blue|label:A|$lat,$lng&key=$googleMapsKey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          // Background image
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Overlay content
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builderCtx) => MapScreen(
                              locationModel: place.locationModel,
                              isSelecting: false,
                            )));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                  child: Text(
                    place.locationModel.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
