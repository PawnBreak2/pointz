import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../domain/navigation/navigation_map.dart';
import '../buttons/points_list_button.dart';

class MainAppBar extends StatelessWidget {
  MainAppBar({
    this.isOpaque = false,
    this.hasActions = true,
    super.key,
  });
  bool isOpaque;
  bool hasActions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isOpaque
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.goNamed(NavigationMap.getPage(NavigationPage.map));
              },
            )
          : null,
      actions: hasActions
          ? [
              InkWell(
                  onTap: () {
                    context.goNamed(
                        NavigationMap.getPage(NavigationPage.pointsList));
                  },
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    child: ButtonForPointsList(),
                  )),
            ]
          : [],
      backgroundColor: isOpaque ? Colors.white : Colors.transparent,
      title: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Hero(
          tag: 'logo',
          child: Text(
            'Pointz.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
