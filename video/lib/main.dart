// @dart=2.9
import 'package:flutter/material.dart';
import 'package:video/Screens/Home_Screen/homescreen.dart';
import 'package:video/Screens/splashscreen.dart/splashscreen.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video/utils/app_theme.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/utils/route_generator.dart';
import 'package:video/utils/size_config.dart';

import 'Screens/Authentation/auth.dart';

Future<void> main() async {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kadi',
      scaffoldMessengerKey: Globals.scaffoldMessengerKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: SplashScreen.id,
    );
  }
}
