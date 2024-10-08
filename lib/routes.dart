import 'package:cours_flutter/providers/user_provider.dart';
import 'package:cours_flutter/views/cart/cart_page.dart';
import 'package:cours_flutter/views/command/command_page.dart';
import 'package:cours_flutter/views/home/home_page.dart';
import 'package:cours_flutter/views/login/login_page.dart';
import 'package:cours_flutter/views/register/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<GoRoute> homeRoute = [
  GoRoute(
    path: '/',
    name: "Accueil",
    builder: (context, state) {
      return const HomePage();
    }
  )
];
final List<GoRoute> appRoutes = [
  GoRoute(
    path: '/panier',
    name: "Panier",
    builder: (context, state) { 
      final ref = ProviderScope.containerOf(context).read;
      return ref(userNotifier) == null ? LoginPage() : const CartPage();
    }
  ),
  GoRoute(
    path: "/commande-du-jour",
    name: "La commande du jour",
    builder: (context, state) {
      final ref = ProviderScope.containerOf(context).read;
      return ref(userNotifier) == null ? LoginPage() : const CommandPage();
    }
  ),
];

final List<GoRoute> connexionRoutes = [
  GoRoute(
    path: '/inscription',
    name: "Inscription",
    builder: (context, state) {
      final ref = ProviderScope.containerOf(context).read;
      return ref(userNotifier) == null ? const RegisterPage() : const HomePage();
    } 
  ),
  GoRoute(
    path: '/connexion',
    name: "Connexion",
    builder: (context, state) { 
      final ref = ProviderScope.containerOf(context).read;
      return ref(userNotifier) == null ? LoginPage() : const HomePage();
    }
  ),
];

final List<GoRoute> deconnexionRoutes = [
  GoRoute(
    path: '/deconnexion',
    name: "Deconnexion",
    builder: (context, state) {
      final ref = ProviderScope.containerOf(context).read;
      ref(userNotifier.notifier).logoutFromFirebase();
      return const HomePage();
    },
  )
];
