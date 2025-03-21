import 'package:edulooker_online_school_fee_payment/src/core/shared/models/shared_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../env.dart';
import '../../feature/user/login_page/data/models/verify_otp_model.dart';
import '../constants/strings/strings_constants.dart';

class Store {
  const Store._();

  static const String _tokenKeyAccess =
      "${KString.appName}TOKEN_ACCRESS${Env.updateVersion}";
  static const String _tokenKeySibling = "TOKEN_SIBLING";
  static const String _tokenKeyRefresh = "TOKEN_REFRESH";
  static const String _baseUrl = "BASE_URL";
  static const String _baseUrlSiblings = "BASE_URL_SIBLINGS";
  static const String _username = "USERNAME";
  static const String _profileType = "PROFILE_TYPE";
  static const String _darkmode = "darkmode";
  static const String _id = "id";

  //store token
  static Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKeyAccess, token);
  }

  //store baseUrl
  static Future<void> setBaseUrl(String baseUrl) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_baseUrl, baseUrl);
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

  /******************************************************************** SIBLING TOKEN *******************************/
  //store token student
  static Future<void> setTokenSibling(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKeySibling, token);
  }

  // Get token student
  static Future<String?> getTokenSibling() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKeySibling);
  }

  /******************************************************************** BASEURL SIBLING *******************************/

  //store token baseUrl siblings
  static Future<void> setBaseUrlSiblings(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_baseUrlSiblings, token);
  }

  // Get baseURL Siblings
  static Future<String?> getBaseUrlSiblings() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_baseUrlSiblings);
  }

  // Get token
  static Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKeyAccess);
  }

  // Get baseURL
  static Future<String?> getBaseUrl() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_baseUrl);
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
      {required String username, required VerifyOtpModel data}) async {
    if (data.data != null) {
      final token = data.data!.accessToken;
      final tokenRefresh = data.data!.refreshToken;
      await Store.setToken(token!);
      await Store.setTokenRefresh(tokenRefresh!);
    }
  }
}
