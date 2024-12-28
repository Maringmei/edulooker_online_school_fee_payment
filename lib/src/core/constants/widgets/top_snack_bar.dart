import 'package:flashy_flushbar/flashy_flushbar_widget.dart';
import 'package:flutter/material.dart';

import '../colors/color_constants.dart';


class TopSnackBar {
  static showSuccess(context, msg) {
    FlashyFlushbar(
      backgroundColor: KColor.green,
      leadingWidget: const Icon(
        Icons.check,
        color: Colors.white,
        size: 24,
      ),
      message: msg,
      duration: const Duration(seconds: 2),
      animationDuration: Duration(milliseconds: 100),
      messageStyle: TextStyle(color: KColor.white),
      trailingWidget: IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          FlashyFlushbar.cancel();
        },
      ),
      isDismissible: false,
    ).show();
  }

  static showError(context, msg) {
    FlashyFlushbar(
      backgroundColor: KColor.red,
      leadingWidget: const Icon(
        Icons.error,
        color: Colors.white,
        size: 24,
      ),
      message: msg,
      duration: const Duration(seconds: 1),
      messageStyle: TextStyle(color: KColor.white),
      trailingWidget: IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          FlashyFlushbar.cancel();
        },
      ),
      isDismissible: false,
    ).show();
  }
}
