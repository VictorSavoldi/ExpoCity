import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_drawer/page_section.dart';
import 'package:flutter/material.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(right: Radius.circular(40)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          backgroundColor: backgoundColor,
          child: ListView(
            children: [
              CustomDrawerHeader(),
              PageSection(),
            ],
          ),
        ),
      ),
    );
  }
}
