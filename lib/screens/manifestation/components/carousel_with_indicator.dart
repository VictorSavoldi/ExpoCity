import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/manifestation/components/carousel_images.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator(this.manifestation, {Key? key}) : super(key: key);

  final Manifestation manifestation;

  @override
  State<StatefulWidget> createState() {
    return CarouselImages(manifestation);
  }
}
