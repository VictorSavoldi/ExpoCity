// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manager_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserManagerStore on _UserManagerStore, Store {
  Computed<bool>? _$isLoggedinComputed;

  @override
  bool get isLoggedin =>
      (_$isLoggedinComputed ??= Computed<bool>(() => super.isLoggedin,
              name: '_UserManagerStore.isLoggedin'))
          .value;
  Computed<bool>? _$isUserAdminComputed;

  @override
  bool get isUserAdmin =>
      (_$isUserAdminComputed ??= Computed<bool>(() => super.isUserAdmin,
              name: '_UserManagerStore.isUserAdmin'))
          .value;

  late final _$userAtom =
      Atom(name: '_UserManagerStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_UserManagerStoreActionController =
      ActionController(name: '_UserManagerStore', context: context);

  @override
  void setUser(User? value) {
    final _$actionInfo = _$_UserManagerStoreActionController.startAction(
        name: '_UserManagerStore.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_UserManagerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserSingUp(User value) {
    final _$actionInfo = _$_UserManagerStoreActionController.startAction(
        name: '_UserManagerStore.setUserSingUp');
    try {
      return super.setUserSingUp(value);
    } finally {
      _$_UserManagerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoggedin: ${isLoggedin},
isUserAdmin: ${isUserAdmin}
    ''';
  }
}
