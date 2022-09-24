import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:flutter/material.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({Key? key, required this.manifestation}) : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(color: Colors.grey[500]),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Cadastrada por',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: !manifestation.hidName
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      manifestation.user.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        'Cadastrado desde ${manifestation.user.createdAt!.formattedDate()}',
                        style: const TextStyle(
                          color: Colors.black38,
                        ))
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                      Text(
                        'Manifestação anônima',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
