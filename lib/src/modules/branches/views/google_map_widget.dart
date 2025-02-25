import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A Google Map widget that displays markers for a list of positions.
///
/// **Usage:**
/// ```dart
/// GoogleMapWidget(
///   locations: [
///     LatLng(15.5007, 32.5599), // Example: Khartoum
///     LatLng(15.609, 32.525),   // Example: Omdurman
///   ],
/// )
/// ```
class GoogleMapWidget extends StatelessWidget {
  final List<LatLng> locations;

  const GoogleMapWidget({super.key, required this.locations});


  /// Default camera position (Center the map on the first location)
  CameraPosition get initialPosition => locations.isNotEmpty
      ? CameraPosition(target: locations.first, zoom: 12)
      : CameraPosition(target: LatLng(15.5007, 32.5599), zoom: 12); // Default (Khartoum)

  /// Convert locations to markers
  Set<Marker> get markers => locations
      .map((location) => Marker(
    markerId: MarkerId(location.toString()),
    position: location,
    infoWindow: InfoWindow(title: "Branch Location"),
  ))
      .toSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          // _mapController = controller;
        },
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
