import 'package:cours_flutter/models/promo.dart';

class User {
  final String email;
  final String username;
  final String password;
  Promo promo;

  User({required this.email, required this.username, required this.password, required this.promo});
}