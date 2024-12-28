import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/images/images_constants.dart';
import '../../../../../core/constants/widgets/loading_shimmer.dart';
import '../../../../../core/constants/widgets/text_widgets.dart';
import '../../data/models/student_profile_model.dart';
import '../manager/bloc/student_profile_cubit/student_profile_cubit.dart';

class StudentProfileWidget extends StatelessWidget {
  const StudentProfileWidget({super.key});

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
          StudentData? studentData = state.response.data;
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: KColor.white,
                image: DecorationImage(
                  image: AssetImage(KImage.student),
                  alignment: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: studentData!.name!,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Adm no: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: KColor.subText)),
                              TextSpan(
                                  text: studentData!.registrationNo,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: KColor.black)),
                            ])),
                            Gap(5),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Section ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: KColor.subText)),
                              TextSpan(
                                  text: studentData!.section.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: KColor.black)),
                            ])),
                          ],
                        )),
                    Gap(10),
                    Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Class: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: KColor.subText)),
                              TextSpan(
                                  text: studentData.course,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: KColor.black)),
                            ])),
                            Gap(5),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Roll No ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: KColor.subText)),
                              TextSpan(
                                  text: studentData.rollNo!.isNotEmpty
                                      ? studentData.rollNo
                                      : "NA",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: KColor.black)),
                            ])),
                          ],
                        )),
                  ],
                )
              ],
            ),
          );
        }
        if (state is StudentProfileError) {
          return Center(
            child: Column(
              children: [
                TextWidget(text: state.errString),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<StudentProfileCubit>(context)
                          .getStudentProfile();
                    },
                    child: TextWidget(text: "Retry")),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
