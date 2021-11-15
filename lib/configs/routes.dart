import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/add_shipping_address/add_shipping_address_page.dart';
import 'package:furniture_shop/presentation/pages/checkout/checkout_page.dart';
import 'package:furniture_shop/presentation/pages/demo/demo_page.dart';
import 'package:furniture_shop/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:furniture_shop/presentation/pages/home/home_page.dart';
import 'package:furniture_shop/presentation/pages/order/order_page.dart';
import 'package:furniture_shop/presentation/pages/order_detail/order_detail_page.dart';
import 'package:furniture_shop/presentation/pages/product_detail/product_detail_page.dart';
import 'package:furniture_shop/presentation/pages/payment_methods/payment_methods_page.dart';
import 'package:furniture_shop/presentation/pages/sign_in/sign_in_page.dart';
import 'package:furniture_shop/presentation/pages/sign_up/sign_up_page.dart';
import 'package:furniture_shop/presentation/pages/notification/notification_page.dart';
import 'package:furniture_shop/presentation/pages/wish_list/whish_list_page.dart';

class RoutePaths {
  static const String DEMO = "/demo";
  static const String HOME = "/home";
  static const String SIGNUP = "/sign_up";
  static const String SIGNIN = "/sign_in";
  static const String FORGOTPASSWORD = "/forgot_password";
  static const String NOTIFICATION_PAGE = '/notification';
  static const String CHECKOUT_PAGE = '/checkout';
  static const String WISHLIST_PAGE = '/wishlist';
  static const String MY_ORDER = '/my_order';
  static const String ORDER_DETAIL = '/order_detail';
  static const String PRODUCT_DETAIL = '/product_detail';
  static const String SHIPPING_ADDRESS_PAGE = '/shipping_address';
  static const String PAYMENT_METHODS = '/payment_methods';
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

      case RoutePaths.CHECKOUT_PAGE:
        return MaterialPageRoute(
            builder: (_) => CheckOutPage(), settings: settings);

      case RoutePaths.WISHLIST_PAGE:
        return MaterialPageRoute(
            builder: (_) => WishListPage(), settings: settings);

      case RoutePaths.MY_ORDER:
        return MaterialPageRoute(
            builder: (_) => OrderPage(), settings: settings);

      case RoutePaths.ORDER_DETAIL:
        return MaterialPageRoute(
            builder: (_) => OrderDetailPage(), settings: settings);

      case RoutePaths.PRODUCT_DETAIL:
        return MaterialPageRoute(
            builder: (_) => ProductDetailPage(), settings: settings);

      case RoutePaths.SHIPPING_ADDRESS_PAGE:
        return MaterialPageRoute(
            builder: (_) => AddShippingAddressPage(), settings: settings);
      case RoutePaths.PAYMENT_METHODS:
        return MaterialPageRoute(
            builder: (_) => PaymentMethodPage(), settings: settings);
      default:
        return null;
    }
  }
}
