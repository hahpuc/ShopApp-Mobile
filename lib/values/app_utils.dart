import 'package:furniture_shop/configs/service_locator.dart';
import 'package:furniture_shop/data/local/pref_repository.dart';

class AppUtils {
  static logout({showInfoDialog = false}) {
    // Clear user session info
    PrefRepository prefRepository = locator.get();
    prefRepository.clearUserSession();
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
}
