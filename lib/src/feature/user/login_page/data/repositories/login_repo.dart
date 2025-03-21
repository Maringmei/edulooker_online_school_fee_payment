import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/pages/home_page.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/login_page/data/models/verify_otp_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/widgets/easy_loading.dart';
import '../../../../../core/constants/widgets/top_snack_bar.dart';
import '../../../../../core/shared/models/shared_model.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../route/router_list.dart';
import '../../../home_page/presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import '../../../home_page/presentation/manager/bloc/student_profile_cubit/student_profile_cubit.dart';
import '../data_sources/login_api.dart';

class LoginRepo {
  LoginAPI api = LoginAPI();

  Future<bool> sendOtp({
    required BuildContext context,
    required String mobileNumber,
  }) async {
    showStatus(msg: "Please wait...");
    SharedModel res = await api.sendOtp(
      mobileNumber: mobileNumber,
    );
    if (res.success == true) {
      showDismiss();
      //TopSnackBar.showSuccess(context, res.message ?? "Otp send");

      // Store.saveUserInfo(username: "", data: res);
      // await Future.delayed(const Duration(seconds: 1));
      // context.go(RouteList.home);
      return true;
    } else {
      showDismiss();
      TopSnackBar.showError(context, res.message ?? "Unable to login");
      return false;
    }
  }

  verifyOtp(
      {required BuildContext context,
      required String mobileNumber,
      required String otp}) async {
    showStatus(msg: "Verifying OTP...");
    VerifyOtpModel res =
        await api.verifyOTP(mobileNumber: mobileNumber, otp: otp);
    if (res.success == true) {
      //store data
      Store.saveUserInfo(username: "", data: res);
      await Future.delayed(const Duration(seconds: 1));

     // BlocProvider.of<StudentProfileCubit>(context).getStudentProfile(context);
     // BlocProvider.of<FeeDetailsCubit>(context).getFeeDetails();

      context.go(RouteList.home);
      showDismiss();
      TopSnackBar.showSuccess(context, res.message ?? "Otp verified");
    } else {
      showDismiss();
      TopSnackBar.showError(context, res.message ?? "Unable to login");
    }
  }
}
