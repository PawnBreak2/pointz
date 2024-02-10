import 'package:flutter/material.dart';
import 'package:pointz/common/presentation/widgets/components/app_bar/offline_app_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/app_bar/main_app_bar.dart';

class OpaqueScaffold extends StatelessWidget {
  OpaqueScaffold(
      {super.key,
      required this.body,
      this.title = 'Pointz.',
      this.leading,
      this.isOffline = false});
  String title;
  Widget body;
  Widget? leading;
  bool isOffline;
  @override
  Widget build(BuildContext context) {
    print(leading);
    isOffline ? print('offline') : print('not offline');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: isOffline
            ? OfflineAppBar(
                leading: leading,
              )
            : MainAppBar(
                isOpaque: true,
                hasActions: false,
                title: title,
                leading: leading,
              ),
      ),
      body: body,
    );
  }
}
