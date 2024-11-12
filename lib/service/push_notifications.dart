
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessage(RemoteMessage message)async {
print('Title: ${message.notification?.title}');
print('Body: ${message.notification?.body}');
print('Payload: ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fCMToken = await FirebaseMessaging.instance.getToken();
    print ('Token: $fCMToken' );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  }

}

/*
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    try {
      // Requesting notification permissions (uncomment if needed)
      await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Getting FCM token
      final fCMToken = await firebaseMessaging.getToken();
      print('Token: $fCMToken');

      // Print/log if token retrieval fails
      if (fCMToken == null) {
        print('Failed to retrieve FCM token');
      }
    } catch (e) {
      print('Error during Firebase setup: $e');
    }
  }
}
*/