import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/widgets/easy_loading.dart';
import '../../../../../core/constants/widgets/top_snack_bar.dart';
import '../../../../../core/shared/models/shared_model.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../route/router_list.dart';
import '../data_sources/login_api.dart';

class LoginRepo {
  LoginAPI api = LoginAPI();

  Future<bool> sendOtp(
      {required BuildContext context,
      required String regdNumber,
      required String dob,
      required String mobileNumber,
      required String schoolId}) async {
    showStatus(msg: "Please wait...");
    SharedModel res = await api.sendOtp(
        regdNumber: regdNumber,
        dob: dob,
        mobileNumber: mobileNumber,
        schoolId: schoolId);
    if (res.success == true) {
       showDismiss();TopSnackBar.showSuccess(context, res.message ?? "Otp send");

      Store.saveUserInfo(username: "", data: res);
      await Future.delayed(const Duration(seconds: 1));
      context.go(RouteList.home);
      return true;
    } else {
      showDismiss();
      TopSnackBar.showError(context, res.message ?? "Unable to login");
      return false;
    }
  }

  verifyOtp(
      {required BuildContext context,
      required String regdNumber,
      required String mobileNumber,
      required String otp}) async {
    showStatus(msg: "Verifying OTP...");
    SharedModel res = await api.verifyOTP(
        regdNumber: regdNumber, mobileNumber: mobileNumber, otp: otp);
    if (res.success == true) {
      Store.saveUserInfo(username: "", data: res);
      await Future.delayed(const Duration(seconds: 1));
      //BlocManager.afterLoginRefresh(context);
      context.go(RouteList.home);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
      showDismiss();
      TopSnackBar.showSuccess(context, res.message ?? "Otp verified");
    } else {
      showDismiss();
      TopSnackBar.showError(context, res.message ?? "Unable to login");
    }
  }
}
