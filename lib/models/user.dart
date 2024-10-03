import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/models/enums/promo.dart';

class User {
  String? id;
  String username;
  Promo promo;

  User({this.id, required this.promo, required this.username});

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return User(
      id: doc.id,
      username: doc['username'],
      promo: Promo.values.firstWhere((e) => e.name == doc['promo']),
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'id': id ?? "",
      'promo': promo.name,
      'username': username, 
    };
  }

  factory User.fromSnapshot(Map<String, dynamic>? json) {
    return User(
      id: json?['id'],
      promo: Promo.values.firstWhere((e) => e.name == json?['promo']),
      username: json?['username'],
    );
  } 
}