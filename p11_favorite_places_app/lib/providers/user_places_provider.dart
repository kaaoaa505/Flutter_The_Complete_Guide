import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p11_favorite_places_app/models/place_model.dart';

class UserPlacesProvider extends StateNotifier<List<PlaceModel>> {
  UserPlacesProvider() : super([]);

  void addPlace(PlaceModel place) {
    state = [...state, place];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesProvider, List<PlaceModel>>(
  (ref) => UserPlacesProvider(),
);