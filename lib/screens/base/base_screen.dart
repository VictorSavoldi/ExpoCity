import 'package:expocity/screens/account/account_screen.dart';
import 'package:expocity/screens/create/create_screen.dart';
import 'package:expocity/screens/pending/pending_screen.dart';
import 'package:expocity/stores/connectivity_store.dart';
import 'package:expocity/stores/page_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../home/home_screen.dart';
import '../offline/offline_screen.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction(
        (_) => pageStore.page, (int page) => pageController.jumpToPage(page));

    autorun((_) {
      if (!connectivityStore.connected) {
        Future.delayed(const Duration(milliseconds: 50)).then((value) {
          showDialog(context: context, builder: (_) => const OfflineScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            PendingScreen(),
            const CreateScreen(),
            AccountScreen(),
          ],
        ),
      ),
    );
  }
}
