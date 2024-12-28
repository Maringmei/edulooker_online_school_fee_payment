import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_snack_bar.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/create_fee_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/create_fee_payment_repo.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/fee_type.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/widgets/pay_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/images/images_constants.dart';
import '../../../../../core/constants/symbols/symbols_constants.dart';
import '../../../../../core/constants/widgets/loading_shimmer.dart';
import '../../../../../core/constants/widgets/text_span_widgets.dart';
import '../../../../../core/constants/widgets/text_widgets.dart';
import '../../../../../core/services/js_services.dart';
import '../../../../../core/storage/storage.dart';
import '../../../../../core/utils/download_file.dart';
import '../../data/models/fee_details_model.dart';
import '../manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import '../manager/transaction_status.dart';

class TuitionFeeWidget extends StatelessWidget {
  TuitionFeeWidget({super.key});

  CreateFeePaymentRepo apiRepo = CreateFeePaymentRepo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeeDetailsCubit, FeeDetailsState>(
      builder: (context, state) {
        if (state is FeeDetailsInitial) {
          return LoadingWidget(
            count: 3,
          );
        }
        if (state is FeeDetailsLoaded) {
          return RefreshIndicator(
            onRefresh: () =>
                BlocProvider.of<FeeDetailsCubit>(context).getFeeDetails(),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.data!.length,
                itemBuilder: (context, index) {
                  FeeData data = state.response.data![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: KColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextRowWidget(
                              children: [
                                TextWidget(
                                  text: "${data.paymentFor!} ",
                                  tColor: KColor.subText,
                                ),
                                TextWidget(
                                  text: data.paymentOf!,
                                  tColor: KColor.subText,
                                ),
                              ],
                            ),
                            TextWidget(
                              text: data.receivedDate!.isNotEmpty
                                  ? data.receivedDate!
                                  : "",
                              tColor: KColor.subText,
                            ),
                          ],
                        ),
                        /*********************************************************** Unpaid ******************/
                        if (data.status != TransactionStatus.upPaid)
                          Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                              horizontalTitleGap: 0.0,
                              minLeadingWidth: 0,
                              child: ExpansionTile(
                                childrenPadding: EdgeInsets.zero,
                                dense: true,
                                title: Row(
                                  children: [
                                    TextWidget(
                                      text:
                                          data.status == TransactionStatus.paid
                                              ? KSymbol.inr +
                                                  data.recievedAmount.toString()
                                              : KSymbol.inr +
                                                  data.extraFee!.pay.toString(),
                                      fontWeight: 600,
                                      fontSize: 18,
                                    ),
                                    Gap(10),
                                    if (data.status !=
                                            TransactionStatus.deleted &&
                                        data.status != TransactionStatus.upPaid)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: data.status ==
                                                    TransactionStatus.paid
                                                ? KColor.green
                                                : data.status ==
                                                        TransactionStatus
                                                            .initiated
                                                    ? KColor.pending
                                                    : data.status ==
                                                            TransactionStatus
                                                                .failed
                                                        ? KColor.red
                                                        : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextWidget(
                                          text: data.statusDesp!,
                                          fontWeight: 600,
                                          fontSize: 10,
                                          tColor: KColor.white,
                                        ),
                                      ),
                                  ],
                                ),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  ListTile(
                                    title: TextWidget(
                                      text: "Total fee",
                                    ),
                                    trailing: TextWidget(
                                      text: KSymbol.inr + data.extraFee!.fee!,
                                    ),
                                  ),
                                  ListTile(
                                    title: TextWidget(
                                      text: "Extra fee",
                                    ),
                                    trailing: TextWidget(
                                      text: KSymbol.inr + data.extraFee!.fine!,
                                      fontSize: 11,
                                      fontWeight: 400,
                                    ),
                                  ),
                                  ListTile(
                                    title: TextWidget(
                                      text: "Discount",
                                    ),
                                    trailing: TextWidget(
                                      text: KSymbol.inr +
                                          data.extraFee!.disc!.toString(),
                                    ),
                                  ),
                                  ListTile(
                                    title: TextWidget(
                                      text: "Total Fee",
                                      fontSize: 12,
                                      fontWeight: 700,
                                    ),
                                    trailing: TextWidget(
                                      text: KSymbol.inr +
                                          data.extraFee!.pay.toString(),
                                      fontSize: 12,
                                      fontWeight: 700,
                                    ),
                                  ),
                                  Gap(20),
                                  if (data.feeExempted == "0" &&
                                      data.status == TransactionStatus.upPaid)
                                    ButtonWidget(
                                      text: "Pay",
                                      onTap: () async {
                                        CreateFeeModel response = await apiRepo
                                            .createFeePayment(
                                                feeType: FeeType.tuition,
                                                feeID: data.feeId!)
                                            .then((value) {
                                          if (value.success == true &&
                                              value.data!.atomTokenId != null) {
                                            openPay(
                                              value.data!.atomTokenId
                                                  .toString(),
                                              value.data!.merchId.toString(),
                                              value.data!.custEmail.toString(),
                                              value.data!.custMobile.toString(),
                                              value.data!.returnUrl.toString(),
                                              value.data!.mode.toString(),
                                            );
                                          } else {
                                            TopSnackBar.showError(context,
                                                "Unable to make payment, try again later");
                                          }
                                          return value;
                                        });
                                        //print(response.data!.atomTokenId);
                                      },
                                      color: KColor.appColor,
                                      fullWidth: true,
                                    ),
                                  //if transaction failed
                                  if (data.status == TransactionStatus.failed)
                                    ButtonWidget(
                                      text: "Pay",
                                      onTap: () async {
                                        CreateFeeModel response = await apiRepo
                                            .createRetryFeePayment(
                                                feeType: FeeType.tuition,
                                                feeID: data.feeId!)
                                            .then((value) {
                                          if (value.success == true &&
                                              value.data!.atomTokenId != null) {
                                            openPay(
                                              value.data!.atomTokenId
                                                  .toString(),
                                              value.data!.merchId.toString(),
                                              value.data!.custEmail.toString(),
                                              value.data!.custMobile.toString(),
                                              value.data!.returnUrl.toString(),
                                              value.data!.mode.toString(),
                                            );
                                          } else {
                                            TopSnackBar.showError(context,
                                                "Unable to make payment, try again later");
                                          }
                                          return value;
                                        });
                                        // print(response.data!.atomTokenId);
                                      },
                                      color: KColor.appColor,
                                      fullWidth: true,
                                    ),
                                  // if fee exampted 1 = TRUE
                                  if (data.feeExempted == "1")
                                    ButtonWidget(
                                      text: "Download receipt",
                                      onTap: () async {
                                        // downloadFile(data.receiptNo!,
                                        //     fileName: 'receipt.pdf');
                                        String? token = await Store.getToken()
                                            .then((value) {
                                          if (value != null) {
                                            downloadFile(data.receiptNo!,
                                                fileName: 'receipt.pdf',
                                                bearerToken: value.toString());
                                          }
                                          return null;
                                        });
                                      },
                                      color: KColor.appColor,
                                      fullWidth: true,
                                      icon: Icon(
                                        Icons.download,
                                        color: KColor.white,
                                      ),
                                    ),
                                  if (data.status == TransactionStatus.paid)
                                    ButtonWidget(
                                      text: "Download receipt",
                                      onTap: () async {
                                        String? token = await Store.getToken()
                                            .then((value) {
                                          if (value != null) {
                                            downloadFile(data.receiptNo!,
                                                fileName: 'receipt.pdf',
                                                bearerToken: value.toString());
                                          }
                                          return null;
                                        });
                                      },
                                      color: KColor.appColor,
                                      fullWidth: true,
                                      icon: Icon(
                                        Icons.download,
                                        color: KColor.white,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),

                        /*********************************************************** PAY ******************/
                        if (data.status == TransactionStatus.upPaid) Gap(10),
                        if (data.status == TransactionStatus.upPaid)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: data.status == TransactionStatus.paid
                                    ? KSymbol.inr +
                                        data.recievedAmount.toString()
                                    : KSymbol.inr +
                                        data.extraFee!.pay.toString(),
                                fontWeight: 600,
                                fontSize: 18,
                              ),
                              Gap(10),
                              ButtonWidget(
                                text: "Pay",
                                onTap: () async {
                                  bool? response = await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PayDetailsDialog(
                                          context: context,
                                          data: data,
                                        );
                                      }).then((value) async {
                                    if (value) {
                                      CreateFeeModel response = await apiRepo
                                          .createFeePayment(
                                              feeType: FeeType.tuition,
                                              feeID: data.feeId!)
                                          .then((value) {
                                        if (value.success == true &&
                                            value.data!.atomTokenId != null) {
                                          openPay(
                                            value.data!.atomTokenId.toString(),
                                            value.data!.merchId.toString(),
                                            value.data!.custEmail.toString(),
                                            value.data!.custMobile.toString(),
                                            value.data!.returnUrl.toString(),
                                            value.data!.mode.toString(),
                                          );
                                        } else {
                                          TopSnackBar.showError(context,
                                              "Unable to make payment, try again later");
                                        }
                                        return value;
                                      });
                                      // print(response.data!.atomTokenId);
                                    }
                                    return value;
                                  });
                                },
                                height: 30,
                              )
                            ],
                          ),
                        if (data.status == TransactionStatus.upPaid) Gap(10),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  KImage.notFound,
                  width: 50,
                  height: 50,
                ),
                Gap(10),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<FeeDetailsCubit>(context).getFeeDetails();
                    },
                    child: TextWidget(text: "Retry"))
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
