import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/dummy_dropdown.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/input_text.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_span_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_snack_bar.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/shared/common_api/school_list_api/models/school_list_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_hostel_cubit/fee_hostel_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_transport_cubit/fee_transport_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/student_profile_cubit/student_profile_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/login_page/data/repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/images/images_constants.dart';
import '../../../../../core/constants/strings/strings_constants.dart';
import '../../../../../core/services/dio/endpoint_urls.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../core/utils/date_picker.dart';
import '../../../../../core/utils/redirect_page.dart';
import '../../../../shared/drop_down_widgets/school_list_dropdown.dart';
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
  String? formatedDate;
  String? schoolID;
  bool termAndCondition = false;

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
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView for scrolling
        child: WidgetSpacing.padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                KImage.logoFull,
                width: 250,
              ),
              Gap(10),
              TextWidget(
                text: KString.schoolOnline,
                fontWeight: 700,
                fontSize: 25,
                lineHeight: 2,
              ),
              TextWidget(
                text: KString.feePayment,
                fontWeight: 700,
                fontSize: 25,
                lineHeight: 1,
              ),
              Gap(20),
              // Select school
              TextWidget(
                text: KString.selectSchool,
                fontWeight: 400,
                fontSize: 13,
              ),
              Gap(5),
              DropDownSchoolListWidget(
                dataModel: schoolList,
                onChanged: (String value) {
                  schoolID = value;
                },
                onChangedUrl: (String value) async {
                  Store.setBaseUrl(value);
                  String? baseUrl = await Store.getBaseUrl();
                  print("The baseUrl :" + baseUrl!);
                },
              ),
              Gap(10),
              // Admission number
              TextWidget(
                text: KString.admissionNumber,
                fontWeight: 400,
                fontSize: 13,
              ),
              Gap(5),
              InputText(
                hint: "123456",
                controller: admissionNumber,
              ),
              Gap(10),
              // Date of birth
              TextWidget(
                text: KString.dateOfBirth,
                fontWeight: 400,
                fontSize: 13,
              ),
              Gap(5),
              InkWell(
                onTap: () async {
                  var (startDate, endDate, fdate) = await datePicker(context);
                  dob = startDate;
                  formatedDate = fdate;
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: KColor.filledColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextWidget(
                          text: formatedDate != null
                              ? formatedDate!
                              : "DD MM YYYY",
                          tColor: formatedDate != null
                              ? KColor.black
                              : KColor.subText,
                        ),
                      ),
                      Icon(
                        Icons.calendar_month,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              Gap(10),
              // Mobile number
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
              ),
              Gap(10),
              // Terms and condition
              TextRowWidget(children: [
                Checkbox(
                    value: termAndCondition,
                    onChanged: (value) {
                      termAndCondition = value!;
                      setState(() {});
                    }),
                TextWidget(text: "I agree to "),
                InkWell(
                    onTap: () {
                      redirectToNewTab(Endpoint.term_and_condition);
                    },
                    child: TextWidget(
                      text: "Terms and Condition",
                      tColor: KColor.blue,
                    )),
              ]),
              Gap(20),
              // Submit
              ButtonWidget(
                text: "Submit",
                height: 50,
                onTap: termAndCondition == true
                    ? () async {
                        if (dob != null &&
                            mNumber.text.isNotEmpty &&
                            admissionNumber.text.isNotEmpty &&
                            schoolID != null) {
                          // String admissonNumber = "2335";
                          // String dateOfBirth = "1998-01-03";
                          // String mobileNumber = "7005807751";

                          String admissonNumber = admissionNumber.text;
                          String dateOfBirth = dob!;
                          String mobileNumber = mNumber.text;
                          String sID = schoolID!;
                          await apiRepo
                              .sendOtp(
                            context: context,
                            regdNumber: admissonNumber,
                            dob: dateOfBirth,
                            mobileNumber: mobileNumber,
                            schoolId: schoolID!,
                          )
                              .then((value) {
                            if (value == true) {
                              BlocProvider.of<StudentProfileCubit>(context)
                                  .getStudentProfile();
                              BlocProvider.of<FeeDetailsCubit>(context)
                                  .getFeeDetails();
                              // BlocProvider.of<FeeTransportCubit>(context)
                              //     .getFeeTransport();
                              // BlocProvider.of<FeeHostelCubit>(context)
                              //     .getFeeHostel();

                              // showDialog(
                              //     context: context.mounted ? context : context,
                              //     builder: (context) {
                              //       return OtpDialog(
                              //         context: context,
                              //         data: LoginDataModel(
                              //             registrationNumber: admissonNumber,
                              //             mobileNumber: mobileNumber,
                              //             dob: dateOfBirth,
                              //             schoolId: sID),
                              //       );
                              //     });
                            }
                          });
                        } else {
                          TopSnackBar.showError(
                              context, "All fields are required");
                        }
                      }
                    : null,
                fullWidth: true,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.05), // Spacer with dynamic height
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ),
        ),
      ),
    );
  }
}
