import 'package:google_maps_flutter/google_maps_flutter.dart';

class YourMapService {
  static GoogleMapController? _mapController;

  
  static void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  
  static void updateMapLocation(double latitude, double longitude) {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(latitude, longitude),
        ),
      );
      print("Map camera moved to new location.");
    }
  }
}
