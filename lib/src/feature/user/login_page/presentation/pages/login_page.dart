import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/input_text.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_span_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/shared/common_api/school_list_api/models/school_list_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/login_page/data/repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/images/images_constants.dart';
import '../../../../../core/constants/strings/strings_constants.dart';
import '../../../../../core/services/dio/endpoint_urls.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../core/utils/redirect_page.dart';
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
  TextEditingController dateController = TextEditingController();
  String? dob;
  String? formatedDate;
  String? schoolID;
  bool termAndCondition = true;

  final _form = GlobalKey<FormState>();

  String? token;

  getToken() async {
    token = await Store.getBaseUrl();
    setState(() {});
  }

  setToken(value) {
    Store.setBaseUrl(value);
    getToken();
    setState(() {});
  }

  initBaseUrl() {
    // Store.setBaseUrl("Www.google.com");
  }

  @override
  void initState() {
    initBaseUrl();
    getToken();
    super.initState();
  }

  @override
  void dispose() {
    admissionNumber.dispose();
    mNumber.dispose();
    super.dispose();
  }

  SchoolListModel schoolList = SchoolListModel(
      success: true,
      data: [
        SchoolData(
            id: "1",
            label: "Unacco School Khongman",
            baseUrl: "https://unacco.edulooker.com"),
        SchoolData(
            id: "2",
            label: "Unacco School Meitram",
            baseUrl: "https://unacco-meitram.edulooker.com"),
      ],
      message: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      body: WidgetSpacing.padding(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    KImage.logoFull,
                    width: 250,
                  ),
                  Gap(10),
                  // TextWidget(
                  //   text: KString.schoolOnline,
                  //   fontWeight: 700,
                  //   fontSize: 25,
                  //   lineHeight: 2,
                  // ),
                  TextWidget(
                    text: KString.feePayment,
                    fontWeight: 700,
                    fontSize: 25,
                    lineHeight: 1,
                  ),
                  Gap(20),
                ],
              ),
              // Mobile number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    KImage.login,
                    scale: 3.5,
                  )),
                  Gap(20),
                  TextWidget(
                    text: KString.mobileNumber,
                    fontWeight: 400,
                    fontSize: 13,
                  ),
                  Gap(5),
                  InputText(
                    hint: "9862000000",
                    controller: mNumber,
                    isPhoneNumber: true,
                    isNumber: true,
                    validation: true,
                    validationMsg: "mobile number",
                  ),
                  Gap(20),

                  // Submit
                  ButtonWidget(
                    text: "Send OTP",
                    height: 50,
                    onTap: termAndCondition == true
                        ? () async {
                            if (_form.currentState!.validate()) {
                              // String admissonNumber = admissionNumber.text;
                              // String dateOfBirth =
                              //     convertDateFormat(dateController.text);
                              // String sID = schoolID!;
                              String mobileNumber = mNumber.text;

                              await apiRepo
                                  .sendOtp(
                                context: context,
                                mobileNumber: mobileNumber,
                              )
                                  .then((value) {
                                if (value == true) {
                                  // BlocProvider.of<StudentProfileCubit>(context)
                                  //     .getStudentProfile();
                                  // BlocProvider.of<FeeDetailsCubit>(context)
                                  //     .getFeeDetails();

                                  // BlocProvider.of<FeeTransportCubit>(context)
                                  //     .getFeeTransport();
                                  // BlocProvider.of<FeeHostelCubit>(context)
                                  //     .getFeeHostel();

                                  showDialog(
                                      context:
                                          context.mounted ? context : context,
                                      builder: (context) {
                                        return OtpDialog(
                                          context: context,
                                          data: LoginDataModel(
                                            mobileNumber: mobileNumber,
                                          ),
                                        );
                                      });
                                }
                              });
                            }
                          }
                        : null,
                    fullWidth: true,
                  ),
                ],
              ),

              Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              redirectToNewTab(Endpoint.privacy);
                            },
                            child: TextWidget(
                              text: "Privacy Policy",
                              fontSize: 10,
                            )),
                        VerticalDivider(
                          color: KColor.black,
                        ),
                        InkWell(
                            onTap: () {
                              redirectToNewTab(Endpoint.about);
                            },
                            child: TextWidget(
                              text: "About us",
                              fontSize: 10,
                            )),
                      ],
                    ),
                  ),
                  Gap(5),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              redirectToNewTab(Endpoint.cancellation);
                            },
                            child: TextWidget(
                              text: "Cancellation & Refund",
                              fontSize: 10,
                            )),
                        VerticalDivider(
                          color: KColor.black,
                        ),
                        InkWell(
                            onTap: () {
                              redirectToNewTab(Endpoint.contact);
                            },
                            child: TextWidget(
                              text: "Contact us",
                              fontSize: 10,
                            )),
                      ],
                    ),
                  ),
                  Gap(10),
                  Center(
                      child: InkWell(
                    onTap: () {
                      redirectToNewTab(Endpoint.globizs);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: "Powered by ",
                            fontSize: 12,
                            fontWeight: 900,
                          ),
                          TextWidget(
                            text: "Globizs",
                            fontSize: 15,
                            fontWeight: 900,
                            tColor: KColor.red,
                          )
                        ]),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
