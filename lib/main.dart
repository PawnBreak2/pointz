import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pointz/common/presentation/style/theme/common_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'common/domain/navigation/navigation_configuration.dart';

void main() async {
  await dotenv.load();
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
          theme: PointzTheme.theme,
        ),
      );
    });
  }
}
