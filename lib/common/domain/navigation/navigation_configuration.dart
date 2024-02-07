import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointz/features/splash-page/presentation/widgets/pages/splash_page.dart';

import '../../../features/points_in_map/presentation/widgets/pages/map_page.dart';
import '../../../features/points_in_map/presentation/widgets/pages/points_list_page.dart';

class NavigationConfiguration {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
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
          pageBuilder: (context, state) {
            print(state.pathParameters);
            print(state.pathParameters.containsKey('from'));
            if (state.uri.queryParameters.containsKey('from') &&
                state.pathParameters['from'] == 'splash-page') {
              return CustomTransitionPage(
                child: MapPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 500),
              );
            } else {
              return MaterialPage(
                child: MapPage(),
              );
            }
          }),
      GoRoute(
        path: '/points-list',
        name: 'points-page',
        builder: (context, state) => const PointsListPage(),
      ),
    ],
  );
}
