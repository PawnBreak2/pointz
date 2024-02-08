import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../domain/navigation/navigation_map.dart';
import '../buttons/points_list_button.dart';

class OfflineAppBar extends StatelessWidget {
  OfflineAppBar({
    this.title = 'Offline Pointz.',
    super.key,
  });
  String title;

  Widget? leading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: IconButton(
          icon: const Icon(
            Icons.location_on_sharp,
            size: 28,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      actions: [
        InkWell(
            onTap: () {
              context
                  .pushNamed(NavigationMap.getPage(NavigationPage.pointsList));
            },
            customBorder: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: ButtonForPointsList(),
            )),
      ],
      backgroundColor: Colors.white,
      title: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Hero(
          tag: 'logo',
          child: Text(
            'Offline Pointz',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
