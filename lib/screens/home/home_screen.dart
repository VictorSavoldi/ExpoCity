import 'package:flutter/material.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Manifestações'),
      drawer: const CustomDrawer(),
    );
  }
}
