import 'package:cours_flutter/views/home_page.dart';
import 'package:cours_flutter/views/register_page.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  final List<Map<String,String>> roads = [
    {"title": "Home", "path": "/"},
    {"title": "Inscription", "path": "/inscription"},
    {"title": "Connexion", "path": "/connexion"},
    {"title": "Panier", "path": "/panier"},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.zero,
              bottomRight: Radius.zero
          ),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              for (var road in roads)
                ListTile(
                  title: Text(road["title"]!),
                  onTap: () => {
                    Navigator.of(context).pushNamed(road["path"]!)
                  },
                )
            ],
          ),
        )
      );
  }
}