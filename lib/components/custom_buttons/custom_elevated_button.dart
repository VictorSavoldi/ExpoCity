import 'package:flutter/material.dart';

import '../colors.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.containerActionButton,
      required this.edgeInsets})
      : super(key: key);

  Future<void> Function()? onPressed;
  Container containerActionButton;
  EdgeInsets edgeInsets;

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
              gradient: defaultGradientColor,
              borderRadius: BorderRadius.circular(20)),
          child: containerActionButton,
        ),
      ),
    );
  }
}
