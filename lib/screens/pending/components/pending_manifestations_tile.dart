import 'package:cached_network_image/cached_network_image.dart';
import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/screens/manifestation/manifestation_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/manifestation.dart';

class PendingManifestationsTile extends StatelessWidget {
  const PendingManifestationsTile({Key? key, required this.manifestation})
      : super(key: key);

  final Manifestation manifestation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ManifestationScreen(manifestation: manifestation)));
      },
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            //side: const BorderSide(color: Colors.black),
          ),
          elevation: 8,
          child: Row(
            children: [
              SizedBox(
                height: 140,
                width: 130,
                child: CachedNetworkImage(
                  imageUrl: manifestation.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : manifestation.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      manifestation.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      manifestation.category!.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${manifestation.createdAt.formattedDate()} - '
                      '${manifestation.city!.name} - '
                      '${manifestation.neighborhood!.name}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
