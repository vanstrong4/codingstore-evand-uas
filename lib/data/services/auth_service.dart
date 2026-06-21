import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // register akun baru
  Future<void> signUp(String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user!;

    // kirim verifikasi email
    await user.sendEmailVerification();

    // buat wallet otomatis
    await _firestore.collection('wallets').doc(user.uid).set({
      'userId': user.uid,
      'email': user.email,
      'balance': 0,
      'pin': '123456',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // login
  Future<User> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user!;

    if (!user.emailVerified) {
      await _auth.signOut();
      throw Exception("Email belum diverifikasi");
    }

    return user;
  }

  // login dengan google
  Future<User?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);

    final user = result.user;

    if (user != null) {
      final walletDoc = await _firestore
          .collection('wallets')
          .doc(user.uid)
          .get();

      if (!walletDoc.exists) {
        await _firestore.collection('wallets').doc(user.uid).set({
          'userId': user.uid,
          'email': user.email,
          'balance': 0,
          'pin': '123456',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }

    return user;
  }

  // logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
