import 'package:flutter/material.dart';
import 'package:video/utils/helpers.dart';

import '../Screens/Authentation/auth.dart';
import '../Screens/Croped.dart/cropped.dart';
import '../Screens/Home_Screen/homescreen.dart';
import '../Screens/people.dart/Peoplelist.dart';
import '../Screens/splashscreen.dart/splashscreen.dart';
import '../Screens/videos.dart/videos.dart';

class RouteGenerator {
  static const _id = 'RouteGenerator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log(_id, msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case HomeScreen.id:
        return _route(HomeScreen());
      case AuthenticationScreen.id:
        return _route(AuthenticationScreen());
      case SplashScreen.id:
        return _route(SplashScreen());
      case PeopleList.id:
        return _route(PeopleList());
      case CropedList.id:
        return _route(CropedList());
      case VideoList.id:
        return _route(VideoList());

      // case VerifyPhoneNumberScreen.id:
      //   return _route(VerifyPhoneNumberScreen(
      //     phoneNumber: args,
      //   ));
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('ROUTE \n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
