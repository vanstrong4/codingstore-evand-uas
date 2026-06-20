import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../catalog/screens/home_screen.dart';
import '../../../data/services/notification_service.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    notificationService.init();

    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/ecs.png", height: 120),
            SizedBox(height: 20),
            Text(
              "Evan Machine Store",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
