import 'package:cours_flutter/views/home_page.dart';
import 'package:cours_flutter/views/inscription_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const MyHomePage(),
        "/inscription": (context) => const MyInscriptionPage()
      },
      initialRoute: "/",
    );
  }
}


