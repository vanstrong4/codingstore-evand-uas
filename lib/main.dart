import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'data/providers/cart_provider.dart';
import './features/auth/screens/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background Message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBUK2ge8jlP6jOqrPcMFrJebSv_oBDL5A0",
      authDomain: "evan-machine-store.firebaseapp.com",
      projectId: "evan-machine-store",
      storageBucket: "evan-machine-store.firebasestorage.app",
      messagingSenderId: "546996661047",
      appId: "1:546996661047:web:83807e710a1b8c193848b2",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(ChangeNotifierProvider(create: (_) => CartProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evan Coding Store',
      home: SplashScreen(),
    );
  }
}
