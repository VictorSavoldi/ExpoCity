import 'package:expocity/models/manifestation.dart';
import 'package:expocity/models/user.dart';
import 'package:expocity/screens/pending/pending_screen.dart';
import 'package:expocity/stores/pending_store.dart';
import 'package:flutter/material.dart';

import '../../../components/colors.dart';
import '../../../components/custom_buttons/custom_elevated_button.dart';
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
        builder: (_) => AlertDialog(
              elevation: 8,
              title: const Text('Manifestação Ativa'),
              content: Text(
                'Alterar o status da manifestação: "${manifestation.title}" para ativa?',
                style: const TextStyle(fontSize: 16),
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
                    store.activeManifestation(manifestation: manifestation);
                    manifestation.status = ManifestationStatus.ACTIVE;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PendingScreen()));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ManifestationScreen(manifestation: manifestation)));
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(color: errorColor, fontSize: 17),
                  ),
                ),
              ],
            ));
  }

  Future<void> _deletedManifestation({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              elevation: 8,
              title: const Text('Deletar Manifestação'),
              content: Text(
                'Vocrê realmente deseja deletar a manifestação: "${manifestation.title}"?',
                style: const TextStyle(fontSize: 16),
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
                    store.deleteManifestation(manifestation: manifestation);
                    manifestation.status = ManifestationStatus.DELETED;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PendingScreen()));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ManifestationScreen(manifestation: manifestation)));
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
