import 'package:flutter/material.dart';
import 'package:furniture_shop/presentation/pages/admin/home_admin/home_admin_page.dart';
import 'package:furniture_shop/presentation/pages/admin/order_admin/order_admin_page.dart';
import 'package:furniture_shop/presentation/pages/admin/order_detail_admin/order_detail_admin_page.dart';
import 'package:furniture_shop/presentation/pages/admin/product/edit_product_admin_page.dart';
import 'package:furniture_shop/presentation/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:furniture_shop/presentation/pages/auth/sign_up/sign_up_page.dart';
import 'package:furniture_shop/presentation/pages/customer/add_shipping_address/add_shipping_address_page.dart';
import 'package:furniture_shop/presentation/pages/customer/cart/my_cart_page.dart';
import 'package:furniture_shop/presentation/pages/customer/chat/chat_page.dart';
import 'package:furniture_shop/presentation/pages/customer/checkout/checkout_page.dart';
import 'package:furniture_shop/presentation/pages/customer/demo/demo_page.dart';
import 'package:furniture_shop/presentation/pages/customer/home/home_page.dart';
import 'package:furniture_shop/presentation/pages/customer/notification/notification_page.dart';
import 'package:furniture_shop/presentation/pages/customer/order/order_page.dart';
import 'package:furniture_shop/presentation/pages/customer/order_detail/order_detail_page.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/payment_methods_page.dart';
import 'package:furniture_shop/presentation/pages/customer/product_detail/product_detail_page.dart';
import 'package:furniture_shop/presentation/pages/customer/shipping_addresses/shipping_addresses_page.dart';
import 'package:furniture_shop/presentation/pages/customer/wish_list/whish_list_page.dart';

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
  static const String ADD_SHIPPING_ADDRESSES = '/add_address';
  static const String MY_CART = "/my_cart";
  static const String CHAT_PAGE = '/chat';

  //ADMIN
  static const String ADMIN_HOME = '/admin_home';
  static const String ADMIN_EDIT_PRODUCT_PAGE = '/admin_eidt_product';
  static const String ADMIN_ORDER = '/admin_order';
  static const String ADMIN_ORDER_DETAIL = '/admin_order_detail';
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

      case RoutePaths.PAYMENT_METHODS:
        return MaterialPageRoute(
            builder: (_) => PaymentMethodPage(), settings: settings);
      case RoutePaths.SHIPPING_ADDRESS_PAGE:
        return MaterialPageRoute(
            builder: (_) => ShippingAddressesPage(), settings: settings);

      case RoutePaths.ADD_SHIPPING_ADDRESSES:
        return MaterialPageRoute(
            builder: (_) => AddShippingAddressPage(), settings: settings);

      case RoutePaths.MY_CART:
        return MaterialPageRoute(
            builder: (_) => MyCartPage(), settings: settings);

      case RoutePaths.CHAT_PAGE:
        return MaterialPageRoute(
            builder: (_) => ChatPage(), settings: settings);

      //ADMIN
      case RoutePaths.ADMIN_HOME:
        return MaterialPageRoute(
            builder: (_) => HomeAdminPage(), settings: settings);
      case RoutePaths.ADMIN_EDIT_PRODUCT_PAGE:
        return MaterialPageRoute(
            builder: (_) => EditAdminProductPage(), settings: settings);
      case RoutePaths.ADMIN_ORDER:
        return MaterialPageRoute(
            builder: (_) => OrderAdminPage(), settings: settings);
      case RoutePaths.ADMIN_ORDER_DETAIL:
        return MaterialPageRoute(
            builder: (_) => OrderDetailAdminPage(), settings: settings);
      default:
        return null;
    }
  }
}
