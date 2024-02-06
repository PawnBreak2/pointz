import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointz/common/navigation/navigation_configuration.dart';
import 'package:pointz/common/widgets/scaffolds/main_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PointzApp(),
    );
  }
}

class PointzApp extends StatelessWidget {
  const PointzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, __, ___) {
      return ProviderScope(
        child: MaterialApp.router(
          routerConfig: NavigationConfiguration.routes,
          title: 'Pointz',
          theme: ThemeData(
            textTheme: TextTheme(
              titleLarge: GoogleFonts.tiltWarp(),
              bodyMedium: GoogleFonts.arimo(fontSize: 16.sp),
              labelLarge: GoogleFonts.arimo(
                  fontWeight: FontWeight.bold, fontSize: 16.sp),
              labelSmall: GoogleFonts.arimo(),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                side: MaterialStateProperty.all(
                  BorderSide(
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
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.teal,
                    width: 1,
                  )),
              activeIndicatorBorder: BorderSide.none,
              outlineBorder: BorderSide.none,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
            ),
          ),
        ),
      );
    });
  }
}
