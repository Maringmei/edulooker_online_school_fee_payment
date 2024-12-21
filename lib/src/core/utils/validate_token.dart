import 'package:jwt_decoder/jwt_decoder.dart';

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