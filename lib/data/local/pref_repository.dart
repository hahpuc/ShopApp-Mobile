import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefRepositoryKeys {
  static const String LANGUAGE = "LANGUAGE";
  static const String ACCESSTOKEN = "ACCESSTOKEN";
  static const String REFRESHTOKEN = "REFRESHTOKEN";
  static const String SHOW_ONBOARDING = "SHOW_ONBOARDING";
}

class PrefRepository {
  final SharedPreferences _preferences;
  PrefRepository(this._preferences);

  // ============================ LANGUAGE ===========================

  Locale? getAppLanguage() {
    var langCode = _preferences.getString(PrefRepositoryKeys.LANGUAGE);
    if (langCode == null) return Locale('vi');
    return Locale(langCode);
  }

  Future<bool> setAppLanguage(Locale locale) {
    return _preferences.setString(
        PrefRepositoryKeys.LANGUAGE, locale.languageCode);
  }

  // ============================ USER SESSION ===========================

  String? getAccessToken() {
    String? accessToken =
        _preferences.getString(PrefRepositoryKeys.ACCESSTOKEN);
    if (accessToken == null) return "";
    return accessToken;
  }

  Future<bool> setAccessToken(String token) {
    return _preferences.setString(PrefRepositoryKeys.ACCESSTOKEN, token);
  }

  String? getRefreshToken() {
    String? refreshToken =
        _preferences.getString(PrefRepositoryKeys.REFRESHTOKEN);
    if (refreshToken == null) return "";
    return refreshToken;
  }

  Future<bool> setRefreshToken(String token) {
    return _preferences.setString(PrefRepositoryKeys.REFRESHTOKEN, token);
  }

  void clearUserSession() {
    _preferences.remove(PrefRepositoryKeys.ACCESSTOKEN);
    _preferences.remove(PrefRepositoryKeys.REFRESHTOKEN);
  }

  // ============================ SHOW ONBOARDING ===========================
  Future<bool> finishOnboarding() {
    return _preferences.setBool(PrefRepositoryKeys.SHOW_ONBOARDING, false);
  }

  bool needOnboarding() {
    return _preferences.getBool(PrefRepositoryKeys.SHOW_ONBOARDING) ?? true;
  }
}
