import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/demo/demo_page.dart';
import 'package:furniture_shop/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:furniture_shop/presentation/pages/home/home_page.dart';
import 'package:furniture_shop/presentation/pages/sign_in/sign_in_page.dart';
import 'package:furniture_shop/presentation/pages/sign_up/sign_up_page.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_page.dart';

class RoutePaths {
  static const String DEMO = "/demo";
  static const String HOME = "/home";
  static const String SIGNUP = "/sign_up";
  static const String SIGNIN = "/sign_in";
  static const String FORGOTPASSWORD = "/forgot_password";
  static const String NOTIFICATION_PAGE = '/notification';
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
      case RoutePaths.SIGNIN:
        return MaterialPageRoute(
            builder: (_) => SignInPage(), settings: settings);
      case RoutePaths.FORGOTPASSWORD:
        return MaterialPageRoute(
            builder: (_) => ForgotPasswordPage(), settings: settings);

      case RoutePaths.NOTIFICATION_PAGE:
        return MaterialPageRoute(
            builder: (_) => NotificationPage(), settings: settings);
      default:
        return null;
    }
  }
}
