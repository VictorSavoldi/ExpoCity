import 'package:expocity/screens/home/components/search_dialog.dart';
import 'package:expocity/screens/home/components/top_bar.dart';
import 'package:expocity/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSerch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (_) => SearchDialog(
        currentSearch: homeStore.search,
      ),
    );

    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: CustomAppBar(
          title: homeStore.search.isEmpty
              ? const Text('Manifestações')
              : GestureDetector(
                  onTap: () => openSerch(context),
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return SizedBox(
                        width: constraints.biggest.width,
                        child: Text(
                          homeStore.search,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
          actions: [
            homeStore.search.isEmpty
                ? IconButton(
                    onPressed: () {
                      openSerch(context);
                    },
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                  )
                : IconButton(
                    onPressed: () {
                      homeStore.setSearch('');
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                  )
          ],
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            TopBar(),
          ],
        ),
      );
    });
  }
}
