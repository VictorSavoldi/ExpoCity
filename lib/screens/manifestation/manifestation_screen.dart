import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/manifestation/components/carousel_with_indicator.dart';
import 'package:expocity/screens/manifestation/components/category_panel.dart';
import 'package:expocity/screens/manifestation/components/description_panel.dart';
import 'package:expocity/screens/manifestation/components/location_panel.dart';
import 'package:expocity/screens/manifestation/components/main_panel.dart';
import 'package:flutter/material.dart';

import 'components/user_panel.dart';

class ManifestationScreen extends StatelessWidget {
  const ManifestationScreen({Key? key, required this.manifestation})
      : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Manifestação')),
      body: ListView(children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CarouselWithIndicator(manifestation),
            ),
            Card(
              margin: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
                bottom: 15,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(manifestation: manifestation),
                    Divider(color: Colors.grey[500]),
                    DescriptionPanel(manifestation: manifestation),
                    Divider(color: Colors.grey[500]),
                    LocationPanel(manifestation: manifestation),
                    Divider(color: Colors.grey[500]),
                    CategoryPanel(manifestation: manifestation),
                    Divider(color: Colors.grey[500]),
                    UserPanel(manifestation: manifestation),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
