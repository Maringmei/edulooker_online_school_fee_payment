import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../colors/color_constants.dart';

class TopTitle extends StatelessWidget {
  final bool? enableBackButton;
  final pageName;
  const TopTitle({super.key, required this.pageName, this.enableBackButton});

  @override
  Widget build(BuildContext context) {
    return enableBackButton == true
        ? Row(
            children: [
              if (enableBackButton == true)
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: KColor.black,
                      size: 20,
                    )),
              // IconButton(onPressed: () {
              //   Navigator.pop(context);
              // }, icon: const Icon(
              //   Icons.arrow_back_ios,
              //   color: KColor.red,
              //   size: 20,
              // )),
              if (enableBackButton == true) const Gap(10),
              TextWidget(text: pageName, fontWeight: 600, fontSize: 24)
            ],
          )
        : TextWidget(text: pageName, fontWeight: 600, fontSize: 24);
  }
}
