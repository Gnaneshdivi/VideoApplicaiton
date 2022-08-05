import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video/Screens/Authentation/auth.dart';
import 'package:video/Screens/Home_Screen/homescreen.dart';
import 'package:video/Globals/globals.dart';
import 'package:video/utils/size_config.dart';
import 'package:video/widgets/custom_loader.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    (() async {
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      if (!mounted) return;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        // add your code here.
        if (prefs.getString('uid') != '') {
          prefs.setString('uid', '');
        }
        Navigator.pushReplacementNamed(
          context,
          AuthenticationScreen.id,
        );
      });
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              'assets/kadi.png',
              height: screenWidth(context) * 0.3,
              width: screenWidth(context) * 0.3,
            ),
          )),
    );
  }
}
