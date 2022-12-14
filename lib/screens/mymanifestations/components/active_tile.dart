import 'package:cached_network_image/cached_network_image.dart';
import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/create/create_screen.dart';
import 'package:expocity/stores/mymanifestations_store.dart';
import 'package:flutter/material.dart';

import '../../../components/colors.dart';
import '../../manifestation/manifestation_screen.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile({Key? key, required this.manifestation, required this.store})
      : super(key: key);

  final Manifestation manifestation;
  final MymanifestationsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Resolvida', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete)
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
                  PopupMenuButton<MenuChoice>(
                      onSelected: (choices) {
                        switch (choices.index) {
                          case 0:
                            _editManifestation(context: context);
                            break;
                          case 1:
                            _resolvedManifestation(context: context);
                            break;
                          case 2:
                            _deletedManifestation(context: context);
                            break;
                        }
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        size: 23,
                      ),
                      itemBuilder: (_) {
                        return choices
                            .map((choice) => PopupMenuItem<MenuChoice>(
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

  Future<void> _editManifestation({required BuildContext context}) async {
    final success = await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateScreen(manifestation: manifestation)));

    if (success != null && success) {
      store.refresh();
    }
  }

  Future<void> _resolvedManifestation({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              elevation: 8,
              title: const Text('Manifesta????o Resolvida'),
              content: Text(
                'Alterar o status da manifesta????o: "${manifestation.title}" para resolvida?',
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text(
                    'N??o',
                    style: TextStyle(color: errorColor, fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    store.resolveManifestation(manifestation: manifestation);
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(color: defaultColor, fontSize: 17),
                  ),
                ),
              ],
            ));
  }

  Future<void> _deletedManifestation({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              elevation: 8,
              title: const Text('Deletar Manifesta????o'),
              content: Text(
                'Vocr?? realmente deseja deletar a manifesta????o: "${manifestation.title}"?',
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text(
                    'N??o',
                    style: TextStyle(color: defaultColor, fontSize: 17),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    store.deleteManifestation(manifestation: manifestation);
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(color: errorColor, fontSize: 17),
                  ),
                ),
              ],
            ));
  }
}

class MenuChoice {
  MenuChoice(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
