import 'package:flutter/material.dart';

import '../colors.dart';

class PageTile extends StatelessWidget {
  const PageTile(
      {Key? key,
      required this.label,
      required this.iconData,
      required this.onTap,
      required this.highlighted})
      : super(key: key);

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: (Border(bottom: BorderSide(color: Colors.black12, width: 2))),
        color: backgoundColor,
      ),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            color: highlighted ? defaultColor : Colors.black,
          ),
        ),
        leading: Icon(
          iconData,
          color: highlighted ? defaultColor : Colors.black,
        ),
        onTap: onTap,
      ),
    );
  }
}
