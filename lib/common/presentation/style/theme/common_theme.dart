import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PointzTheme {
  static ThemeData get theme => ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.tiltWarp(),
          bodyMedium: GoogleFonts.arimo(fontSize: 16.sp),
          labelLarge:
              GoogleFonts.arimo(fontWeight: FontWeight.bold, fontSize: 16.sp),
          labelSmall: GoogleFonts.arimo(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Colors.black,
                width: 3,
              ),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.black,
          selectionHandleColor: Colors.black,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          constraints: BoxConstraints(
            maxHeight: 6.h,
            maxWidth: 80.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.teal,
                width: 1,
              )),
          activeIndicatorBorder: BorderSide.none,
          outlineBorder: BorderSide.none,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
        ),
      );
}
