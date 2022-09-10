import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/stores/mymanifestations_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/active_tile.dart';
import 'components/resolved_tile.dart';

class MymanifestationsScreen extends StatefulWidget {
  const MymanifestationsScreen({Key? key}) : super(key: key);

  @override
  State<MymanifestationsScreen> createState() => _MymanifestationsScreenState();
}

class _MymanifestationsScreenState extends State<MymanifestationsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final MymanifestationsStore store = MymanifestationsStore();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Minhas manifestações'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(gradient: defaultGradientColor),
            child: TabBar(
              labelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              controller: tabController,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(child: Text('Ativas')),
                Tab(child: Text('Resolvidas')),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              Observer(builder: (_) {
                if (store.activeManifestations.isEmpty) {
                  return Container();
                }
                return ListView.builder(itemBuilder: (_, index) {
                  return ActiveTile(
                      manifestation: store.activeManifestations[index]);
                });
              }),
              Observer(builder: (_) {
                if (store.resolvedManifestations.isEmpty) {
                  return Container();
                }
                return ListView.builder(itemBuilder: (_, index) {
                  return ResolvedTile(
                      manifestation: store.resolvedManifestations[index]);
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
