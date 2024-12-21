import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/dummy_dropdown.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/input_text.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/login_page/data/repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/images/images_constants.dart';
import '../../../../../core/constants/strings/strings_constants.dart';
import '../../data/models/login_data_model.dart';
import '../widgets/verify_otp_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginRepo apiRepo = LoginRepo();

  TextEditingController admissionNumber = TextEditingController();
  TextEditingController mNumber = TextEditingController();
  String? dob;
  String? schoolID;

  @override
  void dispose() {
    // TODO: implement dispose
    admissionNumber.dispose();
    mNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetSpacing.padding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlutterLogo(
                size: 63,
                duration: Duration(seconds: 1),
                curve: Curves.bounceIn,
                textColor: KColor.black),
            Gap(20),
            TextWidget(
              text: KString.schoolOnline,
              fontWeight: 700,
              fontSize: 30,
              lineHeight: 1,
            ),
            TextWidget(
              text: KString.feePayment,
              fontWeight: 700,
              fontSize: 30,
              lineHeight: 1,
            ),
            Gap(20),
            //select school
            TextWidget(
              text: KString.selectSchool,
              fontWeight: 400,
              fontSize: 13,
            ),
            Gap(5),
            DummyDropdownWidget(hintText: "Select School"),
            Gap(10),
            // admission number
            TextWidget(
              text: KString.admissionNumber,
              fontWeight: 400,
              fontSize: 13,
            ),
            Gap(5),
            InputText(hint: "ADM123456"),
            Gap(10),
            // date of birth
            TextWidget(
              text: KString.dateOfBirth,
              fontWeight: 400,
              fontSize: 13,
            ),
            Gap(5),
            InputText(hint: "DD/MM/YYYY"),
            Gap(10),
            // mobile number
            TextWidget(
              text: KString.mobileNumber,
              fontWeight: 400,
              fontSize: 13,
            ),
            Gap(5),
            InputText(hint: "+910000000000"),
            Gap(20),
            //submit
            ButtonWidget(
              text: "Submit",
              onTap: () async {
                String admissonNumber = "2335";
              //  String admissonNumber = "2333";
                String dateOfBirth = "1998-01-03";
                String mobileNumber = "7005807751";
               // String mobileNumber = "9501179924";
                await apiRepo
                    .sendOtp(
                        context: context,
                        regdNumber: admissonNumber,
                        dob: dateOfBirth,
                        mobileNumber: mobileNumber)
                    .then((value) {
                  if (value == true) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return OtpDialog(
                            context: context,
                            data: LoginDataModel(
                                registrationNumber: admissonNumber,
                                mobileNumber: mobileNumber,
                                dob: dateOfBirth),
                          );
                        });
                  }
                });
              },
              fullWidth: true,
            ),
            Spacer(),
            Center(
              child: SizedBox(
                  height: 23, width: 148, child: Image.asset(KImage.branding)),
            )
          ],
        ),
      ),
    );
  }
}
