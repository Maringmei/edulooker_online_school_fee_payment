import 'package:edulooker_online_school_fee_payment/src/core/constants/images/images_constants.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/strings/strings_constants.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/loading_shimmer.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_title.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/student_profile_cubit/student_profile_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/student_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../data/models/student_profile_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetSpacing.padding(
        child: Column(
          children: [
            TopTitle(
              pageName: KString.topTitle,
              enableBackButton: true,
            ),
            Gap(30),
            StudentProfileWidget(),
            Gap(10),
            BlocBuilder<FeeDetailsCubit, FeeDetailsState>(
              builder: (context, state) {
                if (state is FeeDetailsInitial) {
                  return LoadingWidget(
                    count: 3,
                  );
                }
                if (state is FeeDetailsLoaded) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: KColor.filledColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: "Tuition fee"),
                                Theme(
                                  data: ThemeData().copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ListTileTheme(
                                    contentPadding: EdgeInsets.all(0),
                                    dense: true,
                                    horizontalTitleGap: 0.0,
                                    minLeadingWidth: 0,
                                    child: ExpansionTile(
                                      childrenPadding: EdgeInsets.zero,
                                      dense: true,
                                      title: TextWidget(text: "Tuition fee"),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title:
                                              TextWidget(text: "Tuition fee"),
                                          trailing: TextWidget(text: "12345"),
                                        ),
                                        ListTile(
                                          title:
                                              TextWidget(text: "Tuition fee"),
                                          trailing: TextWidget(text: "12345"),
                                        ),
                                        ListTile(
                                          title:
                                              TextWidget(text: "Tuition fee"),
                                          trailing: TextWidget(text: "12345"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }
                if (state is FeeDetailsEmpty) {
                  return Center(
                    child: TextWidget(text: "No data to show"),
                  );
                }
                if (state is FeeDetailsError) {
                  return Center(
                    child: Icon(Icons.error),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
