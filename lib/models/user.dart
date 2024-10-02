import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/promo.dart';

class User {
  String? id;
  final String password;
  Promo promo;

  User({this.id, required this.password, required this.promo});

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return User(
      id: doc.id,
      password: doc['password'],
      promo: Promo.values.firstWhere((e) => e.name == doc['promo']),
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'password': password,
      'promo': promo.name,
    };
  }
}