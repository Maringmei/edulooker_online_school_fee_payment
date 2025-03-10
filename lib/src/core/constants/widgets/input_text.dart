import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../colors/color_constants.dart';

class InputText extends StatelessWidget {
  final bool? isEmail;
  final bool? isNumber;
  final bool? isPhoneNumber;
  final bool? isDate;
  final String hint;
  final TextEditingController? controller;
  final String? initValue;
  final ValueChanged<String>? onChanged;
  final bool? validation;
  final Color? fillColor;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final String? counterText;
  final Function? onSubmit;
  final double? paddingHeight;
  final bool? multiline;
  final int? maxCharacter;

  const InputText(
      {Key? key,
      this.isEmail,
      this.isNumber,
      this.isPhoneNumber,
      this.isDate,
      required this.hint,
      this.controller,
      this.initValue,
      this.onChanged,
      this.validation,
      this.fillColor,
      this.suffixWidget,
      this.prefixWidget,
      this.counterText,
      this.paddingHeight,
      this.multiline,
      this.onSubmit,
      this.maxCharacter})
      : super(key: key);

  bool isValidDate(String dateStr) {
    RegExp dateRegExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');

    if (!dateRegExp.hasMatch(dateStr)) {
      return false;
    }

    try {
      DateFormat format = DateFormat("dd/MM/yyyy");
      format.parseStrict(dateStr);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initValue,
      maxLines: multiline == true ? null : 1,
      expands: multiline == true ? true : false,
      maxLength: maxCharacter,
      keyboardType: multiline == true
          ? TextInputType.multiline
          : isEmail == true
              ? TextInputType.emailAddress
              : isNumber == true
                  ? TextInputType.number
                  : TextInputType.text,
      inputFormatters: isNumber == true
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              if (isPhoneNumber == true) LengthLimitingTextInputFormatter(10),
            ]
          : null,
      decoration: InputDecoration(
        suffixIcon: suffixWidget != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: suffixWidget,
                ),
              )
            : null,

        prefixIcon: prefixWidget != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: prefixWidget,
                ),
              )
            : null,
        filled: true,
        fillColor: fillColor ?? KColor.filledColor,
        hintText: hint,
        hintStyle: const TextStyle(
            color: KColor.subText, fontSize: 12, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        counterText: counterText,
        // contentPadding: EdgeInsets.symmetric(
        //   vertical: paddingHeight ?? 20,
        //   horizontal: 16,
        // ),
        counterStyle: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.normal,
          color: KColor.red,
        ),
      ),
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      autovalidateMode: AutovalidateMode.disabled,
      onFieldSubmitted: onSubmit == null
          ? null
          : (value) {
              onSubmit!();
            },
      validator: validation == null
          ? null
          : (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${hint.toLowerCase()}';
              }
              if (isEmail == true) {
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
              }
              if (isDate == true) {
                if (!isValidDate(value)) {
                  return 'Please enter a valid date(e.g 23/09/2029)';
                }
              } else if (isNumber == true && isPhoneNumber == true) {
                if (value.length != 10) {
                  return 'Please enter a valid 10-digit phone number';
                }
              } else if (isNumber == true) {
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter a valid number';
                }
              }
              return null;
            },
      onChanged: onChanged,
    );
  }
}
