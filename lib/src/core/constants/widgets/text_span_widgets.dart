import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  final List children;
  const TextRowWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [...children],
      ),
    );
  }
}
