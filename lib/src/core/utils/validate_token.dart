import 'package:jwt_decoder/jwt_decoder.dart';

import '../storage/storage.dart';

bool isTokenExpired(String token) {
  try{
    if (JwtDecoder.isExpired(token)) {
      return true; // Token is expired
    } else {
      return false; // Token is not expired
    }
  }catch(e){
    return true;
  }
}

Future<bool> checkToken() async {
  String? accessToken = await Store.getToken();
  try {
    if (accessToken != null) {
      bool isTokenExpired = JwtDecoder.isExpired(accessToken);
      return isTokenExpired;
    } else {
      return true; // Treat missing token as expired
    }
  } catch (e) {
    print("Error decoding token: $e");
    return true; // Assume token is expired or invalid in case of error
  }
}
