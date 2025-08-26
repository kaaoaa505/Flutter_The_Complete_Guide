import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p11_favorite_places_app/models/location_model.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, LocationModel? locationModel, this.isSelecting = true})
      : locationModel = locationModel ??
            LocationModel(
              latitude: 26.37,
              longitude: 50.17,
              address:
                  '6907 Al Kabari St - Al Hussam District, Dammam 34223 - 2600, Saudi Arabia',
            );

  final LocationModel locationModel;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng target;
  late LatLng initialTarget;
  bool hasLocationChanged = false;

  @override
  void initState() {
    super.initState();
    target = LatLng(
      widget.locationModel.latitude,
      widget.locationModel.longitude,
    );
    initialTarget = target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting
            ? (hasLocationChanged
                ? 'Location Selected!'
                : 'Pick your location!')
            : 'Your Location.'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(target);
                },
                icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            target = position;
            hasLocationChanged = true;
          });
        },
        initialCameraPosition: CameraPosition(
          target: target,
          zoom: 16,
        ),
        markers: {
          if (widget.isSelecting)
            Marker(
              markerId: const MarkerId('selected_location_marker_id'),
              position: target,
              infoWindow: const InfoWindow(
                title: 'Pinned Location',
                snippet: 'Tap to change location',
              ),
            ),
        },
      ),
    );
  }
}
