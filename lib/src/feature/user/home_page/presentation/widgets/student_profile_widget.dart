import 'dart:ui';

import 'package:edulooker_online_school_fee_payment/src/core/constants/colors/color_constants.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_snack_bar.dart';
import 'package:edulooker_online_school_fee_payment/src/core/storage/storage.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/sibling_list_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_list_cubit/fee_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../core/constants/images/images_constants.dart';
import '../../../../../core/constants/widgets/loading_shimmer.dart';
import '../../../../../core/constants/widgets/text_widgets.dart';
import '../manager/bloc/student_profile_cubit/student_profile_cubit.dart';

class StudentProfileWidget extends StatefulWidget {
  const StudentProfileWidget({super.key});

  @override
  State<StudentProfileWidget> createState() => _StudentProfileWidgetState();
}

class _StudentProfileWidgetState extends State<StudentProfileWidget> {
  int currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        index * MediaQuery.of(context).size.width / 1.5, // Adjust offset based on item width
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentProfileCubit, StudentProfileState>(
      builder: (context, state) {
        if (state is StudentProfileInitial) {
          return LoadingWidget(
            count: 2,
          );
        }
        if (state is StudentProfileLoaded) {
          return SizedBox(
            height: 150, // Adjust as needed
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(
                scrollbars: true,
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse, // Enables mouse scrolling
                },
              ),
              child: ListView.builder(
                controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.response.data!.length,
                  itemBuilder: (context, index) {
                    SiblingData? studentData = state.response.data![index];
                    double screenWidth = MediaQuery.of(context).size.width;
                    return InkWell(
                      onTap: () async {
                        if (studentData.accessToken != null ||
                            studentData.accessToken!.isNotEmpty) {
                          currentIndex = index;
                          _scrollToIndex(currentIndex);
                          setState(() {});
                          Store.setBaseUrlSiblings(studentData.baseUrl!);
                          Store.setTokenSibling(studentData.accessToken!);
                          await Future.delayed(Duration(seconds: 1));
                          BlocProvider.of<FeeListCubit>(context).clear();
                          BlocProvider.of<FeeDetailsCubit>(context)
                              .getFeeDetails();
                        } else {
                          TopSnackBar.showError(
                              context, "Student data not found.");
                        }
                      },
                      child: Container(
                          width: screenWidth / 1.5,
                          height: 200,
                          margin: EdgeInsets.all(5),
                          // decoration: BoxDecoration(color: KColor.white),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color:KColor.white,
                                image: DecorationImage(
                                  image: AssetImage(KImage.student),
                                  alignment: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              border: Border.all(color:currentIndex == index ? KColor.black : Colors.transparent, width: currentIndex == index ? 2 : 0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: studentData.firstName ?? "NA",
                                  fontSize: 16,
                                  fontWeight: 700,
                                ),
                                Gap(10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Adm no: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: KColor.subText)),
                                              TextSpan(
                                                  text: studentData!
                                                      .registrationNo,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: KColor.black)),
                                            ])),
                                            Gap(5),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Section ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: KColor.subText)),
                                              TextSpan(
                                                  text: studentData!.section ??
                                                      "N/A",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: KColor.black)),
                                            ])),
                                          ],
                                        )),
                                    Gap(10),
                                    Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Class: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: KColor.subText)),
                                              TextSpan(
                                                  text: studentData.course,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: KColor.black)),
                                            ])),
                                            Gap(5),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Roll No ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: KColor.subText)),
                                              TextSpan(
                                                  text: studentData
                                                          .rollNo!.isNotEmpty
                                                      ? studentData.rollNo
                                                      : "NA",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: KColor.black)),
                                            ])),
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  }),
            ),
          );
        }
        if (state is StudentProfileError) {
          return LoadingWidget(
            count: 2,
          );
        }
        return Container();
      },
    );
  }
}
