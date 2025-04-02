import 'package:edulooker_online_school_fee_payment/src/core/constants/strings/strings_constants.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/loading_shimmer.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_title.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_list_cubit/fee_list_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_type_cubit/fee_type_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/student_profile_cubit/student_profile_cubit.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/fee_type.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/student_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/widgets/logout_dialog.dart';
import '../../../../../core/constants/widgets/text_widgets.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../route/router_list.dart';
import '../manager/bloc/fee_transport_cubit/fee_transport_cubit.dart';
import '../widgets/hostel_fee_updated_widget.dart';
import '../widgets/sliver_widgets/persistant_header.dart';
import '../widgets/sliver_widgets/sliver_title.dart';
import '../widgets/transport_fee_update_widget.dart';
import '../widgets/tuition_fee_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<StudentProfileCubit>(context).getStudentProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: SliverTitle(child:
                    BlocBuilder<StudentProfileCubit, StudentProfileState>(
                  builder: (context, state) {
                    return state is StudentProfileLoaded
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextWidget(
                              text: "Fee Payment",
                              fontSize: 15,
                              fontWeight: 700,
                            ),
                          )
                        : LoadingWidget(count: 1);
                  },
                )),
                automaticallyImplyLeading: true,
                elevation: 0,
                forceElevated: true,
                titleSpacing: 0,
                scrolledUnderElevation: 0,
                pinned: true,
                floating: false,
                expandedHeight: 250, // Adjust height as needed
                backgroundColor: KColor.white,

                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WidgetSpacing.padding(
                              bottom: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TopTitle(
                                    pageName: KString.topTitle,
                                    enableBackButton: false,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return LogoutDialog(context: context);
                                        },
                                      ).then((value) {
                                        if (value == true) {
                                          Store.clear();
                                          BlocProvider.of<FeeListCubit>(context)
                                              .clear();
                                          context.go(RouteList.login);
                                        }
                                      });
                                    },
                                    icon: Column(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: KColor.red,
                                          size: 14,
                                        ),
                                        TextWidget(
                                          text: "Logout",
                                          fontSize: 8,
                                          tColor: KColor.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(20),
                            StudentProfileWidget()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverPersistentHeaderDelegate(
                  TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        BlocProvider.of<FeeTypeCubit>(context)
                            .setFeeType(FeeType.tuition);
                      }
                      if (index == 1) {
                        BlocProvider.of<FeeTypeCubit>(context)
                            .setFeeType(FeeType.hostel);
                      }
                      // if (index == 2) {
                      //   BlocProvider.of<FeeTypeCubit>(context)
                      //       .setFeeType(FeeType.transport);
                      //   BlocProvider.of<FeeTransportCubit>(context)
                      //       .getFeeTransport(context);
                      // }
                    },
                    labelColor: KColor.appColor,
                    unselectedLabelColor: KColor.black,
                    indicatorColor: KColor.appColor,
                    dividerColor: Colors.transparent,
                    labelStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    padding: EdgeInsets.zero,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    tabAlignment: TabAlignment.start,
                    indicatorPadding: EdgeInsets.only(bottom: 10),
                    tabs: [
                      Tab(text: "Tuition Fee"),
                      Tab(text: "Hostel Fee"),
                      //Tab(text: "Transport Fee"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              WidgetSpacing.padding(
                  bottom: 0,
                  child:
                      TuitionFeeWidget()), // Wrap in CustomScrollView or fix scrolling below

              WidgetSpacing.padding(
                bottom: 0,
                child: HostelFeeWidget(),
              ), // Wrap in CustomScrollView or fix scrolling below

              // WidgetSpacing.padding(
              //   bottom: 0,
              //   child: TransportFeeWidget(),
              // ), // Wrap in CustomScrollView or fix scrolling below
            ],
          ),
        ),
      ),
    );
  }
}
