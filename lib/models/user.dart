import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/promo.dart';

class User {
  String? id;
  Promo promo;

  User({this.id, required this.promo});

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return User(
      id: doc.id,
      promo: Promo.values.firstWhere((e) => e.name == doc['promo']),
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'promo': promo.name,
    };
  }

  factory User.fromSnapshot(Map<String, dynamic>? json, String id) {
    return User(
      id: id,
      promo: Promo.values.firstWhere((e) => e.name == json?['promo']),
    );
  } 
}