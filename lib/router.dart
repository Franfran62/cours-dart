import 'package:go_router/go_router.dart';
import 'routes.dart';

final GoRouter router = GoRouter(
  routes: [
    ...homeRoute,
    ...appRoutes,
    ...connexionRoutes,
    ...deconnexionRoutes,
  ],
);


