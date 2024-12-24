import 'package:js/js.dart';

@JS()
external void openPay(String atomId, String merchID, String custEmail,
    String custMobile, String returnURL); // Declare the JS function