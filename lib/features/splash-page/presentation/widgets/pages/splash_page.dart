import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pointz/common/navigation/navigation_map.dart';
import 'package:pointz/features/splash-page/presentation/utils/splash_page_strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ref.read(locationControllerProvider.notifier).getLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(locationControllerProvider.select((value) => value.isLoading),
        (previous, next) async {
      if (previous == true && next == false) {
        await Future.delayed(Duration(seconds: 2));
        context.pushReplacementNamed(NavigationMap.getPage(NavigationPage.map));
      }
    });
    bool isLocationAvailable =
        !ref.watch(locationControllerProvider.select((value) => value.isError));
    bool isLoading = ref
        .watch(locationControllerProvider.select((value) => value.isLoading));
    return Scaffold(body: Builder(builder: (context) {
      if (isLoading) {
        return Center(
          child: LoadingAnimationWidget.bouncingBall(
              color: Colors.black, size: 10.w),
        );
      }
      if (!isLocationAvailable) {
        String? errorMessage =
            ref.watch(locationControllerProvider).errorMessage;
        errorMessage ?? SplashPageStrings.genericError;
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
