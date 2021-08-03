import 'dart:async';
import 'dart:convert';

import 'package:iiserk_app/models/User.dart';
import 'package:iiserk_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.IS_USER_LOGGED_IN) ?? false;
  }

  static Future<bool> setUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SharedPreferenceKeys.IS_USER_LOGGED_IN, isLoggedIn);
  }

  static Future<User> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User.fromJson(
        json.decode(prefs.getString(SharedPreferenceKeys.APP_USER) ?? ''));
  }

  static Future<bool> setUserProfile(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfile = json.encode(user);
    return prefs.setString(SharedPreferenceKeys.APP_USER, userProfile);
  }

  static Future<bool> setPrefs(String prefKey, String prefValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(prefKey, prefValue);
  }

  static Future<String?> getPrefs(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey);
  }
}
