import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cours_flutter/providers/cart_provider.dart';
import 'package:cours_flutter/providers/user_provider.dart';
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

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  Future.microtask(() {
      ref.read(userProvider.notifier).initialize();
    });
    // Remonter les pizzas ça serait cool
    //Stream pizzaStream = FirebaseFirestore.instance.collection('pizza').snapshots();

    return  ProviderScope(
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


