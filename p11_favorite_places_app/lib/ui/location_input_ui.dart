import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:p11_favorite_places_app/models/location_model.dart';

class LocationInputUI extends StatefulWidget {
  const LocationInputUI({super.key});

  @override
  State<LocationInputUI> createState() => _LocationInputUIState();
}

class _LocationInputUIState extends State<LocationInputUI> {
  late final String googleMapsKey;
  LocationModel? _pickedLocation;
  bool isGettingLocation = false;

  @override
  void initState() {
    super.initState();
    // ✅ Get API key from environment variables
    try {
      googleMapsKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
    } catch (e) {
      debugPrint('Error accessing dotenv: $e');
      googleMapsKey = '';
    }

    // Check if API key is available
    if (googleMapsKey.isEmpty) {
      debugPrint(
          'Warning: GOOGLE_MAPS_API_KEY not found in environment variables');
    }
  }

  String get locationImage {
    if (_pickedLocation == null || googleMapsKey.isEmpty) return '';
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&markers=color:blue%7Clabel:A%7C$lat,$lng&key=$googleMapsKey';
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        isGettingLocation = true;
      });

      final location = Location();

      // ✅ Check service
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() => isGettingLocation = false);
          return;
        }
      }

      // ✅ Check permission
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() => isGettingLocation = false);
          return;
        }
      }

      // ✅ Get location
      final locationData = await location.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) {
        setState(() => isGettingLocation = false);
        return;
      }

      // ✅ Fetch address from Google Maps Geocoding API
      String address = 'Unknown location';

      if (googleMapsKey.isNotEmpty) {
        try {
          final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&location_type=ROOFTOP&result_type=street_address&key=$googleMapsKey',
          );

          final response = await http.get(url);
          final resJsonBody = json.decode(response.body);

          if (resJsonBody['status'] == 'OK' &&
              resJsonBody['results'] != null &&
              resJsonBody['results'].isNotEmpty) {
            address = resJsonBody['results'][0]['formatted_address'];
          }
        } catch (e) {
          debugPrint('Error fetching address: $e');
          address = 'Location at $lat, $lng';
        }
      } else {
        // Fallback when no API key is available
        address = 'Location at $lat, $lng';
      }

      setState(() {
        _pickedLocation = LocationModel(
          latitude: lat,
          longitude: lng,
          address: address,
        );
        isGettingLocation = false;
      });
    } catch (e) {
      setState(() => isGettingLocation = false);
      debugPrint("❌ Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location set.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );

    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    } else if (_pickedLocation != null) {
      previewContent = Column(
        children: [
          if (locationImage.isNotEmpty)
            Image.network(
              locationImage,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 8),
          Text(
            _pickedLocation!.address,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(80),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: previewContent,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get current location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {
                // TODO: open map screen for manual selection
              },
              label: const Text('Select on map'),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
