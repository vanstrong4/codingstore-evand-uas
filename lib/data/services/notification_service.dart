import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    // izin akses
    await _fcm.requestPermission();

    // ambil token
    String? token = await _fcm.getToken();
    print("FCM TOKEN: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification?.title}");
    });
  }
}
