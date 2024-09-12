import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void showLocationDisabledDialog(BuildContext context) {
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
            style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
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
                // Navigate to the settings or handle enabling location
                Navigator.of(context).pop(); // Close the dialog
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
              onPressed: () {
                // this should be going to setting to enable the location
                Navigator.of(context).pop(); 
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
}
