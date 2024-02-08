import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/app_bar/main_app_bar.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({super.key, required this.body});
  Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: MainAppBar(),
      ),
      body: body,
    );
  }
}
