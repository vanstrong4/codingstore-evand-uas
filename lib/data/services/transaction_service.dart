import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTransaction({
    required List items,
    required int total,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await _firestore.collection('transactions').add({
      'userId': user.uid,
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
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
