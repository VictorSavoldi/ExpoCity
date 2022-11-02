import 'package:expocity/models/manifestation.dart';
import 'package:expocity/models/user.dart';
import 'package:expocity/stores/pending_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/colors.dart';
import '../../../components/custom_buttons/custom_elevated_button.dart';
import '../../../repositories/user_repository.dart';
import '../manifestation_screen.dart';

class PendingButtons extends StatelessWidget {
  PendingButtons({Key? key, required this.manifestation}) : super(key: key);

  final Manifestation manifestation;
  final PendingStore store = PendingStore();

  @override
  Widget build(BuildContext context) {
    return manifestation.user.userType == UserType.COMUM
        ? Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  edgeInsets: const EdgeInsets.symmetric(vertical: 5),
                  exitAccount: true,
                  onPressed: () => _deletedManifestation(context: context),
                  containerActionButton: Container(
                    alignment: Alignment.center,
                    child: const Text('DELETAR'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomElevatedButton(
                  edgeInsets: const EdgeInsets.symmetric(vertical: 5),
                  onPressed: () => _activeManifestation(context: context),
                  containerActionButton: Container(
                    alignment: Alignment.center,
                    child: const Text('APROVAR'),
                  ),
                ),
              ),
            ],
          )
        : CustomElevatedButton(
            edgeInsets: const EdgeInsets.symmetric(vertical: 5),
            onPressed: () => _activeManifestation(context: context),
            containerActionButton: Container(
              alignment: Alignment.center,
              child: const Text('APROVAR'),
            ),
          );
  }

  Future<void> _activeManifestation({required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (_) => Observer(builder: (_) {
        return AlertDialog(
          elevation: 8,
          title: !store.loading
              ? const Text('Manifestação Ativa')
              : const Text(
                  'Alterando Status',
                  textAlign: TextAlign.center,
                ),
          content: !store.loading
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Alterar o status da manifestação: "${manifestation.title}" para ativa?',
                    style: const TextStyle(fontSize: 17),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(defaultColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          actions: [
            !store.loading
                ? TextButton(
                    onPressed: !store.loading ? Navigator.of(context).pop : null,
                    child: const Text(
                      'Não',
                      style: TextStyle(color: defaultColor, fontSize: 17),
                    ),
                  )
                : Container(),
            !store.loading
                ? TextButton(
                    onPressed: !store.loading
                        ? () async {
                            await store.activeManifestation(manifestation: manifestation);
                            Navigator.of(context).pop();
                            manifestation.status = ManifestationStatus.ACTIVE;
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => ManifestationScreen(manifestation: manifestation)));
                          }
                        : null,
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: errorColor, fontSize: 17),
                    ))
                : Container(),
          ],
        );
      }),
    );
  }

  Future<void> _deletedManifestation({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              elevation: 8,
              title: const Text('Deletar Manifestação'),
              content: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Você realmente deseja deletar a manifestação "${manifestation.title}"?',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text(
                    'Não',
                    style: TextStyle(color: defaultColor, fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (_) => Observer(builder: (_) {
                        return AlertDialog(
                          elevation: 8,
                          title: !store.loading
                              ? const Text('Bloquear Usuário')
                              : const Text(
                                  'Realizando Alterações',
                                  textAlign: TextAlign.center,
                                ),
                          content: !store.loading
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: manifestation.hidName
                                      ? Text(
                                          'Deseja bloquear o usuário que cadastrou a manifestação"?',
                                          style: const TextStyle(fontSize: 17),
                                        )
                                      : Text(
                                          'Deseja bloquear o usuário "${manifestation.user.name}"?',
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(defaultColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                          actions: [
                            !store.loading
                                ? TextButton(
                                    onPressed: !store.loading ? Navigator.of(context).pop : null,
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(color: defaultColor, fontSize: 17),
                                    ),
                                  )
                                : Container(),
                            !store.loading
                                ? TextButton(
                                    onPressed: !store.loading
                                        ? () async {
                                            await store.deleteManifestation(manifestation: manifestation);
                                            Navigator.of(context).pop();
                                            manifestation.status = ManifestationStatus.DELETED;
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (_) => ManifestationScreen(manifestation: manifestation)));
                                          }
                                        : null,
                                    child: const Text(
                                      'Não',
                                      style: TextStyle(color: defaultColor, fontSize: 17),
                                    ),
                                  )
                                : Container(),
                            !store.loading
                                ? TextButton(
                                    onPressed: !store.loading
                                        ? () async {
                                            await store.deleteManifestation(manifestation: manifestation);
                                            Navigator.of(context).pop();
                                            await UserRepository().blockUser(user: manifestation.user);
                                            manifestation.status = ManifestationStatus.DELETED;
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (_) => ManifestationScreen(manifestation: manifestation)));
                                          }
                                        : null,
                                    child: const Text(
                                      'Sim',
                                      style: TextStyle(color: errorColor, fontSize: 17),
                                    ),
                                  )
                                : Container(),
                          ],
                        );
                      }),
                    );
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(color: errorColor, fontSize: 17),
                  ),
                ),
              ],
            ));
  }
}
