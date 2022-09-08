import 'dart:io';

import 'package:expocity/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal(this.onImageSelected, {Key? key}) : super(key: key);

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: backgroundColor,
      onClosing: () {},
      builder: (_) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 170),
              child: Container(
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            TextButton(
              onPressed: getFromCamera,
              child: const Text(
                'Câmera',
                style: TextStyle(
                  fontSize: 18,
                  color: defaultColor,
                ),
              ),
            ),
            TextButton(
              onPressed: getFromGallery,
              child: const Text(
                'Galeria',
                style: TextStyle(
                  fontSize: 18,
                  color: defaultColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    imageSelected(File(pickedFile.path));
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    imageSelected(File(pickedFile.path));
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: defaultColor,
          toolbarWidgetColor: Colors.white,
        )
      ],
    );

    if (croppedFile == null) return;

    onImageSelected(File(croppedFile.path));
  }
}
