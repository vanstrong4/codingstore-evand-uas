import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/services/authenticator_service.dart';

class GoogleAuthenticatorPage extends StatefulWidget {
  const GoogleAuthenticatorPage({super.key});

  @override
  State<GoogleAuthenticatorPage> createState() =>
      _GoogleAuthenticatorPageState();
}

class _GoogleAuthenticatorPageState extends State<GoogleAuthenticatorPage> {
  bool loading = true;

  String secret = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadAuthenticator();
  }

  Future<void> loadAuthenticator() async {
    final user = FirebaseAuth.instance.currentUser!;

    email = user.email ?? "";

    final walletRef = FirebaseFirestore.instance
        .collection("wallets")
        .doc(user.uid);

    final snapshot = await walletRef.get();

    if (!snapshot.exists) {
      secret = AuthenticatorService.generateSecret();

      await walletRef.set({
        "userId": user.uid,
        "email": user.email,
        "balance": 0,
        "pin": "123456",
        "authSecret": secret,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } else {
      final data = snapshot.data()!;

      if (data["authSecret"] == null || data["authSecret"].toString().isEmpty) {
        secret = AuthenticatorService.generateSecret();

        await walletRef.update({"authSecret": secret});
      } else {
        secret = data["authSecret"];
      }
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final otpUrl = AuthenticatorService.buildOtpAuthUrl(
      secret: secret,
      email: email,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Authenticator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1565C0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Icon(Icons.security, size: 80, color: Color(0xFF1565C0)),

            const SizedBox(height: 20),

            const Text(
              "Scan QR Code menggunakan Google Authenticator",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: QrImageView(
                data: otpUrl,
                version: QrVersions.auto,
                size: 250,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Secret Key",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            SelectableText(
              secret,
              textAlign: TextAlign.center,
              style: const TextStyle(letterSpacing: 2, fontSize: 16),
            ),

            const SizedBox(height: 20),

            const Text(
              "Jika QR gagal dipindai, tambahkan akun secara manual menggunakan Secret Key di atas.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
