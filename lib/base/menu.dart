import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "../routes.dart";

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

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
              for (var route in appRoutes)
                ListTile(
                  title: Text(route.name ?? route.path),
                  onTap: () => {
                    context.go(route.path)
                  },
                )
            ],
          ),
        )
      );
  }
}