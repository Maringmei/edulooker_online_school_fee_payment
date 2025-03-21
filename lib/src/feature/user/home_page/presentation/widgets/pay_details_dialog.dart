import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/loading_shimmer.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/symbols/symbols_constants.dart';
import '../../../../../core/constants/widgets/button_style.dart';
import '../../../../../core/constants/widgets/text_span_widgets.dart';
import '../../data/repositories/fee_total_multiple_repo.dart';
import '../manager/bloc/total_fee_cubit/total_fee_cubit.dart';

class PayDetailsDialog extends StatelessWidget {
  final BuildContext context;

  PayDetailsDialog({super.key, required this.context});

  FeeTotalMultipleRepo apiRepo = FeeTotalMultipleRepo();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: BlocBuilder<TotalFeeCubit, TotalFeeState>(
            builder: (context, state) {
              if (state is TotalFeeInitial) {
                return LoadingWidget(
                  count: 1,
                );
              }
              if (state is TotalFeeLoaded) {
                return LoadingWidget(
                  count: 1,
                );
              }
              if (state is TotalFeeLoaded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Gap(10),
                    TextRowWidget(
                      children: [
                        TextWidget(
                          text: " ",
                          tColor: KColor.black,
                          fontSize: 15,
                          fontWeight: 700,
                        ),
                        TextWidget(
                          text: "",
                          tColor: KColor.black,
                          fontSize: 15,
                          fontWeight: 700,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Divider(),
                    // ListTile(
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: TextWidget(
                        text: "Total fee",
                      ),
                      trailing: TextWidget(
                        text: KSymbol.inr + state.response.data!.totalFee.toString(),
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: TextWidget(
                        text: "Fine",
                      ),
                      trailing: TextWidget(
                        text: KSymbol.inr + state.response.data!.fine.toString(),
                        fontSize: 11,
                        fontWeight: 400,
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: TextWidget(
                        text: "Discount",
                      ),
                      trailing: TextWidget(
                        text: KSymbol.inr + state.response.data!.discount.toString(),

                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: TextWidget(
                        text: "Total Fee",
                        fontSize: 12,
                        fontWeight: 700,
                      ),
                      trailing: TextWidget(
                        text: KSymbol.inr +  state.response.data!.payable.toString(),
                        fontSize: 12,
                        fontWeight: 700,
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    TextWidget(
                      text:
                          "For a seamless experience, we recommend UPI payment.",
                      textAlign: TextAlign.center,
                      tColor: KColor.black,
                      fontWeight: 900,
                    ),
                    const SizedBox(height: 22),
                    ButtonWidget(
                      text: "Confirm",
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      fullWidth: true,
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        Positioned(
            top: -5,
            right: -5,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                icon: Icon(
                  Icons.cancel,
                  color: KColor.red,
                )))
      ],
    );
  }
}
