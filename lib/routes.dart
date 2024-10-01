import 'package:cours_flutter/providers/user_provider.dart';
import 'package:cours_flutter/views/cart_page.dart';
import 'package:cours_flutter/views/home_page.dart';
import 'package:cours_flutter/views/login_page.dart';
import 'package:cours_flutter/views/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    name: "Accueil",
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/panier',
    name: "Panier",
    builder: (context, state) => const CartPage(),
  ),
];

final List<GoRoute> connexionRoutes = [
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
];

final List<GoRoute> deconnexionRoutes = [
  GoRoute(
    path: '/deconnexion',
    name: "Deconnexion",
    builder: (context, state) {
      final ref = ProviderScope.containerOf(context).read;
      ref(userProvider.notifier).logout();
      return LoginPage();
    },
  )
];