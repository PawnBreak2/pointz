import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/app_bar/main_app_bar.dart';

class OpaqueScaffold extends StatelessWidget {
  OpaqueScaffold({super.key, required this.body});
  Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: MainAppBar(isOpaque: true, hasActions: false),
      ),
      body: body,
    );
  }
}
