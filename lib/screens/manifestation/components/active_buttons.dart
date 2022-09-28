import 'package:expocity/models/manifestation.dart';
import 'package:flutter/material.dart';

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
        builder: (_) => AlertDialog(
              elevation: 8,
              title: const Text('Manifestação Resolvida'),
              content: Text(
                'Alterar o status da manifestação: "${manifestation.title}" para resolvida?',
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text(
                    'Não',
                    style: TextStyle(color: errorColor, fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    store.resolveManifestation(manifestation: manifestation);
                    manifestation.status = ManifestationStatus.RESOLVED;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ManifestationScreen(manifestation: manifestation)));
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(color: defaultColor, fontSize: 17),
                  ),
                ),
              ],
            ));
  }
}
