import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../colors/color_constants.dart';
import 'button_style.dart';

class LogoutDialog extends StatelessWidget {
  final BuildContext context;

  const LogoutDialog({super.key, required this.context});

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
              TextWidget(
                  text: "Logout?",
                  tColor: KColor.red,
                  fontWeight: 600,
                  fontSize: 26),
              const SizedBox(height: 15),
              const TextWidget(
                  text: "Do you want to logout?",
                  tColor: KColor.black,
                  textAlign: TextAlign.center,
                  fontWeight: 600,
                  fontSize: 12),
              const SizedBox(height: 22),
              screenWidth <= 280
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 95,
                          height: 37,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: btnStyle(clr: KColor.white),
                            child: TextWidget(
                              text: "Cancel",
                              tColor: KColor.red
                            ),
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: 95,
                          height: 37,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            style: btnStyle(clr: KColor.red),
                            child: const TextWidget(
                              text: "Yes",
                              tColor: KColor.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 95,
                          height: 37,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: btnStyle(clr: KColor.white),
                            child: const TextWidget(
                              text: "Cancel",
                              tColor: KColor.red,
                            ),
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: 95,
                          height: 37,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              //clearStorage(context);
                            },
                            style: btnStyle(clr: KColor.red),
                            child: const TextWidget(
                              text: "Yes",
                              tColor: KColor.white,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }
}
