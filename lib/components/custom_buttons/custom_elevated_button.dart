import 'package:flutter/material.dart';

import '../colors.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.containerActionButton,
    required this.edgeInsets,
    this.exitAccount = false,
  }) : super(key: key);

  Future<void> Function()? onPressed;
  Container containerActionButton;
  EdgeInsets edgeInsets;
  bool exitAccount = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: edgeInsets,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 4,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
              color: exitAccount ? flutterErrorColor : null,
              gradient: exitAccount ? null : defaultGradientColor,
              borderRadius: BorderRadius.circular(20)),
          child: containerActionButton,
        ),
      ),
    );
  }
}
