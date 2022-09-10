import 'package:expocity/components/colors.dart';
import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:flutter/material.dart';

class MainPanel extends StatelessWidget {
  const MainPanel({Key? key, required this.manifestation}) : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    _StatusManifestation(int indexManifestation) {
      switch (indexManifestation) {
        case 1:
          return const Text(
            'Resolvida',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.green,
            ),
          );
        case 2:
          return const Text(
            'Deletada',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.red,
            ),
          );
        case 0:
        default:
          return const Text(
            'Ativa',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: defaultColor,
            ),
          );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 14),
          child: Text(
            manifestation.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              //color: Colors.grey[800],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    'Cadastrada em ${manifestation.createdAt.formattedDate()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _StatusManifestation(manifestation.status.index),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        )
      ],
    );
  }
}
