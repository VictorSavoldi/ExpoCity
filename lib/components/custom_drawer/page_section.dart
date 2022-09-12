import 'package:expocity/components/custom_drawer/page_tile.dart';
import 'package:expocity/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../stores/page_store.dart';
import '../../stores/user_manager_store.dart';

class PageSection extends StatelessWidget {
  PageSection({Key? key}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context) {
    Future<void> verifyLoginAndSetPage(int page) async {
      if (userManagerStore.isLoggedin) {
        pageStore.setPage(page);
      } else {
        final result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));

        if (result != null && result) {
          pageStore.setPage(page);
        }
      }
    }

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
        userManagerStore.isUserAdmin
            ? PageTile(
                label: 'Manifestações Pendentes',
                iconData: Icons.info,
                onTap: () {
                  verifyLoginAndSetPage(1);
                },
                highlighted: pageStore.page == 1,
              )
            : Container(),
        PageTile(
          label: 'Cadastrar Manifestação',
          iconData: Icons.edit,
          onTap: () {
            verifyLoginAndSetPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite,
          onTap: () {
            verifyLoginAndSetPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: () {
            verifyLoginAndSetPage(4);
          },
          highlighted: pageStore.page == 4,
        ),
        userManagerStore.isLoggedin
            ? PageTile(
                label: 'Sair',
                iconData: Icons.exit_to_app,
                onTap: () {
                  verifyLoginAndSetPage(0);
                  userManagerStore.logout();
                  Navigator.of(context).pop();
                },
                highlighted: false,
              )
            : Container(),
      ],
    );
  }
}
