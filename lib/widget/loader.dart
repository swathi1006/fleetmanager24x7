import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color:primaryColor,
        strokeWidth: 08.00,
      )
    );
  }
}