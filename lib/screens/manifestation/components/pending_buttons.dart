import 'package:expocity/models/manifestation.dart';
import 'package:expocity/models/user.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_buttons/custom_elevated_button.dart';

class PendingButtons extends StatelessWidget {
  const PendingButtons({Key? key, required this.manifestation})
      : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return manifestation.user.userType == UserType.COMUM
        ? Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  edgeInsets: const EdgeInsets.symmetric(vertical: 5),
                  exitAccount: true,
                  onPressed: null,
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
                  onPressed: null,
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
            onPressed: null,
            containerActionButton: Container(
              alignment: Alignment.center,
              child: const Text('APROVAR'),
            ),
          );
  }
}
