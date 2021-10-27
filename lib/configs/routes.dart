import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/demo/demo_page.dart';
import 'package:furniture_shop/presentation/pages/home/home_page.dart';
import 'package:furniture_shop/presentation/pages/sign_up/sign_up_page.dart';

class RoutePaths {
  static const String DEMO = "/demo";
  static const String HOME = "/home";
  static const String SIGNUP = "/sign_up";
}

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.DEMO:
        String title = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => DemoPage(title: title), settings: settings);
      case RoutePaths.HOME:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
      case RoutePaths.SIGNUP:
        return MaterialPageRoute(
            builder: (_) => SignUpPage(), settings: settings);
      default:
        return null;
    }
  }
}
