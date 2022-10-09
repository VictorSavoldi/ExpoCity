import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/manifestation/components/pending_buttons.dart';
import 'package:flutter/material.dart';

import 'active_buttons.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key, required this.manifestation}) : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return manifestation.status == ManifestationStatus.PENDING ||
            manifestation.status == ManifestationStatus.ACTIVE
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(color: Colors.grey[500]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Gerenciar Manifestação',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: [
                  manifestation.status == ManifestationStatus.PENDING
                      ? PendingButtons(manifestation: manifestation)
                      : Container(),
                  manifestation.status == ManifestationStatus.ACTIVE
                      ? ActiveButtons(manifestation: manifestation)
                      : Container(),
                ],
              ),
              const SizedBox(height: 10)
            ],
          )
        : Container();
  }
}
