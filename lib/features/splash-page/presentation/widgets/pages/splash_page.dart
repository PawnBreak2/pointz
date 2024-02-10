import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pointz/common/presentation/controllers/local_favorites_db_provider.dart';
import 'package:pointz/common/presentation/controllers/local_points_db_provider.dart';
import 'package:pointz/common/presentation/controllers/points_management_provider.dart';
import 'package:pointz/common/presentation/utils/common_strings.dart';
import 'package:pointz/features/splash-page/presentation/controllers/connectivity_checker.dart';
import 'package:pointz/features/splash-page/presentation/utils/splash_page_strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common/domain/navigation/navigation_map.dart';
import '../../../../../common/presentation/controllers/is_loading_provider.dart';
import '../../../../../common/presentation/controllers/is_online_provider.dart';
import '../../controllers/location_controller_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool isLocationServiceEnabled = false;
  LocationPermission permission = LocationPermission.denied;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      List<Future> startupTasks;
      ref.read(isLoadingProvider.notifier).update((state) => true);
      bool isOnline = await checkConnectivity();
      ref.read(isOnlineProvider.notifier).update((state) => isOnline);

      if (isOnline) {
        startupTasks = [
          ref.read(remoteApiProvider.notifier).getMarkers(),
          ref.read(locationControllerProvider.notifier).getLocation(),
          ref.read(localFavoritesProvider.notifier).getFavorites()
        ];
      } else {
        startupTasks = [
          ref.read(localDbProvider.notifier).getMarkers(),
          ref.read(localFavoritesProvider.notifier).getFavorites()
        ];
      }

      Future.wait(startupTasks).whenComplete(() async {
        await Future.delayed(const Duration(seconds: 3));
        ref.read(isLoadingProvider.notifier).update((state) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(isLoadingProvider, (previous, next) {
      if (previous == true && next == false) {
        SchedulerBinding.instance!.addPostFrameCallback((_) async {
          await Future.delayed(const Duration(seconds: 2));
          if (mounted) {
            bool goToOnlineMapPage = !ref.read(isOnlineProvider);
            if (goToOnlineMapPage) {
              context.pushReplacementNamed(
                  NavigationMap.getPage(NavigationPage.map),
                  queryParameters: {
                    'from': NavigationMap.getPage(NavigationPage.splash)
                  });
            } else {
              context.pushReplacementNamed(
                  NavigationMap.getPage(NavigationPage.offlineMap));
            }
          }
        });
      }
    });
    bool isLocationError =
        ref.watch(locationControllerProvider.select((value) => value.isError));
    bool isLoading = ref.watch(isLoadingProvider);
    bool isNetworkError =
        ref.watch(remoteApiProvider.select((value) => value.isError));
    return Scaffold(body: Builder(builder: (context) {
      if (isLoading) {
        return Center(
          child: LoadingAnimationWidget.bouncingBall(
              color: Colors.black, size: 10.w),
        );
      }
      if (isLocationError) {
        String? errorMessage =
            ref.watch(locationControllerProvider).errorMessage;
        errorMessage ?? SplashPageStrings.genericError;
        return Center(
          child: Text(errorMessage!),
        );
      } else if (isNetworkError) {
        String? errorMessage = ref.watch(remoteApiProvider).errorMessage;
        errorMessage ?? CommonStrings.genericNetworkError;
        return Center(
          child: Text(errorMessage!),
        );
      } else {
        return Center(
          child: Hero(
              tag: 'logo',
              child: Text('Pointz.',
                  style: Theme.of(context).textTheme.titleLarge)),
        );
      }
    }));
  }
}
