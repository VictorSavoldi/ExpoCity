import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_buttons/custom_elevated_button.dart';
import 'package:expocity/components/custom_drawer/custom_drawer.dart';
import 'package:expocity/components/error_box.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/screens/create/components/category_field.dart';
import 'package:expocity/screens/create/components/city_field.dart';
import 'package:expocity/screens/create/components/hide_name_field.dart';
import 'package:expocity/screens/create/components/images_field.dart';
import 'package:expocity/screens/create/components/neighborhood_field.dart';
import 'package:expocity/screens/mymanifestations/mymanifestations_screen.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:expocity/stores/page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../stores/user_manager_store.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key, this.manifestation}) : super(key: key);

  final Manifestation? manifestation;

  @override
  State<CreateScreen> createState() => _CreateScreenState(manifestation);
}

class _CreateScreenState extends State<CreateScreen> {
  _CreateScreenState(Manifestation? manifestation)
      : editing = manifestation != null,
        createStore = CreateStore(manifestation ?? Manifestation());

  bool editing;
  final CreateStore createStore;
  final UserManagerStore user = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => createStore.savedManifestation, () {
      if (editing) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        GetIt.I<PageStore>().setPage(3);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MymanifestationsScreen(indexController: 0),
          ),
        );
      } else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MymanifestationsScreen(indexController: 0),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    createStore.editManifestation = editing;

    const labelStyle = TextStyle(fontWeight: FontWeight.w800, color: Colors.black38, fontSize: 15);
    const contentPadding = EdgeInsets.symmetric(vertical: 18, horizontal: 12);

    return Scaffold(
      drawer: editing ? null : const CustomDrawer(),
      appBar: CustomAppBar(title: editing ? const Text('Editar Manifestação') : const Text('Cadastrar Manifestação')),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 5),
              child: Observer(
                builder: (_) {
                  if (createStore.loading) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 15),
                      child: Column(
                        children: [
                          !editing
                              ? const Text(
                                  'Cadastrando Manifestação',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: defaultColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : const Text(
                                  'Alterando Manifestação',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: defaultColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          const SizedBox(height: 20),
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(defaultColor),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        !user.isUserFree
                            ? const ErrorBox(
                                message: 'Usuário bloqueado. Não é possível cadastrar uma nova Manifestação.')
                            : Container(),
                        ImagesField(createStore: createStore),
                        const SizedBox(height: 20),
                        Observer(builder: (_) {
                          return TextFormField(
                            initialValue: createStore.title,
                            enabled: !createStore.loading && user.isUserFree,
                            onChanged: createStore.setTitle,
                            decoration: InputDecoration(
                              labelText: 'Título',
                              labelStyle: labelStyle,
                              border: const OutlineInputBorder(),
                              contentPadding: contentPadding,
                              errorText: createStore.titleError,
                            ),
                            maxLength: 50,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                          );
                        }),
                        const SizedBox(height: 20),
                        Observer(builder: (_) {
                          return TextFormField(
                            initialValue: createStore.description,
                            enabled: !createStore.loading && user.isUserFree,
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
                            textInputAction: TextInputAction.newline,
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
                            initialValue: createStore.street,
                            enabled: !createStore.loading && user.isUserFree,
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
                        ErrorBox(message: createStore.errorText),
                        Observer(builder: (_) {
                          return CustomElevatedButton(
                            exitAccount: user.isUserFree ? false : true,
                            edgeInsets: const EdgeInsets.only(top: 15, bottom: 15),
                            onPressed: user.isUserFree
                                ? !editing
                                    ? createStore.sendPressed
                                    : () => showDialog(
                                          context: context,
                                          builder: (_) => Observer(builder: (_) {
                                            return AlertDialog(
                                              elevation: 8,
                                              title: !createStore.loading
                                                  ? const Text('Editar Manifestação')
                                                  : const Text(
                                                      'Alterando Status',
                                                      textAlign: TextAlign.center,
                                                    ),
                                              content: !createStore.loading
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(top: 10),
                                                      child: Text(
                                                        'Deseja editar a Manifestação? Ao confirmar, o status será retornado para "Pendente".',
                                                        style: TextStyle(fontSize: 17),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets.only(top: 10),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: const [
                                                              CircularProgressIndicator(
                                                                valueColor: AlwaysStoppedAnimation(defaultColor),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                              actions: [
                                                !createStore.loading
                                                    ? TextButton(
                                                        onPressed:
                                                            !createStore.loading ? Navigator.of(context).pop : null,
                                                        child: const Text(
                                                          'Não',
                                                          style: TextStyle(color: defaultColor, fontSize: 17),
                                                        ),
                                                      )
                                                    : Container(),
                                                !createStore.loading
                                                    ? TextButton(
                                                        onPressed:
                                                            !createStore.loading ? createStore.sendPressed : null,
                                                        child: const Text(
                                                          'Sim',
                                                          style: TextStyle(color: errorColor, fontSize: 17),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            );
                                          }),
                                        )
                                : null,
                            containerActionButton: Container(
                              alignment: Alignment.center,
                              child: !editing
                                  ? createStore.loading
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.white),
                                        )
                                      : user.isUserFree
                                          ? const Text('CADASTRAR', style: TextStyle(color: Colors.white))
                                          : const Text('CADASTRAR', style: TextStyle(color: Colors.black38))
                                  : createStore.loading
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.white),
                                        )
                                      : const Text(
                                          'EDITAR',
                                          style: TextStyle(color: Colors.white),
                                        ),
                            ),
                          );
                        }),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
