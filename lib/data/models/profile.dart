// import 'package:cloud_firestore/cloud_firestore.dart';

// class Profile {
//   final String userId;
//   final String email;
//   final int balance;
//   final String pin;
//   final String authSecret;
//   final DateTime? createdAt;

//   Profile({
//     required this.userId,
//     required this.email,
//     required this.balance,
//     required this.pin,
//     required this.authSecret,
//     this.createdAt,
//   });

//   factory Profile.fromFirestore(Map<String, dynamic> json) {
//     return Profile(
//       userId: json['userId'] ?? '',
//       email: json['email'] ?? '',
//       balance: (json['balance'] ?? 0) as int,
//       pin: json['pin'] ?? '',
//       authSecret: json['authSecret'] ?? '',
//       createdAt: json['createdAt'] != null
//           ? (json['createdAt'] as Timestamp).toDate()
//           : null,
//     );
//   }
// }
