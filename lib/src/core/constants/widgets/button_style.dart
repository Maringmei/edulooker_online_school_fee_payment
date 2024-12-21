import 'package:flutter/material.dart';

import '../colors/color_constants.dart';


ButtonStyle? btnStyle({Color? clr}) {
  return ElevatedButton.styleFrom(
    backgroundColor: clr ?? KColor.btnColor,
    fixedSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      // side: BorderSide(
      //     color: clr == null ? KColor.white : KColor.redLevel1,
      //     width: 2), // Custom border side
    ),
  );
}