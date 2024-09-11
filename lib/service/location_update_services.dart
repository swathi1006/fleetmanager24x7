import 'dart:async';
import 'package:fleet_manager_driver_app/service/gmap_service.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fleet_manager_driver_app/service/database.dart';

class LocationUpdateService {
  late String vehicleNumber;

  LocationUpdateService(this.vehicleNumber);

  Timer? _locationTimer;
  bool _isUpdating = false;

  void startLocationUpdates() {
    if (!_isUpdating) {
      _isUpdating = true;
      _locationTimer = Timer.periodic(const Duration(minutes: 5), (timer) async {
        Position position = await Geolocator.getCurrentPosition(
            // ignore: deprecated_member_use
            desiredAccuracy: LocationAccuracy.high);
        double latitude = position.latitude;
        double longitude = position.longitude;

        
        await updateLocation(vehicleNumber, latitude, longitude);

        // updating map location 
        YourMapService.updateMapLocation(latitude, longitude);
        
      });
    }
  }



  void stopLocationUpdates() {
    if (_isUpdating) {
      _locationTimer?.cancel();
      _isUpdating = false;
    }
  }

  void startTrip() {
    startLocationUpdates();
  }

  void pauseTrip() {
    startLocationUpdates();
  }

  void endTrip() {
    stopLocationUpdates();
    // Optionally update trip end time in the database
    // YourDatabaseService.updateTripEndTime();
  }
}
