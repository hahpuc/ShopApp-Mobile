import 'package:flutter/material.dart';
import 'package:furniture_shop/configs/routes.dart';
import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/local/pref_repository.dart';

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
}
