import 'package:cours_flutter/models/promo.dart';

class User {
  String? id;
  final String email;
  final String username;
  final String password;
  Promo promo;

  User({this.id, required this.email, required this.username, required this.password, required this.promo});
}