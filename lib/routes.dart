import 'package:cours_flutter/views/cart_page.dart';
import 'package:cours_flutter/views/home_page.dart';
import 'package:cours_flutter/views/login_page.dart';
import 'package:cours_flutter/views/register_page.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    name: "Accueil",
    builder: (context, state) => const MyHomePage(),
  ),
  GoRoute(
    path: '/inscription',
    name: "Inscription",
    builder: (context, state) => const RegisterPage(),
  ),
  GoRoute(
    path: '/connexion',
    name: "Connexion",
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/panier',
    name: "Panier",
    builder: (context, state) => const CartPage(),
  ),
];