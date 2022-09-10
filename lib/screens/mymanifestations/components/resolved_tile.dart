import 'package:cached_network_image/cached_network_image.dart';
import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/manifestation/manifestation_screen.dart';
import 'package:flutter/material.dart';

import '../../../components/colors.dart';

class ResolvedTile extends StatelessWidget {
  ResolvedTile({Key? key, required this.manifestation}) : super(key: key);

  final Manifestation manifestation;

  final List<MenuChoice2> choices = [
    MenuChoice2(index: 0, title: 'Ativa', iconData: Icons.thumb_down),
    MenuChoice2(index: 1, title: 'Excluir', iconData: Icons.delete)
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ManifestationScreen(manifestation: manifestation)));
      },
      child: Container(
        height: 120,
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
                height: 120,
                width: 110,
                child: CachedNetworkImage(
                  imageUrl: manifestation.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : manifestation.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 15,
                    right: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        manifestation.title,
                        style: const TextStyle(
                          fontSize: 15,
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
                        manifestation.createdAt.formattedDate(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 5),
                  PopupMenuButton<MenuChoice2>(
                      onSelected: (choices) {
                        switch (choices.index) {
                          case 0:
                            break;
                          case 1:
                            break;
                        }
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        size: 23,
                      ),
                      itemBuilder: (_) {
                        return choices
                            .map((choice) => PopupMenuItem<MenuChoice2>(
                                  value: choice,
                                  child: Row(
                                    children: [
                                      Icon(
                                        choice.iconData,
                                        size: 20,
                                        color: defaultColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        choice.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: defaultColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuChoice2 {
  MenuChoice2(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
