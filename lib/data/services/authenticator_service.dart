import 'dart:math';

import 'package:otp/otp.dart';

class AuthenticatorService {
  /// Generate secret random (Base32-compatible)
  static String generateSecret({int length = 16}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    final random = Random.secure();

    return List.generate(
      length,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
  }

  /// Generate otpauth:// URL untuk QR Code
  static String buildOtpAuthUrl({
    required String secret,
    required String email,
    String issuer = 'Evand Coding Store',
  }) {
    return 'otpauth://totp/$issuer:$email'
        '?secret=$secret'
        '&issuer=$issuer'
        '&algorithm=SHA1'
        '&digits=6'
        '&period=30';
  }

  /// Generate kode OTP saat ini
  static String generateCode(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }

  /// Verifikasi kode OTP dengan toleransi ±30 detik
  static bool verifyCode({required String secret, required String code}) {
    final now = DateTime.now().millisecondsSinceEpoch;

    for (int i = -1; i <= 1; i++) {
      final generated = OTP.generateTOTPCodeString(
        secret,
        now + (i * 30000),
        interval: 30,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      );

      if (generated == code.trim()) {
        return true;
      }
    }

    return false;
  }
}
