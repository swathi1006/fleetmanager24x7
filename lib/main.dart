// import 'package:fleet_manager_driver_app/service/database.dart';
// import 'package:fleet_manager_driver_app/service/global.dart';
// import 'package:fleet_manager_driver_app/utils/color.dart';
// import 'package:fleet_manager_driver_app/utils/theme.dart';
// import 'package:fleet_manager_driver_app/view/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';

// Future<void> main() async {
//   print('Connecting to MongoDB');
//   Map<String, dynamic> dbAndCollection = await MongoDB.connect();
//   db = dbAndCollection['db'];
//   collection_drivers = dbAndCollection['collection_drivers'];
//   runApp(const MyApp());
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: myTheme.copyWith(colorScheme: myTheme.colorScheme.copyWith(secondary: secondary)),
//       home: SplashScreen(),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:fleet_manager_driver_app/service/database.dart';
import 'package:fleet_manager_driver_app/service/global.dart';
import 'package:fleet_manager_driver_app/service/push_notifications.dart';
import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:fleet_manager_driver_app/utils/theme.dart';
import 'package:fleet_manager_driver_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  print('Attempting to connect to MongoDB');

  try {
    Map<String, dynamic> dbAndCollection = await MongoDB.connect();
    db = dbAndCollection['db'];
    collection_drivers = dbAndCollection['collection_drivers'];
    print('Connected to MongoDB successfully');
  } catch (e) {
    print('Failed to connect to MongoDB: $e');
    
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDwRxVU_HvQEUX5xNj2npyh8QWGbsAXEhg",
        appId: "1:189281079907:android:b76fd0ce4c2d37080fde56",
        messagingSenderId: "189281079907",
        projectId: "fleetmanager-24x7"
    )
  );
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
  
  // Lock orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme.copyWith(
        colorScheme: myTheme.colorScheme.copyWith(secondary: secondary)
      ),
      home: SplashScreen(),
    );
  }
}
