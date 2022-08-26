// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on _SignupStore, Store {
  Computed<bool>? _$_nameValidComputed;

  @override
  bool get _nameValid =>
      (_$_nameValidComputed ??= Computed<bool>(() => super._nameValid,
              name: '_SignupStore._nameValid'))
          .value;
  Computed<String?>? _$nameErrorComputed;

  @override
  String? get nameError =>
      (_$nameErrorComputed ??= Computed<String?>(() => super.nameError,
              name: '_SignupStore.nameError'))
          .value;
  Computed<String?>? _$emailErrorComputed;

  @override
  String? get emailError =>
      (_$emailErrorComputed ??= Computed<String?>(() => super.emailError,
              name: '_SignupStore.emailError'))
          .value;
  Computed<String?>? _$pass1ErrorComputed;

  @override
  String? get pass1Error =>
      (_$pass1ErrorComputed ??= Computed<String?>(() => super.pass1Error,
              name: '_SignupStore.pass1Error'))
          .value;
  Computed<String?>? _$pass2ErrorComputed;

  @override
  String? get pass2Error =>
      (_$pass2ErrorComputed ??= Computed<String?>(() => super.pass2Error,
              name: '_SignupStore.pass2Error'))
          .value;

  late final _$nameAtom = Atom(name: '_SignupStore.name', context: context);

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

  late final _$emailAtom = Atom(name: '_SignupStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$pass1Atom = Atom(name: '_SignupStore.pass1', context: context);

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

  late final _$pass2Atom = Atom(name: '_SignupStore.pass2', context: context);

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
      Atom(name: '_SignupStore.loading', context: context);

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
      Atom(name: '_SignupStore._required', context: context);

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
      Atom(name: '_SignupStore.errorText', context: context);

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

  late final _$_signUpAsyncAction =
      AsyncAction('_SignupStore._signUp', context: context);

  @override
  Future<void> _signUp() {
    return _$_signUpAsyncAction.run(() => super._signUp());
  }

  late final _$_SignupStoreActionController =
      ActionController(name: '_SignupStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
pass1: ${pass1},
pass2: ${pass2},
loading: ${loading},
errorText: ${errorText},
nameError: ${nameError},
emailError: ${emailError},
pass1Error: ${pass1Error},
pass2Error: ${pass2Error}
    ''';
  }
}
