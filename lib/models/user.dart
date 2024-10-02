import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/promo.dart';

class User {
  String? id;
  final String email;
  final String username;
  final String password;
  Promo promo;

  User({this.id, required this.email, required this.username, required this.password, required this.promo});

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc['email'],
      username: doc['username'],
      password: doc['password'],
      promo: Promo.values.firstWhere((e) => e.name == doc['promo']),
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'promo': promo.name,
    };
  }
}