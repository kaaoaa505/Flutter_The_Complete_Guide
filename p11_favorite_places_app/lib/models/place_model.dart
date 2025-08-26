import 'dart:io';

import 'package:p11_favorite_places_app/models/location_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  PlaceModel({
    required this.title,
    required this.image,
    required this.locationModel,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final LocationModel locationModel;
}
