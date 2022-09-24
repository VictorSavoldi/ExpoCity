import 'package:expocity/models/manifestation.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_buttons/custom_elevated_button.dart';

class ActiveButtons extends StatelessWidget {
  const ActiveButtons({Key? key, required this.manifestation})
      : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      edgeInsets: const EdgeInsets.symmetric(vertical: 5),
      onPressed: null,
      containerActionButton: Container(
        alignment: Alignment.center,
        child: const Text('RESOLVIDA'),
      ),
    );
  }
}
