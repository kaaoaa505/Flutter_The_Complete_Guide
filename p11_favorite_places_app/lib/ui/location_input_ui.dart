import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:p11_favorite_places_app/config/env.dart';
import 'package:p11_favorite_places_app/models/location_model.dart';
import 'package:p11_favorite_places_app/screens/map_screen.dart';

class LocationInputUI extends StatefulWidget {
  const LocationInputUI({super.key, required this.selectLocation});

  final void Function(LocationModel locationModel) selectLocation;

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
    googleMapsKey = Env.googleMapsApiKey;
  }

  String get locationImage {
    if (_pickedLocation == null || googleMapsKey.isEmpty) return '';
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&markers=color:blue|label:A|$lat,$lng&key=$googleMapsKey';
  }

  void _savePlace(double lat, double lng, String address) {
    setState(() {
      isGettingLocation = true;

      _pickedLocation = LocationModel(
        latitude: lat,
        longitude: lng,
        address: address,
      );

      widget.selectLocation(_pickedLocation!);

      isGettingLocation = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    if (isGettingLocation) return;

    try {
      setState(() => isGettingLocation = true);

      final location = Location();

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

      String address = 'Location at $lat, $lng';

      if (googleMapsKey.isNotEmpty) {
        try {
          final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&result_type=street_address&location_type=ROOFTOP&key=$googleMapsKey',
          );

          final response = await http.get(url).timeout(
                const Duration(seconds: 10),
                onTimeout: () =>
                    throw TimeoutException('Geocoding request timed out'),
              );

          final resJsonBody = json.decode(response.body);

          if (resJsonBody['status'] == 'OK' &&
              resJsonBody['results'] != null &&
              resJsonBody['results'].isNotEmpty) {
            address = resJsonBody['results'][0]['formatted_address'];
          }
        } catch (_) {
          address = 'Location at $lat, $lng';
        }
      }

      if (mounted) {
        _savePlace(lat, lng, address);
      }
    } catch (_) {
      if (mounted) setState(() => isGettingLocation = false);
    }
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (builderCtx) => MapScreen()));

    if (pickedLocation == null) return;

    String address = 'Selected location';

    // Get address for the picked location
    if (googleMapsKey.isNotEmpty) {
      try {
        final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${pickedLocation.latitude},${pickedLocation.longitude}&result_type=street_address&location_type=ROOFTOP&key=$googleMapsKey',
        );

        final response = await http.get(url).timeout(
              const Duration(seconds: 10),
              onTimeout: () =>
                  throw TimeoutException('Geocoding request timed out'),
            );

        final resJsonBody = json.decode(response.body);

        if (resJsonBody['status'] == 'OK' &&
            resJsonBody['results'] != null &&
            resJsonBody['results'].isNotEmpty) {
          address = resJsonBody['results'][0]['formatted_address'];
        }
      } catch (_) {
        address =
            'Location at ${pickedLocation.latitude}, ${pickedLocation.longitude}';
      }
    }

    _savePlace(pickedLocation.latitude, pickedLocation.longitude, address);
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
              height: 150,
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
            maxHeight: 200,
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
              onPressed: _selectOnMap,
              label: const Text('Select on map'),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
