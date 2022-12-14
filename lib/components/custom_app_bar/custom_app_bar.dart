import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      required this.title,
      this.actions,
      this.elevation,
      this.automaticallyImplyLeading})
      : super(key: key);

  final dynamic title;
  final List<Widget>? actions;
  final double? elevation;
  final bool? automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return NewGradientAppBar(
      title: title,
      centerTitle: true,
      gradient: defaultGradientColor,
      actions: actions,
      elevation: elevation ?? 3,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
