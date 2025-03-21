import '../../../../env.dart';

class Endpoint {
  //baseurl
  static String baseUrl = Env.isStaging ? "https://staging.edulooker.com" : "https://unacco.edulooker.com";

  static const String group = "/api/";

  //login
  static const String sendOtp = "${group}parents-auth/send-otp";
  static const String verifyOtp = "${group}parents-auth/verify-otp";

  //siblings
  static const String siblings = "${group}parents/siblings";




  //student profile -- deprecated
  static const String studentProfile = "${group}student";

  //fee details
  static const String feeDetails = "${group}student/fee?fee_type=";

  // fee - total report
  static const String totalFee = "${group}pay-fee/multiplefee";

  //fee payment
  static const String createFeePayment = "${group}pay-fee";
  static const String createRetryFeePayment = "${group}pay-fee";

  //download receipt
  static const String downloadReceipt = "${group}pay-fee/download?receiptNo=";


  //login terms and privacy etc...
  static const String term_and_condition = "https://onlinefee.unaccoschool.in/terms.php";
  static const String privacy = "https://onlinefee.unaccoschool.in/privacy.php";
  static const String cancellation = "https://onlinefee.unaccoschool.in/cancellation.php";
  static const String about = "https://khongman.unaccoschool.in/about-school";
  static const String contact = "https://khongman.unaccoschool.in/contacts";

  static const String globizs = "https://globizs.com";

}
