import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({super.key, required this.body});
  Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: AppBar(
          actions: [
            Transform.translate(
              offset: Offset(-2.5.h, 0),
              child: Container(
                height: 3.h,
                width: 3.h,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Align(
                  child: Container(
                      height: 1.2.h,
                      width: 1.2.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      )),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
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
          shape: CircleBorder(),
        ),
      ),
      body: body,
    );
  }
}
