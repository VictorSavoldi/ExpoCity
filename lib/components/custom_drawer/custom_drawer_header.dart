import 'package:expocity/stores/page_store.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../screens/login/login_screen.dart';
import '../colors.dart';

class CustomDrawerHeader extends StatelessWidget {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        if (userManagerStore.isLoggedin) {
          GetIt.I<PageStore>().setPage(2);
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: defaultGradientColor,
        ),
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userManagerStore.isLoggedin
                        ? userManagerStore.user!.name
                        : 'Acessar conta',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userManagerStore.isLoggedin
                        ? userManagerStore.user!.email
                        : 'Clique aqui',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
