// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditAccountStore on _EditAccountStore, Store {
  Computed<bool>? _$_nameValidComputed;

  @override
  bool get _nameValid =>
      (_$_nameValidComputed ??= Computed<bool>(() => super._nameValid,
              name: '_EditAccountStore._nameValid'))
          .value;
  Computed<String?>? _$nameErrorComputed;

  @override
  String? get nameError =>
      (_$nameErrorComputed ??= Computed<String?>(() => super.nameError,
              name: '_EditAccountStore.nameError'))
          .value;
  Computed<String?>? _$pass1ErrorComputed;

  @override
  String? get pass1Error =>
      (_$pass1ErrorComputed ??= Computed<String?>(() => super.pass1Error,
              name: '_EditAccountStore.pass1Error'))
          .value;
  Computed<String?>? _$pass2ErrorComputed;

  @override
  String? get pass2Error =>
      (_$pass2ErrorComputed ??= Computed<String?>(() => super.pass2Error,
              name: '_EditAccountStore.pass2Error'))
          .value;

  late final _$nameAtom =
      Atom(name: '_EditAccountStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$pass1Atom =
      Atom(name: '_EditAccountStore.pass1', context: context);

  @override
  String get pass1 {
    _$pass1Atom.reportRead();
    return super.pass1;
  }

  @override
  set pass1(String value) {
    _$pass1Atom.reportWrite(value, super.pass1, () {
      super.pass1 = value;
    });
  }

  late final _$pass2Atom =
      Atom(name: '_EditAccountStore.pass2', context: context);

  @override
  String get pass2 {
    _$pass2Atom.reportRead();
    return super.pass2;
  }

  @override
  set pass2(String value) {
    _$pass2Atom.reportWrite(value, super.pass2, () {
      super.pass2 = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_EditAccountStore.loading', context: context);

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
      Atom(name: '_EditAccountStore._required', context: context);

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
      Atom(name: '_EditAccountStore.errorText', context: context);

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

  late final _$successTextAtom =
      Atom(name: '_EditAccountStore.successText', context: context);

  @override
  String get successText {
    _$successTextAtom.reportRead();
    return super.successText;
  }

  @override
  set successText(String value) {
    _$successTextAtom.reportWrite(value, super.successText, () {
      super.successText = value;
    });
  }

  late final _$_saveAsyncAction =
      AsyncAction('_EditAccountStore._save', context: context);

  @override
  Future<void> _save() {
    return _$_saveAsyncAction.run(() => super._save());
  }

  late final _$_EditAccountStoreActionController =
      ActionController(name: '_EditAccountStore', context: context);

  @override
  void setPass1(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPass1');
    try {
      return super.setPass1(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> logout() {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.logout');
    try {
      return super.logout();
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
pass1: ${pass1},
pass2: ${pass2},
loading: ${loading},
errorText: ${errorText},
successText: ${successText},
nameError: ${nameError},
pass1Error: ${pass1Error},
pass2Error: ${pass2Error}
    ''';
  }
}
