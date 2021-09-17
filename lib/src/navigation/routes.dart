import 'package:flutter/material.dart';
import 'package:sugar_meter/src/ui/home_page.dart';
import 'package:sugar_meter/src/ui/sign_in_page.dart';
import 'package:sugar_meter/src/ui/splash_page.dart';

class Routes {
  Routes();

  //root navigation point of my app (start point - The first place)
  static const splash = '/';
  static const signIn = '/signIn';
  static const home = '/home';

  static Route routes(RouteSettings routeSettings) {
    // final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => SplashScreen.create());
      case signIn:
        return MaterialPageRoute(builder: (context) => SignInPage.create());
      case home:
        return MaterialPageRoute(builder: (context) => HomePage.create());
      default:
        throw Exception('Oops, How did i get here?');
    }
  }
}
