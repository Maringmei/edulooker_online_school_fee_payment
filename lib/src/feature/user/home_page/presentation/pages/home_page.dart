import 'package:edulooker_online_school_fee_payment/src/core/constants/strings/strings_constants.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_title.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/student_profile_widget.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/transport_fee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:js/js.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/symbols/symbols_constants.dart';
import '../../../../../core/constants/widgets/loading_shimmer.dart';
import '../../../../../core/constants/widgets/text_widgets.dart';
import '../../../../../core/utils/download_file.dart';
import '../manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import '../widgets/hostel_fee_widget.dart';
import '../widgets/tuition_fee_widget.dart';

@JS()
external void openPay(String atomId, String merchID, String custEmail,
    String custMobile, String returnURL); // Declare the JS function

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: WidgetSpacing.padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitle(
                pageName: KString.topTitle,
                enableBackButton: false,
              ),
              Gap(30),
              StudentProfileWidget(),
              Gap(10),
              Container(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelColor: KColor.appColor,
                  unselectedLabelColor: KColor.black,
                  indicatorColor: KColor.appColor,
                  dividerColor: Colors.transparent,
                  labelStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  padding: EdgeInsets.zero,
                  isScrollable: true, // Allow TabBar to be scrollable
                  labelPadding: EdgeInsets.only(right: 10),
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: "Tuition Fee"),
                    Tab(text: "Transport Fee"),
                    Tab(text: "Hostel Fee"),
                  ],
                ),
              ),
              Gap(20),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: TuitionFeeWidget()),
                    Center(child: TransportFeeWidget()),
                    Center(child: HostelFeeWidget()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
