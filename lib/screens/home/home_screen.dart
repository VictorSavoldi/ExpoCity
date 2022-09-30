import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/home/components/manifestation_tile.dart';
import 'package:expocity/screens/home/components/search_dialog.dart';
import 'package:expocity/screens/home/components/top_bar.dart';
import 'package:expocity/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/custom_drawer/custom_drawer.dart';
import '../../stores/user_manager_store.dart';
import '../manifestation/manifestation_screen.dart';
import 'components/create_manifestation_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    homeStore.resetPage();
  }

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
            Expanded(
              child: Stack(
                children: [
                  Observer(builder: (_) {
                    if (homeStore.errorText != '') {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.error,
                              color: defaultColor,
                              size: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Ocorreu um erro!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: defaultColor, fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      );
                    }
                    if (homeStore.showProgress) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(defaultColor),
                        ),
                      );
                    }
                    if (homeStore.manifestationList.isEmpty) {
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
                              'Nenhuma manifestação encontrada!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: defaultColor, fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: homeStore.itemCount,
                          itemBuilder: (_, index) {
                            if (index < homeStore.manifestationList.length) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (_) =>
                                              ManifestationScreen(manifestation: homeStore.manifestationList[index])))
                                      .then((_) {
                                    homeStore.resetPage();
                                    setState(() {});
                                  });
                                },
                                child: ManifestationTile(manifestation: homeStore.manifestationList[index]),
                              );
                            }
                            homeStore.loadNextPage();
                            return const SizedBox(
                              height: 10,
                              child: LinearProgressIndicator(
                                backgroundColor: backgroundColor,
                                valueColor: AlwaysStoppedAnimation(defaultColor),
                              ),
                            );
                          }),
                    );
                  }),
                  userManagerStore.isLoggedin
                      ? Positioned(
                          bottom: -50,
                          left: 0,
                          right: 0,
                          child: CreateManifestationButton(scrollController: scrollController),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
