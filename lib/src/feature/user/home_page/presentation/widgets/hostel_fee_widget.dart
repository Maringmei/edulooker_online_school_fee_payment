// import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/tuition_fee_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
//
// import '../../../../../core/constants/colors/color_constants.dart';
// import '../../../../../core/constants/symbols/symbols_constants.dart';
// import '../../../../../core/constants/widgets/button_widgets.dart';
// import '../../../../../core/constants/widgets/loading_shimmer.dart';
// import '../../../../../core/constants/widgets/text_widgets.dart';
// import '../../../../../core/constants/widgets/top_snack_bar.dart';
// import '../../../../../core/services/js_services.dart';
// import '../../../../../core/utils/download_file.dart';
// import '../../data/models/create_fee_model.dart';
// import '../../data/models/fee_details_model.dart';
// import '../../data/repositories/create_fee_payment_repo.dart';
// import '../manager/bloc/fee_details_cubit/fee_details_cubit.dart';
// import '../manager/bloc/fee_hostel_cubit/fee_hostel_cubit.dart';
// import '../manager/fee_type.dart';
// import '../manager/transaction_status.dart';
// import '../pages/home_page.dart';
//
// class HostelFeeWidget extends StatelessWidget {
//   HostelFeeWidget({super.key});
//
//   CreateFeePaymentRepo apiRepo = CreateFeePaymentRepo();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FeeHostelCubit, FeeHostelState>(
//       builder: (context, state) {
//         if (state is FeeHostelInitial) {
//           return LoadingWidget(
//             count: 3,
//           );
//         }
//         if (state is FeeHostelLoaded) {
//           return RefreshIndicator(
//             onRefresh: () =>
//                 BlocProvider.of<FeeHostelCubit>(context).getFeeHostel(),
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: state.response.data!.length,
//                 itemBuilder: (context, index) {
//                   FeeData data = state.response.data![index];
//                   return Container(
//                     margin: EdgeInsets.only(bottom: 10),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                         color: KColor.filledColor,
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextWidget(
//                                 text: "${data.paymentFor!} ${data.paymentOf!}"),
//                             TextWidget(
//                                 text: data.receivedDate!.isNotEmpty
//                                     ? data.receivedDate!
//                                     : ""),
//                           ],
//                         ),
//                         Theme(
//                           data: ThemeData()
//                               .copyWith(dividerColor: Colors.transparent),
//                           child: ListTileTheme(
//                             contentPadding: EdgeInsets.all(0),
//                             dense: true,
//                             horizontalTitleGap: 0.0,
//                             minLeadingWidth: 0,
//                             child: ExpansionTile(
//                               childrenPadding: EdgeInsets.zero,
//                               dense: true,
//                               title: Row(
//                                 children: [
//                                   TextWidget(
//                                     text: KSymbol.inr +
//                                         data.extraFee!.pay.toString(),
//                                     fontWeight: 600,
//                                     fontSize: 18,
//                                   ),
//                                   Gap(10),
//                                   if (data.status !=
//                                           TransactionStatus.deleted &&
//                                       data.status != TransactionStatus.upPaid)
//                                     Container(
//                                       padding: EdgeInsets.all(2),
//                                       decoration: BoxDecoration(
//                                           color: data.status ==
//                                                   TransactionStatus.paid
//                                               ? KColor.green
//                                               : data.status ==
//                                                       TransactionStatus
//                                                           .initiated
//                                                   ? KColor.pending
//                                                   : data.status ==
//                                                           TransactionStatus
//                                                               .failed
//                                                       ? KColor.red
//                                                       : Colors.transparent,
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: TextWidget(
//                                         text: data.statusDesp!,
//                                         fontWeight: 600,
//                                         fontSize: 8,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               expandedCrossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Divider(),
//                                 ListTile(
//                                   title: TextWidget(
//                                     text: "Total fee",
//                                     fontSize: 11,
//                                     fontWeight: 400,
//                                   ),
//                                   trailing: TextWidget(
//                                     text: KSymbol.inr + data.extraFee!.fee!,
//                                     fontSize: 11,
//                                     fontWeight: 400,
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: TextWidget(
//                                     text: "Extra fee",
//                                     fontSize: 11,
//                                     fontWeight: 400,
//                                   ),
//                                   trailing: TextWidget(
//                                     text: KSymbol.inr + data.extraFee!.fine!,
//                                     fontSize: 11,
//                                     fontWeight: 400,
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: TextWidget(
//                                     text: "Discount",
//                                     fontSize: 11,
//                                     fontWeight: 400,
//                                   ),
//                                   trailing: TextWidget(
//                                     text: KSymbol.inr +
//                                         data.extraFee!.disc!.toString(),
//                                     fontSize: 11,
//                                     fontWeight: 400,
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: TextWidget(
//                                     text: "Total Fee",
//                                     fontSize: 12,
//                                     fontWeight: 700,
//                                   ),
//                                   trailing: TextWidget(
//                                     text: KSymbol.inr +
//                                         data.extraFee!.pay.toString(),
//                                     fontSize: 12,
//                                     fontWeight: 700,
//                                   ),
//                                 ),
//                                 Gap(20),
//                                 // pay
//                                 if (data.feeExempted == "0" &&
//                                     data.status == TransactionStatus.upPaid)
//                                   ButtonWidget(
//                                     text: "Pay",
//                                     onTap: () async {
//                                       CreateFeeModel response = await apiRepo
//                                           .createFeePayment(
//                                               feeType: FeeType.hostel,
//                                               feeID: data.feeId!)
//                                           .then((value) {
//                                         if (value.success == true &&
//                                             value.data!.atomTokenId != null) {
//                                           openPay(
//                                               value.data!.atomTokenId
//                                                   .toString(),
//                                               value.data!.merchId.toString(),
//                                               value.data!.custEmail.toString(),
//                                               value.data!.custMobile.toString(),
//                                               value.data!.returnUrl.toString());
//                                         } else {
//                                           TopSnackBar.showError(context,
//                                               "Unable to make payment, try again later");
//                                         }
//                                         return value;
//                                       });
//                                       print(response.data!.atomTokenId);
//                                     },
//                                     color: KColor.appColor,
//                                     fullWidth: true,
//                                   ),
//
//                                 //if transaction failed
//                                 if (data.status == TransactionStatus.failed)
//                                   ButtonWidget(
//                                     text: "Pay",
//                                     onTap: () async {
//                                       CreateFeeModel response = await apiRepo
//                                           .createRetryFeePayment(
//                                               feeType: FeeType.tuition,
//                                               feeID: data.id!)
//                                           .then((value) {
//                                         if (value.success == true &&
//                                             value.data!.atomTokenId != null) {
//                                           openPay(
//                                               value.data!.atomTokenId
//                                                   .toString(),
//                                               value.data!.merchId.toString(),
//                                               value.data!.custEmail.toString(),
//                                               value.data!.custMobile.toString(),
//                                               value.data!.returnUrl.toString());
//                                         } else {
//                                           TopSnackBar.showError(context,
//                                               "Unable to make payment, try again later");
//                                         }
//                                         return value;
//                                       });
//                                       print(response.data!.atomTokenId);
//                                     },
//                                     color: KColor.appColor,
//                                     fullWidth: true,
//                                   ),
//
//                                 if (data.feeExempted == "1")
//                                   ButtonWidget(
//                                     text: "Download receipt",
//                                     onTap: () {
//                                       downloadFile(data.receiptNo!,
//                                           fileName: 'receipt.pdf');
//                                     },
//                                     color: KColor.appColor,
//                                     fullWidth: true,
//                                   ),
//                                 if (data.status == TransactionStatus.paid)
//                                   ButtonWidget(
//                                     text: "Download receipt",
//                                     onTap: () {
//                                       downloadFile(data.receiptNo!,
//                                           fileName: 'receipt.pdf');
//                                     },
//                                     color: KColor.appColor,
//                                     fullWidth: true,
//                                   )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           );
//         }
//         if (state is FeeHostelEmpty) {
//           return Center(
//             child: TextWidget(text: "No data to show"),
//           );
//         }
//         if (state is FeeHostelError) {
//           return Center(
//             child: Icon(Icons.error),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }
