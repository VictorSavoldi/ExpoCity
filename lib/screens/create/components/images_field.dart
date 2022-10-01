import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/create/components/image_dialog.dart';
import 'package:expocity/screens/create/components/image_source_modal.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../stores/user_manager_store.dart';

class ImagesField extends StatelessWidget {
  ImagesField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;
  final UserManagerStore user = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    void _onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(children: [
      Observer(
        builder: (_) {
          return Container(
            height: 120,
            decoration: createStore.imagesError == null
                ? BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[200],
                  )
                : BoxDecoration(
                    border: Border.all(color: flutterErrorColor),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[200],
                  ),
            clipBehavior: Clip.antiAlias,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: createStore.images.length < 5 ? createStore.images.length + 1 : 5,
              itemBuilder: (_, index) {
                if (index == createStore.images.length) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: GestureDetector(
                      onTap: (!createStore.loading && user.isUserFree)
                          ? () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceModal(_onImageSelected),
                              );
                            }
                          : null,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.black12,
                        child: CircleAvatar(
                          radius: 43,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 35,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 5,
                                offset: Offset(0.4, 0.4),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, index == 4 ? 8 : 0, 16),
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                            image: createStore.images[index] is File
                                ? FileImage(createStore.images[index])
                                : CachedNetworkImageProvider(createStore.images[index]) as ImageProvider,
                            onDelete: () async => await createStore.images.removeAt(index),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.black12,
                        child: CircleAvatar(
                          radius: 43,
                          backgroundImage: createStore.images[index] is File
                              ? FileImage(createStore.images[index])
                              : CachedNetworkImageProvider(createStore.images[index]) as ImageProvider,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
      Observer(builder: (_) {
        if (createStore.imagesError != null) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                const SizedBox(height: 7),
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      createStore.imagesError!,
                      style: const TextStyle(color: flutterErrorColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    ]);
  }
}
