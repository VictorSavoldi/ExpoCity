import 'package:expocity/components/success_box.dart';
import 'package:expocity/stores/edit_account_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/custom_buttons/custom_elevated_button.dart';
import '../../components/error_box.dart';
import '../../stores/page_store.dart';
import '../../stores/user_manager_store.dart';

class EditAccountScreen extends StatelessWidget {
  EditAccountScreen({Key? key, required this.nameAccount}) : super(key: key);

  final String nameAccount;
  final UserManagerStore user = GetIt.I<UserManagerStore>();

  final EditAccountStore store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontWeight: FontWeight.w800, color: Colors.black38, fontSize: 15);

    const contentPadding = EdgeInsets.symmetric(vertical: 18, horizontal: 12);

    return Scaffold(
      appBar: CustomAppBar(title: const Text('Editar Conta')),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(builder: (_) {
                    return ErrorBox(message: store.errorText);
                  }),
                  Observer(builder: (_) {
                    return SuccessBox(message: store.successText);
                  }),
                  !user.isUserFree
                      ? const ErrorBox(message: 'Usuário Bloqueado. Não é possível alterar o nome da conta.')
                      : Container(),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: (store.errorText != '' || store.successText != '' || !user.isUserFree) ? 10 : null,
                    );
                  }),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: labelStyle,
                        border: const OutlineInputBorder(),
                        contentPadding: contentPadding,
                        errorText: store.nameError,
                      ),
                      enabled: !store.loading && user.isUserFree,
                      initialValue: nameAccount,
                      onChanged: store.setName,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    );
                  }),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nova Senha',
                        labelStyle: labelStyle,
                        border: const OutlineInputBorder(),
                        contentPadding: contentPadding,
                        errorText: store.pass1Error,
                      ),
                      enabled: !store.loading,
                      onChanged: store.setPass1,
                      obscureText: true,
                    );
                  }),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirmar Nova Senha',
                        labelStyle: labelStyle,
                        border: const OutlineInputBorder(),
                        contentPadding: contentPadding,
                        errorText: store.pass2Error,
                      ),
                      enabled: !store.loading,
                      onChanged: store.setPass2,
                      obscureText: true,
                    );
                  }),
                  Row(
                    children: [
                      Expanded(
                        child: Observer(builder: (_) {
                          return IgnorePointer(
                            ignoring: store.loading,
                            child: CustomElevatedButton(
                              exitAccount: true,
                              edgeInsets: const EdgeInsets.only(top: 20),
                              onPressed: () async {
                                store.logout();
                                GetIt.I<PageStore>().setPage(0);
                                Navigator.of(context).pop();
                              },
                              containerActionButton: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Sair',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Observer(builder: (_) {
                          return CustomElevatedButton(
                            edgeInsets: const EdgeInsets.only(top: 20),
                            onPressed: store.savePressed,
                            containerActionButton: Container(
                              alignment: Alignment.center,
                              child: store.loading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Text(
                                      'Salvar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
