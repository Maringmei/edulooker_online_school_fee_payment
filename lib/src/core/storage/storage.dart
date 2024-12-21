import 'package:edulooker_online_school_fee_payment/src/core/shared/models/shared_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();

  static const String _tokenKeyAccess = "TOKEN_ACCRESS";
  static const String _tokenKeyRefresh = "TOKEN_REFRESH";
  static const String _username = "USERNAME";
  static const String _profileType = "PROFILE_TYPE";
  static const String _darkmode = "darkmode";
  static const String _id = "id";

  //store token
  static Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKeyAccess, token);
  }

  //store token refresh
  static Future<void> setTokenRefresh(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKeyRefresh, token);
  }

  // store darkmode
  static Future<void> setDarkMode(bool data) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_darkmode, data);
  }

  // Get token
  static Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKeyAccess);
  }

// Get token refresh
  static Future<String?> getTokenRefresh() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKeyRefresh);
  }

  // get darkmode
  static Future<String?> getDarkMode() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_darkmode);
  }

// clear data
  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  //save user data
  static Future<void> saveUserInfo(
      {required String username, required SharedModel data}) async {
    if (data.data != null) {
      final token = data.data;
      await Store.setToken(token);
    }
  }
}
