// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateStore on _CreateStore, Store {
  Computed<bool>? _$_imagesValidComputed;

  @override
  bool get _imagesValid =>
      (_$_imagesValidComputed ??= Computed<bool>(() => super._imagesValid,
              name: '_CreateStore._imagesValid'))
          .value;
  Computed<String?>? _$imagesErrorComputed;

  @override
  String? get imagesError =>
      (_$imagesErrorComputed ??= Computed<String?>(() => super.imagesError,
              name: '_CreateStore.imagesError'))
          .value;
  Computed<String?>? _$titleErrorComputed;

  @override
  String? get titleError =>
      (_$titleErrorComputed ??= Computed<String?>(() => super.titleError,
              name: '_CreateStore.titleError'))
          .value;
  Computed<String?>? _$streetErrorComputed;

  @override
  String? get streetError =>
      (_$streetErrorComputed ??= Computed<String?>(() => super.streetError,
              name: '_CreateStore.streetError'))
          .value;
  Computed<String?>? _$descriptionErrorComputed;

  @override
  String? get descriptionError => (_$descriptionErrorComputed ??=
          Computed<String?>(() => super.descriptionError,
              name: '_CreateStore.descriptionError'))
      .value;
  Computed<String?>? _$categoryErrorComputed;

  @override
  String? get categoryError =>
      (_$categoryErrorComputed ??= Computed<String?>(() => super.categoryError,
              name: '_CreateStore.categoryError'))
          .value;
  Computed<String?>? _$cityErrorComputed;

  @override
  String? get cityError =>
      (_$cityErrorComputed ??= Computed<String?>(() => super.cityError,
              name: '_CreateStore.cityError'))
          .value;
  Computed<String?>? _$neighborhoodErrorComputed;

  @override
  String? get neighborhoodError => (_$neighborhoodErrorComputed ??=
          Computed<String?>(() => super.neighborhoodError,
              name: '_CreateStore.neighborhoodError'))
      .value;

  late final _$categoryAtom =
      Atom(name: '_CreateStore.category', context: context);

  @override
  Category? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$titleAtom = Atom(name: '_CreateStore.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$cityAtom = Atom(name: '_CreateStore.city', context: context);

  @override
  City? get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(City? value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  late final _$neighborhoodAtom =
      Atom(name: '_CreateStore.neighborhood', context: context);

  @override
  Neighborhood? get neighborhood {
    _$neighborhoodAtom.reportRead();
    return super.neighborhood;
  }

  @override
  set neighborhood(Neighborhood? value) {
    _$neighborhoodAtom.reportWrite(value, super.neighborhood, () {
      super.neighborhood = value;
    });
  }

  late final _$hideNameAtom =
      Atom(name: '_CreateStore.hideName', context: context);

  @override
  bool? get hideName {
    _$hideNameAtom.reportRead();
    return super.hideName;
  }

  @override
  set hideName(bool? value) {
    _$hideNameAtom.reportWrite(value, super.hideName, () {
      super.hideName = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateStore.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$streetAtom = Atom(name: '_CreateStore.street', context: context);

  @override
  String get street {
    _$streetAtom.reportRead();
    return super.street;
  }

  @override
  set street(String value) {
    _$streetAtom.reportWrite(value, super.street, () {
      super.street = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_CreateStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_requiredAtom =
      Atom(name: '_CreateStore._required', context: context);

  @override
  bool get _required {
    _$_requiredAtom.reportRead();
    return super._required;
  }

  @override
  set _required(bool value) {
    _$_requiredAtom.reportWrite(value, super._required, () {
      super._required = value;
    });
  }

  late final _$errorTextAtom =
      Atom(name: '_CreateStore.errorText', context: context);

  @override
  String get errorText {
    _$errorTextAtom.reportRead();
    return super.errorText;
  }

  @override
  set errorText(String value) {
    _$errorTextAtom.reportWrite(value, super.errorText, () {
      super.errorText = value;
    });
  }

  late final _$savedManifestationAtom =
      Atom(name: '_CreateStore.savedManifestation', context: context);

  @override
  bool get savedManifestation {
    _$savedManifestationAtom.reportRead();
    return super.savedManifestation;
  }

  @override
  set savedManifestation(bool value) {
    _$savedManifestationAtom.reportWrite(value, super.savedManifestation, () {
      super.savedManifestation = value;
    });
  }

  late final _$_sendAsyncAction =
      AsyncAction('_CreateStore._send', context: context);

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  late final _$_CreateStoreActionController =
      ActionController(name: '_CreateStore', context: context);

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_CreateStoreActionController.startAction(
        name: '_CreateStore.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_CreateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
category: ${category},
title: ${title},
city: ${city},
neighborhood: ${neighborhood},
hideName: ${hideName},
description: ${description},
street: ${street},
loading: ${loading},
errorText: ${errorText},
savedManifestation: ${savedManifestation},
imagesError: ${imagesError},
titleError: ${titleError},
streetError: ${streetError},
descriptionError: ${descriptionError},
categoryError: ${categoryError},
cityError: ${cityError},
neighborhoodError: ${neighborhoodError}
    ''';
  }
}
