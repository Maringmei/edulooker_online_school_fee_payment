import '../../../../env.dart';

class Endpoint {
  //baseurl
  static String baseUrl = Env.isStaging ? "https://staging.edulooker.com" : "";
  static const String group = "/api/";
  //login
  static const String sendOtp = "${group}auth/signin";
  static const String verifyOtp = "${group}auth/verify-otp";

  //home=
  //student profile
  static const String studentProfile = "${group}student";

  //fee details
  static const String feeDetails = "${group}student/fee?fee_type=";
}
