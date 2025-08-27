import 'dart:io';
import 'package:p11_favorite_places_app/models/location_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  PlaceModel({
    required this.title,
    required this.image,
    required this.locationModel,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final LocationModel locationModel;

  /// Convert object into Map for DB storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image.path, // store file path only
      'lat': locationModel.latitude,
      'lng': locationModel.longitude,
      'address': locationModel.address,
    };
  }

  /// Convert DB Map back into PlaceModel
  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'],
      title: map['title'],
      image: File(map['image']), // rebuild File from stored path
      locationModel: LocationModel(
        latitude: map['lat'],
        longitude: map['lng'],
        address: map['address'],
      ),
    );
  }
}
