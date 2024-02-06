import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointz/features/splash-page/presentation/widgets/pages/splash_page.dart';

import '../../features/map-page/presentation/widgets/pages/map_page.dart';

class NavigationConfiguration {
  static final GoRouter routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash-page',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/map',
        name: 'map-page',
        builder: (context, state) => const MapPage(),
        pageBuilder: (context, state) => CustomTransitionPage(
          child: MapPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      ),
    ],
  );
}
