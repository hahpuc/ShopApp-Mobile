import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/local/pref_repository.dart';
import 'package:furniture_shop/data/model/response/user_response.dart';
import 'package:furniture_shop/presentation/pages/customer/payment_methods/enum.dart';

import '../app.dart';

class AppUtils {
  static void logout({showInfoDialog = false}) {
    // Clear user session info
    PrefRepository prefRepository = locator.get();
    prefRepository.clearUserSession();

    Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!, RoutePaths.SIGNIN, (route) => false);
  }

  static bool isLoggedIn() {
    PrefRepository prefRepository = locator.get();
    var accessToken = prefRepository.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool needOnboarding() {
    PrefRepository prefRepository = locator.get();
    return prefRepository.needOnboarding();
  }

  static void finishOnboarding() {
    PrefRepository prefRepository = locator.get();
    prefRepository.finishOnboarding();
  }

  static void setRoleUser(String role) {
    PrefRepository prefRepository = locator.get();
    prefRepository.setUserRole(role);
  }

  static String getRoleUser() {
    PrefRepository prefRepository = locator.get();
    return prefRepository.getUserRole();
  }

  static void setDefaultAddress(ShippingAddressModel address) {
    PrefRepository prefRepository = locator.get();

    return prefRepository.setDefaultAddress(address);
  }

  static ShippingAddressModel getDefaultAddress() {
    PrefRepository prefRepository = locator.get();
    return prefRepository.getDefaultAddress();
  }

  static void setPaymentMethod(PAYMENT_METHOD method) {
    PrefRepository prefRepository = locator.get();
    prefRepository.setPaymentMethod(method);
  }

  static String getPaymentMethod() {
    PrefRepository prefRepository = locator.get();
    return prefRepository.getPaymentMethod();
  }
}
