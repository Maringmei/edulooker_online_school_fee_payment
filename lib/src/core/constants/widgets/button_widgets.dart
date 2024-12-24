import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../colors/color_constants.dart';
import 'button_style.dart';

class ButtonWidget extends StatelessWidget {
  final Function onTap;
  final String text;
  final bool? fullWidth;
  final Color? color;
  final Widget? icon;
  const ButtonWidget(
      {super.key, required this.text, required this.onTap, this.fullWidth, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth == true ? double.infinity : null,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ElevatedButton(
          onPressed: () => onTap(), // Correctly invoking the onTap function
          style: btnStyle(clr: color),
          child: icon != null ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              Gap(5),
              TextWidget(
                text: text,
                tColor: KColor.white,
                maxLine: 1,
              ),
            ],
          ):TextWidget(
            text: text,
            tColor: KColor.white,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}
