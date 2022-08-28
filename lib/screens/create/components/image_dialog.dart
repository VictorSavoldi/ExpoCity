import 'dart:io';

import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog({Key? key, required this.image, required this.onDelete})
      : super(key: key);

  final File? image;
  Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Card(
        color: backgroundColor,
        margin: const EdgeInsets.symmetric(horizontal: 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.file(File(image!.path)),
              ),
              CustomElevatedButton(
                edgeInsets: const EdgeInsets.only(top: 20, bottom: 15),
                onPressed: () async {
                  onDelete();
                  Navigator.of(context).pop();
                },
                containerActionButton: Container(
                  alignment: Alignment.center,
                  child: const Text('Excluir'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
