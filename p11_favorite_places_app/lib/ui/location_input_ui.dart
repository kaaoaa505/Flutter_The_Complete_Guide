import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:p11_favorite_places_app/config/env.dart';
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
    // ✅ Get API key from environment variables - handle gracefully
    googleMapsKey = Env.googleMapsApiKey;

    debugPrint('🔧 LocationInputUI initialized');
    debugPrint('🔑 API Key length: ${googleMapsKey.length}');
    debugPrint(
        '🔑 API Key starts with: ${googleMapsKey.isNotEmpty ? googleMapsKey.substring(0, min(10, googleMapsKey.length)) : "EMPTY"}...');

    if (googleMapsKey.isNotEmpty) {
      debugPrint('✅ Google Maps API key is available and ready to use');
      debugPrint('🔑 API Key loaded: ${googleMapsKey.substring(0, 10)}...');
    } else {
      debugPrint(
          '⚠️ Warning: GOOGLE_MAPS_API_KEY not found in environment variables');
      debugPrint(
          '📝 Please create a .env file with GOOGLE_MAPS_API_KEY=your_key');
      debugPrint(
          '📋 Available env vars: ${Env.isApiKeyAvailable ? "API key available" : "No API key"}');
    }
  }

  String get locationImage {
    if (_pickedLocation == null || googleMapsKey.isEmpty) return '';
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&markers=color:blue|label:A|$lat,$lng&key=$googleMapsKey';
  }

  Future<void> _getCurrentLocation() async {
    if (isGettingLocation) return; // Prevent multiple simultaneous requests

    try {
      setState(() {
        isGettingLocation = true;
      });

      final location = Location();

      // ✅ Check service with timeout
      bool serviceEnabled = await location.serviceEnabled().timeout(
            const Duration(seconds: 5),
            onTimeout: () => false,
          );
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService().timeout(
              const Duration(seconds: 5),
              onTimeout: () => false,
            );
        if (!serviceEnabled) {
          if (mounted) setState(() => isGettingLocation = false);
          return;
        }
      }

      // ✅ Check permission with timeout
      PermissionStatus permissionGranted =
          await location.hasPermission().timeout(
                const Duration(seconds: 5),
                onTimeout: () => PermissionStatus.denied,
              );
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission().timeout(
              const Duration(seconds: 10),
              onTimeout: () => PermissionStatus.denied,
            );
        if (permissionGranted != PermissionStatus.granted) {
          if (mounted) setState(() => isGettingLocation = false);
          return;
        }
      }

      // ✅ Get location with timeout
      final locationData = await location.getLocation().timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw TimeoutException('Location request timed out'),
          );
      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) {
        if (mounted) setState(() => isGettingLocation = false);
        return;
      }

      // ✅ Fetch address from Google Maps Geocoding API with timeout
      String address = 'Unknown location';

      if (googleMapsKey.isNotEmpty) {
        try {
          final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&result_type=street_address&location_type=ROOFTOP&key=$googleMapsKey',
          );

          debugPrint(
              '🌍 Making geocoding request to: ${url.toString().replaceAll(googleMapsKey, 'API_KEY_HIDDEN')}');
          debugPrint('📍 Coordinates: $lat, $lng');

          final response = await http.get(url).timeout(
                const Duration(seconds: 10),
                onTimeout: () =>
                    throw TimeoutException('Geocoding request timed out'),
              );

          debugPrint('📡 Response status code: ${response.statusCode}');
          debugPrint('📡 Response headers: ${response.headers}');

          final resJsonBody = json.decode(response.body);

          // Log the complete JSON response for debugging
          debugPrint('🔍 Full Geocoding API Response:');
          debugPrint(json.encode(resJsonBody));

          if (resJsonBody['status'] == 'OK' &&
              resJsonBody['results'] != null &&
              resJsonBody['results'].isNotEmpty) {
            address = resJsonBody['results'][0]['formatted_address'];
            debugPrint('✅ Address resolved: $address');
          } else {
            debugPrint(
                '⚠️ Geocoding failed - Status: ${resJsonBody['status']}');
            debugPrint(
                '⚠️ Results count: ${resJsonBody['results']?.length ?? 0}');
            if (resJsonBody['error_message'] != null) {
              debugPrint('❌ Error message: ${resJsonBody['error_message']}');
            }
            address = 'Location at $lat, $lng';
          }
        } catch (e) {
          debugPrint('❌ Error fetching address: $e');
          address = 'Location at $lat, $lng';
        }
      } else {
        // Fallback when no API key is available
        debugPrint(
            '⚠️ No Google Maps API key available - using coordinate fallback');
        address = 'Location at $lat, $lng';
      }

      if (mounted) {
        setState(() {
          _pickedLocation = LocationModel(
            latitude: lat,
            longitude: lng,
            address: address,
          );
          isGettingLocation = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => isGettingLocation = false);
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
        mainAxisSize: MainAxisSize.min,
        children: [
          if (locationImage.isNotEmpty)
            Image.network(
              locationImage,
              height: 150, // Reduced from 170 to leave space for text
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              _pickedLocation!.address,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(
            minHeight: 170,
            maxHeight: 200, // Allow some flexibility
          ),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(80),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: previewContent,
          ),
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
