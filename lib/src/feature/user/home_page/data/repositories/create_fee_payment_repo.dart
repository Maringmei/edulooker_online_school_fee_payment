import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/data_sources/create_fee_payment_api.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/data_sources/student_profile_api.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/create_fee_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreateFeePaymentRepo {
  CreateFeePaymentAPI api = CreateFeePaymentAPI();

  Future<CreateFeeModel> createFeePayment(
      {required String feeType, required List feeID}) async {
    EasyLoading.show(status: "Please wait...");
    CreateFeeModel response =
        await api.createFeePayment(feeType: feeType, feeID: feeID);
    if (response.success == true) {
      EasyLoading.dismiss();
      return response;
    } else {
      EasyLoading.dismiss();
      return response;
    }
  }

  Future<CreateFeeModel> createRetryFeePayment(
      {required String feeType, required String feeID}) async {
    EasyLoading.show(status: "Please wait...");
    CreateFeeModel response =
        await api.createRetryFeePayment(feeType: feeType, feeID: feeID);
    if (response.success == true) {
      EasyLoading.dismiss();
      return response;
    } else {
      EasyLoading.dismiss();
      return response;
    }
  }
}
