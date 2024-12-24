// add sliver scroll import 'package:edulooker_online_school_fee_payment/src/core/constants/strings/strings_constants.dart';
// import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_title.dart';
// import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/widget_spacing.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/student_profile_widget.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/transport_fee_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:js/js.dart';
// import '../../../../../core/constants/colors/color_constants.dart';
// import '../../../../../core/constants/widgets/logout_dialog.dart';
// import '../../../../../core/constants/widgets/text_widgets.dart';
// import '../../../../../core/storage/storage.dart';
// import '../../../../../route/router_list.dart';
// import '../widgets/hostel_fee_widget.dart';
// import '../widgets/tuition_fee_widget.dart';
//
// @JS()
// external void openPay(String atomId, String merchID, String custEmail,
//     String custMobile, String returnURL); // Declare the JS function
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: WidgetSpacing.padding(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TopTitle(
//                     pageName: KString.topTitle,
//                     enableBackButton: false,
//                   ),
//                   IconButton(
//                       onPressed: () async {
//                         await showDialog(
//                           context: context,
//                           builder: (context) {
//                             return LogoutDialog(context: context);
//                           },
//                         ).then((value) {
//                           if (value == true) {
//                             Store.clear();
//                             context.go(RouteList.login);
//                           }
//                         });
//                       },
//                       icon: Column(
//                         children: [
//                           Icon(
//                             Icons.logout,
//                             color: KColor.red,
//                             size: 14,
//                           ),
//                           TextWidget(
//                             text: "Logout",
//                             fontSize: 8,
//                             tColor: KColor.red,
//                           )
//                         ],
//                       ))
//                 ],
//               ),
//               Gap(30),
//               StudentProfileWidget(),
//               Gap(10),
//               Container(
//                 child: TabBar(
//                   labelColor: KColor.appColor,
//                   unselectedLabelColor: KColor.black,
//                   indicatorColor: KColor.appColor,
//                   dividerColor: Colors.transparent,
//                   labelStyle:
//                   TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//                   padding: EdgeInsets.zero,
//                   isScrollable: true, // Allow TabBar to be scrollable
//                   labelPadding: EdgeInsets.only(right: 10),
//                   tabAlignment: TabAlignment.start,
//                   tabs: [
//                     Tab(text: "Tuition Fee"),
//                     Tab(text: "Transport Fee"),
//                     Tab(text: "Hostel Fee"),
//                   ],
//                 ),
//               ),
//               Gap(20),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     TuitionFeeWidget(),
//                     TransportFeeWidget(),
//                     HostelFeeWidget(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }