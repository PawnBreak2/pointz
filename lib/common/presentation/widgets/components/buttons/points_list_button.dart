import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonForPointsList extends StatelessWidget {
  const ButtonForPointsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      width: 3.h,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Align(
        child: Container(
            height: 1.2.h,
            width: 1.2.h,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            )),
      ),
    );
  }
}
