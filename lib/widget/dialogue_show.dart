// ignore_for_file: use_build_context_synchronously

import 'package:fleet_manager_driver_app/model/vehicle.dart';
import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:fleet_manager_driver_app/view/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For handling location permissions

class CustomDialog {
 final selectedVehicle;
  
CustomDialog(this.selectedVehicle);
   void showLocationDisabledDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Location Disabled",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: dashboarddark,
            ),
          ),
          content: const Text(
            "Please enable your location in settings",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without enabling location
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: secondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                // Try enabling the location
                await enableLocation(context);
              },
              child: const Text(
                "Enable Location",
                style: TextStyle(color: secondary),
              ),
            ),
          ],
        );
      },
    );
  }

   Future<void> enableLocation(BuildContext context) async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request the user to enable location services
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // If the user declines to enable location, return without rebuilding
        Navigator.of(context).pop();
        return;
      }
    }

    // Check if the app has permission to access location
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        // If permissions are denied, show a message and return
        Navigator.of(context).pop();
        return;
      }
    }

    // At this point, location services are enabled and permissions are granted
    Navigator.of(context).pop();

    // Force the navigation page to rebuild by popping and pushing the current page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => NavigationScreen(selectedVehicle ),
      ),
    );
  }
}
