import 'package:expocity/components/custom_buttons/custom_elevated_button.dart';
import 'package:expocity/components/custom_drawer/custom_drawer.dart';
import 'package:expocity/screens/create/components/category_field.dart';
import 'package:expocity/screens/create/components/city_field.dart';
import 'package:expocity/screens/create/components/hide_name_field.dart';
import 'package:expocity/screens/create/components/images_field.dart';
import 'package:expocity/screens/create/components/neighborhood_field.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({Key? key}) : super(key: key);

  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
        fontWeight: FontWeight.w800, color: Colors.black38, fontSize: 15);

    const contentPadding = EdgeInsets.symmetric(vertical: 18, horizontal: 12);

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(title: 'Cadastrar Manifestação'),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(25),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImagesField(createStore: createStore),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !createStore.loading,
                      onChanged: createStore.setTitle,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        labelStyle: labelStyle,
                        border: const OutlineInputBorder(),
                        contentPadding: contentPadding,
                        errorText: createStore.titleError,
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    );
                  }),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !createStore.loading,
                      onChanged: createStore.setDescription,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        labelStyle: labelStyle,
                        border: const OutlineInputBorder(),
                        contentPadding: contentPadding,
                        errorText: createStore.descriptionError,
                      ),
                      maxLength: 300,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    );
                  }),
                  const SizedBox(height: 20),
                  CategoryField(createStore: createStore),
                  const SizedBox(height: 20),
                  CityField(createStore: createStore),
                  const SizedBox(height: 20),
                  NeighborhoodField(createStore: createStore),
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !createStore.loading,
                      onChanged: createStore.setStreet,
                      decoration: InputDecoration(
                        labelText: 'Rua',
                        labelStyle: labelStyle,
                        border: const OutlineInputBorder(),
                        contentPadding: contentPadding,
                        errorText: createStore.streetError,
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    );
                  }),
                  const SizedBox(height: 15),
                  HideNameField(createStore: createStore),
                  Observer(builder: (_) {
                    return CustomElevatedButton(
                      edgeInsets: const EdgeInsets.only(top: 15, bottom: 15),
                      onPressed: createStore.sendPressed,
                      containerActionButton: Container(
                        alignment: Alignment.center,
                        child: createStore.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'ENVIAR',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
