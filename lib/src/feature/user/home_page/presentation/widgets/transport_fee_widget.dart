// import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
// import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_snack_bar.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/create_fee_model.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/create_fee_payment_repo.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_hostel_cubit/fee_hostel_cubit.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_list_cubit/fee_list_cubit.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/total_fee_cubit/total_fee_cubit.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/fee_type.dart';
// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/pay_details_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import '../../../../../core/constants/colors/color_constants.dart';
// import '../../../../../core/constants/images/images_constants.dart';
// import '../../../../../core/constants/symbols/symbols_constants.dart';
// import '../../../../../core/constants/widgets/loading_shimmer.dart';
// import '../../../../../core/constants/widgets/text_widgets.dart';
// import '../../../../../core/services/js_services.dart';
// import '../../../../../core/storage/storage.dart';
// import '../../../../../core/utils/date_format.dart';
// import '../../../../../core/utils/download_file.dart';
// import '../../data/models/fee_details_model.dart';
// import '../manager/bloc/fee_details_cubit/fee_details_cubit.dart';
// import '../manager/bloc/fee_transport_cubit/fee_transport_cubit.dart';
// import '../manager/transaction_status.dart';
//
// class TransportFeeWidget extends StatefulWidget {
//   TransportFeeWidget({super.key});
//
//   @override
//   State<TransportFeeWidget> createState() => _TransportFeeWidgetState();
// }
//
// class _TransportFeeWidgetState extends State<TransportFeeWidget> {
//   CreateFeePaymentRepo apiRepo = CreateFeePaymentRepo();
//   bool payButtonActive = false;
//   List<String> feePayList = [];
//
//   // fee exempted status
//   String feeExempted = "1";
//   String feeNotExempted = "0";
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FeeTransportCubit, FeeTransportState>(
//       builder: (context, state) {
//         if (state is FeeTransportInitial) {
//           return LoadingWidget(
//             count: 3,
//           );
//         }
//         if (state is FeeTransportLoaded) {
//           return feeListWidget(context, state);
//         }
//         if (state is FeeTransportEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   KImage.noData,
//                   width: 200,
//                   height: 200,
//                 ),
//               ],
//             ),
//           );
//         }
//         if (state is FeeTransportError) {
//           return errorWidget(state, context);
//         }
//         return Container();
//       },
//     );
//   }
//
//   /*********************************************************************** FEE LIST **********************/
//   Column feeListWidget(BuildContext context, FeeTransportLoaded state) {
//     return Column(
//       children: [
//         Expanded(
//           child: RefreshIndicator(
//             onRefresh: () =>
//                 BlocProvider.of<FeeTransportCubit>(context).getFeeTransport(),
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: state.response.data!.length,
//                 itemBuilder: (context, index) {
//                   FeeData data = state.response.data![index];
//                   return BlocBuilder<FeeListCubit, FeeListState>(
//                     builder: (context, state) {
//                       return state is FeeListInitial
//                           ? GestureDetector(
//                         onTap: () {
//                           if (data.status != TransactionStatus.upPaid) {
//                             //do something
//                           } else {
//                             if (data.feeExempted != feeExempted) {
//                               if (state.checkedFeeList
//                                   .contains(data.feeId)) {
//                                 state.checkedFeeList..remove(data.feeId);
//                               } else {
//                                 state.checkedFeeList..add(data.feeId!);
//                               }
//                               setState(() {});
//                               print(state.checkedFeeList..toString());
//                             }
//                           }
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             // color: feePayList.contains(data.feeId)
//                             //     ? KColor.appColor.withAlpha(30)
//                             //     : KColor.white,
//                             color: KColor.filledColor,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       children: [
//                                         TextWidget(
//                                           text: "${data.paymentFor!} ",
//                                           tColor: KColor.subText,
//                                         ),
//                                         TextWidget(
//                                           text: data.paymentOf!,
//                                           tColor: KColor.subText,
//                                           overflow: TextOverflow
//                                               .ellipsis, // To handle overflow
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   TextWidget(
//                                     text: data.receivedDate!.isNotEmpty
//                                         ? formatDateShort(
//                                         data.receivedDate!)
//                                         : "",
//                                     tColor: KColor.subText,
//                                     fontSize: 10,
//                                   ),
//                                 ],
//                               ),
//
//                               /*********************************************************** DOWNLOAD , Unpaid - when fail to pay ******************/
//                               if (data.status != TransactionStatus.upPaid)
//                                 Theme(
//                                   data: ThemeData().copyWith(
//                                       dividerColor: Colors.transparent),
//                                   child: ListTileTheme(
//                                     contentPadding: EdgeInsets.all(0),
//                                     dense: true,
//                                     horizontalTitleGap: 0.0,
//                                     minLeadingWidth: 0,
//                                     child: ExpansionTile(
//                                       childrenPadding: EdgeInsets.zero,
//                                       dense: true,
//                                       title: Row(
//                                         children: [
//                                           TextWidget(
//                                             text: data.status ==
//                                                 TransactionStatus.paid
//                                                 ? KSymbol.inr +
//                                                 data.recievedAmount
//                                                     .toString()
//                                                 : KSymbol.inr +
//                                                 data.extraFee!.pay
//                                                     .toString(),
//                                             fontWeight: 600,
//                                             fontSize: 18,
//                                           ),
//                                           Gap(10),
//                                           if (data.status !=
//                                               TransactionStatus
//                                                   .deleted &&
//                                               data.status !=
//                                                   TransactionStatus
//                                                       .upPaid)
//                                             Container(
//                                               padding:
//                                               EdgeInsets.symmetric(
//                                                   vertical: 2,
//                                                   horizontal: 5),
//                                               decoration: BoxDecoration(
//                                                   color: data.status ==
//                                                       TransactionStatus
//                                                           .paid
//                                                       ? KColor.green
//                                                       : data.status ==
//                                                       TransactionStatus
//                                                           .initiated
//                                                       ? KColor.pending
//                                                       : data.status ==
//                                                       TransactionStatus
//                                                           .failed
//                                                       ? KColor.red
//                                                       : Colors
//                                                       .transparent,
//                                                   borderRadius:
//                                                   BorderRadius
//                                                       .circular(5)),
//                                               child: TextWidget(
//                                                 text: data.statusDesp!,
//                                                 fontWeight: 600,
//                                                 fontSize: 10,
//                                                 tColor: KColor.white,
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                       expandedCrossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Divider(),
//                                         ListTile(
//                                           title: TextWidget(
//                                             text: "Fee",
//                                           ),
//                                           trailing: TextWidget(
//                                             text: KSymbol.inr +
//                                                 data.extraFee!.fee!,
//                                           ),
//                                         ),
//                                         ListTile(
//                                           title: TextWidget(
//                                             text: "Extra fee",
//                                           ),
//                                           trailing: TextWidget(
//                                             text: KSymbol.inr +
//                                                 data.extraFee!.fine
//                                                     .toString(),
//                                             fontSize: 11,
//                                             fontWeight: 400,
//                                           ),
//                                         ),
//                                         ListTile(
//                                           title: TextWidget(
//                                             text: "Discount",
//                                           ),
//                                           trailing: TextWidget(
//                                             text: KSymbol.inr +
//                                                 data.extraFee!.disc!
//                                                     .toString(),
//                                           ),
//                                         ),
//                                         ListTile(
//                                           title: TextWidget(
//                                             text: "Total Fee",
//                                             fontSize: 12,
//                                             fontWeight: 700,
//                                           ),
//                                           trailing: TextWidget(
//                                             text: KSymbol.inr +
//                                                 data.recievedAmount
//                                                     .toString(),
//                                             fontSize: 12,
//                                             fontWeight: 700,
//                                           ),
//                                         ),
//                                         Gap(20),
//                                         if (data.feeExempted ==
//                                             feeNotExempted &&
//                                             data.status ==
//                                                 TransactionStatus.upPaid)
//                                           ButtonWidget(
//                                             text: "Pay",
//                                             onTap: () async {
//                                               CreateFeeModel response =
//                                               await apiRepo
//                                                   .createFeePayment(
//                                                   feeType: FeeType
//                                                       .tuition,
//                                                   feeID:
//                                                   feePayList)
//                                                   .then((value) {
//                                                 if (value.success ==
//                                                     true &&
//                                                     value.data!.data!
//                                                         .atomTokenId !=
//                                                         null) {
//                                                   openPay(
//                                                     value.data!.data!
//                                                         .atomTokenId
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .merchId
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .custEmail
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .custMobile
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .returnUrl
//                                                         .toString(),
//                                                     value.data!.data!.mode
//                                                         .toString(),
//                                                   );
//                                                 } else {
//                                                   TopSnackBar.showError(
//                                                       context,
//                                                       "Unable to make payment, try again later");
//                                                 }
//                                                 return value;
//                                               });
//                                               //print(response.data!.atomTokenId);
//                                             },
//                                             color: KColor.appColor,
//                                             fullWidth: true,
//                                           ),
//                                         //if transaction failed
//                                         if (data.status ==
//                                             TransactionStatus.failed)
//                                           ButtonWidget(
//                                             text: "Pay",
//                                             onTap: () async {
//                                               CreateFeeModel response =
//                                               await apiRepo
//                                                   .createRetryFeePayment(
//                                                   feeType: FeeType
//                                                       .tuition,
//                                                   feeID:
//                                                   data.feeId!)
//                                                   .then((value) {
//                                                 if (value.success ==
//                                                     true &&
//                                                     value.data!.data!
//                                                         .atomTokenId !=
//                                                         null) {
//                                                   openPay(
//                                                     value.data!.data!
//                                                         .atomTokenId
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .merchId
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .custEmail
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .custMobile
//                                                         .toString(),
//                                                     value.data!.data!
//                                                         .returnUrl
//                                                         .toString(),
//                                                     value.data!.data!.mode
//                                                         .toString(),
//                                                   );
//                                                 } else {
//                                                   TopSnackBar.showError(
//                                                       context,
//                                                       "Unable to make payment, try again later");
//                                                 }
//                                                 return value;
//                                               });
//                                               // print(response.data!.atomTokenId);
//                                             },
//                                             color: KColor.appColor,
//                                             fullWidth: true,
//                                           ),
//                                         /*********************************************************** PAID - DOWNLOAD Receipt ******************/
//                                         // if fee exampted 1 = TRUE
//                                         if (data.feeExempted ==
//                                             feeExempted)
//                                           ButtonWidget(
//                                             text: "Download receipt",
//                                             onTap: () async {
//                                               // downloadFile(data.receiptNo!,
//                                               //     fileName: 'receipt.pdf');
//                                               String? token =
//                                               await Store.getToken()
//                                                   .then((value) {
//                                                 if (value != null) {
//                                                   downloadFile(
//                                                       data.receiptNo!,
//                                                       fileName:
//                                                       'receipt.pdf',
//                                                       bearerToken: value
//                                                           .toString());
//                                                 }
//                                                 return null;
//                                               });
//                                             },
//                                             color: KColor.appColor,
//                                             fullWidth: true,
//                                             icon: Icon(
//                                               Icons.download,
//                                               color: KColor.white,
//                                             ),
//                                           ),
//                                         if (data.status ==
//                                             TransactionStatus.paid)
//                                           ButtonWidget(
//                                             text: "Download receipt",
//                                             onTap: () async {
//                                               String? token =
//                                               await Store.getToken()
//                                                   .then((value) {
//                                                 if (value != null) {
//                                                   downloadFile(
//                                                       data.receiptNo!,
//                                                       fileName:
//                                                       'receipt.pdf',
//                                                       bearerToken: value
//                                                           .toString());
//                                                 }
//                                                 return null;
//                                               });
//                                             },
//                                             color: KColor.appColor,
//                                             fullWidth: true,
//                                             icon: Icon(
//                                               Icons.download,
//                                               color: KColor.white,
//                                             ),
//                                           )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                               /*********************************************************** unpaid PAY list - holder ******************/
//                               if (data.status == TransactionStatus.upPaid)
//                                 Gap(10),
//                               if (data.status == TransactionStatus.upPaid)
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     TextWidget(
//                                       text: data.status ==
//                                           TransactionStatus.paid
//                                           ? KSymbol.inr +
//                                           data.recievedAmount
//                                               .toString()
//                                           : KSymbol.inr +
//                                           data.extraFee!.pay
//                                               .toString(),
//                                       fontWeight: 500,
//                                       fontSize: 18,
//                                     ),
//                                     Gap(10),
//                                     Checkbox(
//                                         activeColor: KColor.appColor,
//                                         checkColor: KColor.white,
//                                         value: state.checkedFeeList
//                                             .contains(data.feeId),
//                                         onChanged: (value) {
//                                           if (data.feeExempted !=
//                                               feeExempted) {
//                                             if (state.checkedFeeList
//                                                 .contains(data.feeId)) {
//                                               state.checkedFeeList
//                                                   .remove(data.feeId);
//                                             } else {
//                                               state.checkedFeeList
//                                                   .add(data.feeId!);
//                                             }
//                                             setState(() {});
//                                             print(state.checkedFeeList
//                                                 .toString());
//                                           }
//                                         })
//                                   ],
//                                 ),
//                               if (data.status == TransactionStatus.upPaid)
//                                 Gap(10),
//                             ],
//                           ),
//                         ),
//                       )
//                           : Container();
//                     },
//                   );
//                 }),
//           ),
//         ),
//         // pay button
//         BlocBuilder<FeeListCubit, FeeListState>(
//           builder: (context, state) {
//             if (state is FeeListInitial) {
//               return state.checkedFeeList.length != 0
//                   ? Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                       child: Container()), // Pushes content to center
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: 150,
//                       child: ButtonWidget(
//                         text: "Pay",
//                         onTap: () async {
//                           List<String> feeList = state.checkedFeeList;
//                           BlocProvider.of<TotalFeeCubit>(context)
//                               .getFeeTotalMultiple(feeList);
//                           // Payment logic
//                           bool? response = await showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return PayDetailsDialog(context: context);
//                               }).then((value) async {
//                             if (value) {
//                               CreateFeeModel response = await apiRepo
//                                   .createFeePayment(
//                                   feeType: FeeType.tuition,
//                                   feeID: feeList)
//                                   .then((paymentDetails) {
//                                 if (paymentDetails.success == true &&
//                                     paymentDetails
//                                         .data!.data!.atomTokenId !=
//                                         null) {
//                                   BlocProvider.of<FeeListCubit>(context)
//                                       .clear();
//                                   openPay(
//                                     paymentDetails.data!.data!.atomTokenId
//                                         .toString(),
//                                     paymentDetails.data!.data!.merchId
//                                         .toString(),
//                                     paymentDetails.data!.data!.custEmail
//                                         .toString(),
//                                     paymentDetails.data!.data!.custMobile
//                                         .toString(),
//                                     paymentDetails.data!.data!.returnUrl
//                                         .toString(),
//                                     paymentDetails.data!.data!.mode
//                                         .toString(),
//                                   );
//                                 } else {
//                                   TopSnackBar.showError(context,
//                                       "Unable to make payment, try again later");
//                                 }
//                                 return value;
//                               });
//                             }
//                             return value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: IconButton(
//                         onPressed: () {
//                           // feePayList.clear();
//                           // setState(() {});
//                           BlocProvider.of<FeeListCubit>(context).clear();
//                         },
//                         icon: Container(
//                           padding: EdgeInsets.all(1),
//                           decoration: BoxDecoration(
//                             color: KColor.btnColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(
//                             Icons.check,
//                             color: KColor.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//                   : Container();
//             }
//             return Container();
//           },
//         ),
//       ],
//     );
//   }
//
//   Center errorWidget(FeeTransportError state, BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             KImage.notFound,
//             width: 150,
//             height: 150,
//           ),
//           TextWidget(text: state.errString),
//           Gap(10),
//           ButtonWidget(
//               text: "Retry",
//               onTap: () {
//                 BlocProvider.of<FeeDetailsCubit>(context).getFeeDetails();
//               }),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_transport_cubit/fee_transport_cubit.dart';
// // import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/transaction_status.dart';
// // import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/tuition_fee_widget.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:gap/gap.dart';
// //
// // import '../../../../../core/constants/colors/color_constants.dart';
// // import '../../../../../core/constants/symbols/symbols_constants.dart';
// // import '../../../../../core/constants/widgets/button_widgets.dart';
// // import '../../../../../core/constants/widgets/loading_shimmer.dart';
// // import '../../../../../core/constants/widgets/text_widgets.dart';
// // import '../../../../../core/constants/widgets/top_snack_bar.dart';
// // import '../../../../../core/services/js_services.dart';
// // import '../../data/models/create_fee_model.dart';
// // import '../../data/models/fee_details_model.dart';
// // import '../../data/repositories/create_fee_payment_repo.dart';
// // import '../manager/bloc/fee_details_cubit/fee_details_cubit.dart';
// // import '../manager/fee_type.dart';
// // import '../pages/home_page.dart';
// //
// // class TransportFeeWidget extends StatelessWidget {
// //   TransportFeeWidget({super.key});
// //
// //   CreateFeePaymentRepo apiRepo = CreateFeePaymentRepo();
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<FeeTransportCubit, FeeTransportState>(
// //       builder: (context, state) {
// //         if (state is FeeTransportInitial) {
// //           return LoadingWidget(
// //             count: 3,
// //           );
// //         }
// //         if (state is FeeTransportLoaded) {
// //           return RefreshIndicator(
// //             onRefresh: () =>
// //                 BlocProvider.of<FeeTransportCubit>(context).getFeeTransport(),
// //             child: ListView.builder(
// //                 shrinkWrap: true,
// //                 itemCount: state.response.data!.length,
// //                 itemBuilder: (context, index) {
// //                   FeeData data = state.response.data![index];
// //                   return Container(
// //                     margin: EdgeInsets.only(bottom: 10),
// //                     padding: EdgeInsets.all(20),
// //                     decoration: BoxDecoration(
// //                         color: KColor.filledColor,
// //                         borderRadius: BorderRadius.circular(8)),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             TextWidget(
// //                                 text: "${data.paymentFor!} ${data.paymentOf!}"),
// //                             TextWidget(
// //                                 text: data.receivedDate!.isNotEmpty
// //                                     ? data.receivedDate!
// //                                     : ""),
// //                           ],
// //                         ),
// //                         Theme(
// //                           data: ThemeData()
// //                               .copyWith(dividerColor: Colors.transparent),
// //                           child: ListTileTheme(
// //                             contentPadding: EdgeInsets.all(0),
// //                             dense: true,
// //                             horizontalTitleGap: 0.0,
// //                             minLeadingWidth: 0,
// //                             child: ExpansionTile(
// //                               childrenPadding: EdgeInsets.zero,
// //                               dense: true,
// //                               title: Row(
// //                                 children: [
// //                                   TextWidget(
// //                                     text:
// //                                         KSymbol.inr + data.extraFee!.pay.toString(),
// //                                     fontWeight: 600,
// //                                     fontSize: 18,
// //                                   ),
// //                                   Gap(10),
// //                                   if (data.status != TransactionStatus.deleted && data.status != TransactionStatus.upPaid)
// //                                     Container(
// //                                       padding: EdgeInsets.all(2),
// //                                       decoration: BoxDecoration(
// //                                           color: data.status ==
// //                                               TransactionStatus.paid
// //                                               ? KColor.green
// //                                               : data.status ==
// //                                               TransactionStatus
// //                                                   .initiated
// //                                               ? KColor.pending
// //                                               :  data.status ==
// //                                               TransactionStatus
// //                                                   .failed ? KColor.red : Colors.transparent,
// //                                           borderRadius:
// //                                           BorderRadius.circular(10)),
// //                                       child: TextWidget(
// //                                         text: data.statusDesp!,
// //                                         fontWeight: 600,
// //                                         fontSize: 8,
// //                                       ),
// //                                     ),
// //                                 ],
// //                               ),
// //                               expandedCrossAxisAlignment:
// //                                   CrossAxisAlignment.start,
// //                               children: [
// //                                 Divider(),
// //                                 ListTile(
// //                                   title: TextWidget(
// //                                     text: "Total fee",
// //                                     fontSize: 11,
// //                                     fontWeight: 400,
// //                                   ),
// //                                   trailing: TextWidget(
// //                                     text: KSymbol.inr + data.extraFee!.fee!,
// //                                     fontSize: 11,
// //                                     fontWeight: 400,
// //                                   ),
// //                                 ),
// //                                 ListTile(
// //                                   title: TextWidget(
// //                                     text: "Extra fee",
// //                                     fontSize: 11,
// //                                     fontWeight: 400,
// //                                   ),
// //                                   trailing: TextWidget(
// //                                     text: KSymbol.inr + data.extraFee!.fine!,
// //                                     fontSize: 11,
// //                                     fontWeight: 400,
// //                                   ),
// //                                 ),
// //                                 ListTile(
// //                                   title: TextWidget(
// //                                     text: "Discount",
// //                                     fontSize: 11,
// //                                     fontWeight: 400,
// //                                   ),
// //                                   trailing: TextWidget(
// //                                     text: KSymbol.inr +
// //                                         data.extraFee!.disc!.toString(),
// //                                     fontSize: 11,
// //                                     fontWeight: 400,
// //                                   ),
// //                                 ),
// //                                 ListTile(
// //                                   title: TextWidget(
// //                                     text: "Total Fee",
// //                                     fontSize: 12,
// //                                     fontWeight: 700,
// //                                   ),
// //                                   trailing: TextWidget(
// //                                     text: KSymbol.inr +
// //                                         data.extraFee!.pay.toString(),
// //                                     fontSize: 12,
// //                                     fontWeight: 700,
// //                                   ),
// //                                 ),
// //                                 Gap(20),
// //                                 if (data.feeExempted == "0" &&
// //                                     data.status == TransactionStatus.upPaid)
// //                                   ButtonWidget(
// //                                     text: "Pay",
// //                                     onTap: () async {
// //                                       CreateFeeModel response = await apiRepo
// //                                           .createFeePayment(
// //                                               feeType: FeeType.transport,
// //                                               feeID: data.feeId!)
// //                                           .then((value) {
// //                                         if (value.success == true &&
// //                                             value.data!.atomTokenId != null) {
// //                                           openPay(
// //                                               value.data!.atomTokenId
// //                                                   .toString(),
// //                                               value.data!.merchId.toString(),
// //                                               value.data!.custEmail.toString(),
// //                                               value.data!.custMobile.toString(),
// //                                               value.data!.returnUrl.toString(),
// //                                           );
// //                                         } else {
// //                                           TopSnackBar.showError(context,
// //                                               "Unable to make payment, try again later");
// //                                         }
// //                                         return value;
// //                                       });
// //                                       print(response.data!.atomTokenId);
// //                                     },
// //                                     color: KColor.appColor,
// //                                     fullWidth: true,
// //                                   ),
// //
// //                                 //if transaction failed
// //                                 if (data.status == TransactionStatus.failed)
// //                                   ButtonWidget(
// //                                     text: "Pay",
// //                                     onTap: () async {
// //                                       CreateFeeModel response = await apiRepo
// //                                           .createRetryFeePayment(
// //                                           feeType: FeeType.tuition,
// //                                           feeID: data.id!)
// //                                           .then((value) {
// //                                         if (value.success == true &&
// //                                             value.data!.atomTokenId != null) {
// //                                           openPay(
// //                                               value.data!.atomTokenId
// //                                                   .toString(),
// //                                               value.data!.merchId.toString(),
// //                                               value.data!.custEmail.toString(),
// //                                               value.data!.custMobile.toString(),
// //                                               value.data!.returnUrl.toString());
// //                                         } else {
// //                                           TopSnackBar.showError(context,
// //                                               "Unable to make payment, try again later");
// //                                         }
// //                                         return value;
// //                                       });
// //                                       print(response.data!.atomTokenId);
// //                                     },
// //                                     color: KColor.appColor,
// //                                     fullWidth: true,
// //                                   ),
// //                                 if (data.feeExempted == "1")
// //                                   ButtonWidget(
// //                                     text: "Download receipt",
// //                                     onTap: () {},
// //                                     color: KColor.appColor,
// //                                     fullWidth: true,
// //                                   ),
// //                                 if (data.status == TransactionStatus.paid)
// //                                   ButtonWidget(
// //                                     text: "Download receipt",
// //                                     onTap: () {},
// //                                     color: KColor.appColor,
// //                                     fullWidth: true,
// //                                   )
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 }),
// //           );
// //         }
// //         if (state is FeeTransportEmpty) {
// //           return Center(
// //             child: TextWidget(text: "No data to show"),
// //           );
// //         }
// //         if (state is FeeTransportError) {
// //           return Center(
// //             child: Icon(Icons.error),
// //           );
// //         }
// //         return Container();
// //       },
// //     );
// //   }
// // }
