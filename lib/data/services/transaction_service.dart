import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTransaction({
    required List items,
    required int total,
    required String enteredPin,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) throw Exception("User tidak login");

    final walletRef = _firestore.collection('wallets').doc(user.uid);

    final walletSnap = await walletRef.get();

    if (!walletSnap.exists) {
      throw Exception("Wallet tidak ditemukan");
    }

    final data = walletSnap.data()!;
    final currentBalance = data['balance'] ?? 0;
    final savedPin = data['pin'];

    if (enteredPin != savedPin) {
      throw Exception("PIN salah");
    }

    if (currentBalance < total) {
      throw Exception("Saldo tidak cukup");
    }

    await walletRef.update({'balance': currentBalance - total});

    await _firestore.collection('transactions').add({
      'userId': user.uid,
      'type': 'purchase',
      'items': items
          .map(
            (e) => {
              'name': e.name,
              'price': e.price,
              'image': e.image,
              'description': e.description,
            },
          )
          .toList(),
      'total': total,
      'status': 'paid',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
