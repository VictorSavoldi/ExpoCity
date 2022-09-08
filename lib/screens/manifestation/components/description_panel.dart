import 'package:expocity/components/colors.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionPanel extends StatelessWidget {
  const DescriptionPanel({Key? key, required this.manifestation})
      : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Descrição',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ReadMoreText(
            manifestation.description,
            trimLines: 2,
            trimMode: TrimMode.Line,
            textAlign: TextAlign.justify,
            trimCollapsedText: 'Ver mais',
            trimExpandedText: ' Ver menos',
            colorClickableText: defaultColor,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
