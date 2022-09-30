import 'package:expocity/models/manifestation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/colors.dart';
import '../../../components/custom_buttons/custom_elevated_button.dart';
import '../../../stores/pending_store.dart';
import '../manifestation_screen.dart';

class ActiveButtons extends StatelessWidget {
  ActiveButtons({Key? key, required this.manifestation}) : super(key: key);

  final Manifestation manifestation;
  final PendingStore store = PendingStore();

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      edgeInsets: const EdgeInsets.symmetric(vertical: 5),
      onPressed: () => _resolvedManifestation(context: context),
      containerActionButton: Container(
        alignment: Alignment.center,
        child: const Text('RESOLVIDA'),
      ),
    );
  }

  Future<void> _resolvedManifestation({required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (_) => Observer(builder: (_) {
        return AlertDialog(
          elevation: 8,
          title: !store.loading
              ? const Text('Manifestação Resolvida')
              : const Text(
                  'Alterando Status',
                  textAlign: TextAlign.center,
                ),
          content: !store.loading
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Alterar o status da manifestação: "${manifestation.title}" para resolvida?',
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
                      style: TextStyle(color: errorColor, fontSize: 17),
                    ),
                  )
                : Container(),
            !store.loading
                ? TextButton(
                    onPressed: !store.loading
                        ? () async {
                            await store.resolveManifestation(manifestation: manifestation);
                            Navigator.of(context).pop();
                            manifestation.status = ManifestationStatus.RESOLVED;
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => ManifestationScreen(manifestation: manifestation)));
                          }
                        : null,
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: defaultColor, fontSize: 17),
                    ),
                  )
                : Container(),
          ],
        );
      }),
    );
  }
}
