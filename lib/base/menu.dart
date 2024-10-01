import 'package:cours_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "../routes.dart";

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  ConsumerState<Menu> createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {

  @override
  Widget build(BuildContext context) {

    List<GoRoute> routes = 
      ref.read(firebaseUser.notifier).state == null 
      ? [...appRoutes,...connexionRoutes]
      : [...appRoutes, ...deconnexionRoutes];

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
              for (var route in routes)
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