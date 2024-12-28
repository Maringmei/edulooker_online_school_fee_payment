import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/button_widgets.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/colors/color_constants.dart';
import '../../../../../core/constants/symbols/symbols_constants.dart';
import '../../../../../core/constants/widgets/button_style.dart';
import '../../../../../core/constants/widgets/text_span_widgets.dart';

class PayDetailsDialog extends StatelessWidget {
  final BuildContext context;
  final data;

  const PayDetailsDialog(
      {super.key, required this.context, required this.data});

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
      clipBehavior : Clip.hardEdge,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Gap(10),
              TextRowWidget(
                children: [
                  TextWidget(
                    text: "${data.paymentFor!} ",
                    tColor: KColor.black,
                    fontSize: 15,
                    fontWeight: 700,
                  ),
                  TextWidget(
                    text: data.paymentOf!,
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
                  text: KSymbol.inr + data.extraFee!.fee!,
                ),
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
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
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: TextWidget(
                  text: "Discount",
                ),
                trailing: TextWidget(
                  text: KSymbol.inr + data.extraFee!.disc!.toString(),
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
                  text: KSymbol.inr + data.extraFee!.pay.toString(),
                  fontSize: 12,
                  fontWeight: 700,
                ),
              ),
              Divider(),
              const SizedBox(height: 10),
              TextWidget(
                text: "For a seamless experience, we recommend UPI payment.",
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
          ),
        ),
        Positioned(
            top: -5,
            right: -5,
            child: IconButton(onPressed: (){
              Navigator.pop(context, false);
            }, icon: Icon(Icons.cancel, color: KColor.red,)))
      ],
    );
  }
}
