import 'package:flutter/material.dart';

import '../colors/color_constants.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? tColor;
  final double? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLine;
  final double? lineHeight;

  const TextWidget({
    super.key,
    required this.text,
    this.tColor,
     this.fontWeight,
     this.fontSize,
    this.textAlign,
    this.overflow,
    this.maxLine,
    this.lineHeight
  });

  @override
  Widget build(BuildContext context) {
    FontWeight? _fontWeight;
   if(fontWeight != null){
     if (fontWeight! >= 900) {
       _fontWeight = FontWeight.w900;
     } else if (fontWeight! >= 800) {
       _fontWeight = FontWeight.w800;
     } else if (fontWeight! >= 700) {
       _fontWeight = FontWeight.w700;
     } else if (fontWeight! >= 600) {
       _fontWeight = FontWeight.w600;
     } else if (fontWeight! >= 500) {
       _fontWeight = FontWeight.w500;
     } else if (fontWeight! >= 400) {
       _fontWeight = FontWeight.w400;
     } else if (fontWeight! >= 300) {
       _fontWeight = FontWeight.w300;
     } else if (fontWeight! >= 200) {
       _fontWeight = FontWeight.w200;
     } else if (fontWeight! >= 100) {
       _fontWeight = FontWeight.w100;
     } else {
       _fontWeight = FontWeight.normal;
     }
   }

    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,

      style: TextStyle(
          color: tColor ?? KColor.black,
          fontWeight: _fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 12,
          height: lineHeight,
      ),
    );
  }
}
