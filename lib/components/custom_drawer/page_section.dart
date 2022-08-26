import 'package:expocity/components/custom_drawer/page_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../stores/page_store.dart';
import '../../stores/user_manager_store.dart';

class PageSection extends StatelessWidget {
  PageSection({Key? key}) : super(key: key);

  final UserManagerStore store = UserManagerStore();

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Manifestações',
          iconData: Icons.list,
          onTap: () {
            pageStore.setPage(0);
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Cadastrar Manifestação',
          iconData: Icons.edit,
          onTap: () {
            pageStore.setPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: () {
            pageStore.setPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Sair',
          iconData: Icons.logout,
          onTap: () {
            store.logout();
            pageStore.setPage(0);
          },
          highlighted: false,
        ),
      ],
    );
  }
}
