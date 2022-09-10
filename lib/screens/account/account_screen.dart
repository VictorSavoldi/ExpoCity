import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/components/custom_drawer/custom_drawer.dart';
import 'package:expocity/screens/mymanifestations/mymanifestations_screen.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Minha Conta')),
      drawer: const CustomDrawer(),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 110,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              GetIt.I<UserManagerStore>().user!.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: defaultColor,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              GetIt.I<UserManagerStore>().user!.email,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Editar',
                                style: TextStyle(
                                    color: defaultColor, fontSize: 17),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.grey[500]),
                ListTile(
                  title: const Text(
                    'Minhas manifestações',
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: defaultColor,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => MymanifestationsScreen()));
                  },
                ),
                ListTile(
                  title: const Text(
                    'Favoritos',
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: defaultColor,
                  ),
                  onTap: () {},
                ),
                GetIt.I<UserManagerStore>().isUserAdmin
                    ? ListTile(
                        title: const Text(
                          'Teste',
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          color: defaultColor,
                        ),
                        onTap: () {},
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
