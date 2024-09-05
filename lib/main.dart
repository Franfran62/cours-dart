import 'package:cours_flutter/views/home_page.dart';
import 'package:cours_flutter/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => MyHomePage(),
    '/inscription': (context) => MyInscriptionPage(),
  };

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: routes,
        initialRoute: "/",
      ),
    );
  }
}


