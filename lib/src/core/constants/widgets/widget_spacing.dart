import 'package:flutter/material.dart';

class WidgetSpacing extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final Widget child;
  final bool isPadding;

  const WidgetSpacing.padding(
      {super.key,
      this.top,
      this.bottom,
      this.right,
      this.left,
      required this.child})
      : isPadding = true;

  const WidgetSpacing.margin(
      {super.key,
      this.top,
      this.bottom,
      this.right,
      this.left,
      required this.child})
      : isPadding = false;

  // Make these final to ensure immutability
  final double _padding = 20;
  final double _margin = 10;

  @override
  Widget build(BuildContext context) {
    return isPadding
        ? Padding(
            padding: EdgeInsets.only(
                top: top ?? _padding,
                bottom: bottom ?? _padding,
                right: right ?? _padding,
                left: left ?? _padding),
            child: child,
          )
        : Container(
            margin: EdgeInsets.only(
                top: top ?? _margin,
                bottom: bottom ?? _margin,
                right: right ?? _margin,
                left: left ?? _margin),
            child: child,
          );
  }
}
