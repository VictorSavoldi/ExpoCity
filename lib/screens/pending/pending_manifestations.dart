import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/stores/pending_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/custom_drawer/custom_drawer.dart';
import 'components/pending_manifestations_tile.dart';

class PendingManifestations extends StatelessWidget {
  PendingManifestations({Key? key}) : super(key: key);

  final PendingStore store = PendingStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Manifestações Pendentes')),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Observer(builder: (_) {
              if (store.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(defaultColor),
                  ),
                );
              }
              if (store.allManifestations.isEmpty && !store.loading) {
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
                        style: TextStyle(
                            color: defaultColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemCount: store.allManifestations.length,
                  itemBuilder: (_, index) {
                    return PendingManifestationsTile(
                        manifestation: store.allManifestations[index]);
                  });
            }),
          ),
        ],
      ),
    );
  }
}
