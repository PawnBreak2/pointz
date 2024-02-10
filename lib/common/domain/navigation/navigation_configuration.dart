import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointz/features/offline_maps/presentation/widgets/pages/offline_map_page.dart';
import 'package:pointz/features/offline_maps/presentation/widgets/pages/offline_point_list_page.dart';
import 'package:pointz/features/splash-page/presentation/widgets/pages/splash_page.dart';

import '../../../features/points_in_map/presentation/widgets/pages/map_page.dart';
import '../../../features/points_in_map/presentation/widgets/pages/favorites_list_page.dart';
import 'navigation_map.dart';

class NavigationConfiguration {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: NavigationMap.getPage(NavigationPage.splash),
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
          path: '/map',
          name: NavigationMap.getPage(NavigationPage.map),
          builder: (context, state) => const MapPage(),
          pageBuilder: (context, state) {
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
        path: '/favorite-points-list',
        name: NavigationMap.getPage(NavigationPage.pointsList),
        builder: (context, state) => const PointsListPage(),
      ),
      GoRoute(
        path: '/offline-map',
        name: NavigationMap.getPage(NavigationPage.offlineMap),
        builder: (context, state) => const OfflineMapPage(),
      ),
      GoRoute(
        path: '/offline-points-list',
        name: NavigationMap.getPage(NavigationPage.offlinePointsList),
        builder: (context, state) => const OfflinePointsListPage(),
      ),
    ],
  );
}
