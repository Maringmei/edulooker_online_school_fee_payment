import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../colors/color_constants.dart';


class DummyDropdownWidget extends StatelessWidget {
  final String hintText;
  const DummyDropdownWidget({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              // Icon(Icons.home_work_rounded, size: 20),
              // Gap(10),
              Flexible(child: TextWidget(text: hintText,overflow: TextOverflow.ellipsis,tColor: KColor.subText,))
            ],
          ),
          items: []
              .map((item) => DropdownMenuItem(
                  value: item.name, child: TextWidget(text: item.name!)))
              .toList(),
          value: "",
          onChanged: (value) {},
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: KColor.filledColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          dropdownStyleData: const DropdownStyleData(maxHeight: 500, width: 350),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) {}
          },
        ),
      ),
    );
  }
}
