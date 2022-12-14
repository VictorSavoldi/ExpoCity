import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/stores/mymanifestations_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/active_tile.dart';
import 'components/pending_tile.dart';
import 'components/resolved_tile.dart';

class MymanifestationsScreen extends StatefulWidget {
  MymanifestationsScreen({Key? key, this.indexController = 1}) : super(key: key);

  int indexController;

  @override
  State<MymanifestationsScreen> createState() => _MymanifestationsScreenState();
}

class _MymanifestationsScreenState extends State<MymanifestationsScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;

  final MymanifestationsStore store = MymanifestationsStore();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController!.index = widget.indexController;
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
              labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              controller: tabController,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(child: Text('Pendentes')),
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
                  if (store.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(defaultColor),
                      ),
                    );
                  }
                  if (store.pendingManifestations.isEmpty && !store.loading) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.list_alt,
                            color: defaultColor,
                            size: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Você não possui manifestações pendentes!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: defaultColor, fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: store.pendingManifestations.length,
                      itemBuilder: (_, index) {
                        return PendingTile(manifestation: store.pendingManifestations[index], store: store);
                      });
                }),
                Observer(builder: (_) {
                  if (store.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(defaultColor),
                      ),
                    );
                  }
                  if (store.activeManifestations.isEmpty && !store.loading) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.list_alt,
                            color: defaultColor,
                            size: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Você não possui manifestações ativas!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: defaultColor, fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: store.activeManifestations.length,
                      itemBuilder: (_, index) {
                        return ActiveTile(manifestation: store.activeManifestations[index], store: store);
                      });
                }),
                Observer(builder: (_) {
                  if (store.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(defaultColor),
                      ),
                    );
                  }
                  if (store.resolvedManifestations.isEmpty && !store.loading) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.list_alt,
                            color: defaultColor,
                            size: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Você não possui manifestações resolvidas!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: defaultColor, fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: store.resolvedManifestations.length,
                      itemBuilder: (_, index) {
                        return ResolvedTile(
                          manifestation: store.resolvedManifestations[index],
                          store: store,
                        );
                      });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
