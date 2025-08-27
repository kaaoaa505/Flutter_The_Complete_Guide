import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:p11_favorite_places_app/models/place_model.dart';

/// Provider to manage user-added places with local DB + state persistence
class UserPlacesProvider extends StateNotifier<List<PlaceModel>> {
  UserPlacesProvider() : super([]);

  static const _dbName = 'places.db';
  static const _tableName = 'user_places';

  Future<sqflite.Database> _getDatabase() async {
    final databasesPath = await sqflite.getDatabasesPath();
    final dbPath = path.join(databasesPath, _dbName);

    return sqflite.openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT,
            lat REAL,
            lng REAL,
            address TEXT
          )
        ''');
      },
    );
  }

  Future<void> addPlace(PlaceModel place) async {
    try {
      // Copy image to app documents directory
      final appDir = await path_provider.getApplicationDocumentsDirectory();
      final filename = path.basename(place.image.path);
      final copiedImage = await place.image.copy('${appDir.path}/$filename');

      // Create new place instance with copied image
      final newPlace = PlaceModel(
        title: place.title,
        image: copiedImage,
        locationModel: place.locationModel,
      );

      // Save into DB
      final db = await _getDatabase();
      await db.insert(_tableName, newPlace.toMap(),
          conflictAlgorithm: sqflite.ConflictAlgorithm.replace);

      // Update state
      state = [...state, newPlace];
    } catch (e) {
      // Optional: Log error or rethrow
      print('❌ Failed to add place: $e');
    }
  }

  Future<void> loadPlaces() async {
    try {
      final db = await _getDatabase();
      final placesData = await db.query(_tableName);

      state = placesData
          .map((row) => PlaceModel.fromMap(row))
          .toList();
    } catch (e) {
      print('❌ Failed to load places: $e');
    }
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesProvider, List<PlaceModel>>(
  (ref) => UserPlacesProvider(),
);
