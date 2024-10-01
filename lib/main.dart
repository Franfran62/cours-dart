import 'package:cours_flutter/providers/UserProvider.dart';
import 'package:cours_flutter/views/cart_page.dart';
import 'package:cours_flutter/views/home_page.dart';
import 'package:cours_flutter/views/login_page.dart';
import 'package:cours_flutter/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const MyHomePage(),
    '/inscription': (context) => const RegisterPage(),
    '/connexion': (context) => LoginPage(),
    '/panier': (context) => const CartPage(),
  };

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}


