import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/repositories/user_repository.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../models/user.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    successText = '';
    name = user.name;
  }

  UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  User user = GetIt.I<UserManagerStore>().user!;

  @observable
  String name = '';

  @observable
  String pass1 = '';

  @observable
  String pass2 = '';

  @observable
  bool loading = false;

  @observable
  bool _required = false;

  @observable
  String errorText = '';

  @observable
  String successText = '';

  @action
  void setPass1(String value) => pass1 = value;
  void setPass2(String value) => pass2 = value;
  void setName(String value) => name = value;

  @action
  Future<void> logout() => userManagerStore.logout();

  @action
  Future<void> _save() async {
    if (!_isFormValid) {
      _required = true;
      return;
    }

    if (name == user.name) {
      return;
    }

    loading = true;

    try {
      user.name = name;

      if (pass1.isNotEmpty) {
        user.password = pass1;
      } else {
        user.password = null;
      }

      await UserRepository().save(user);

      userManagerStore.setUser(user);
    } catch (e) {
      errorText = e.toString();
    }

    errorText = '';

    loading = false;

    successText = 'Usuário atualizado com sucesso.';
  }

  @computed
  bool get _nameValid => name.isNotEmpty && name.isNameValid();
  bool get _pass1Valid => pass1.length >= 6 || pass1.isEmpty;
  bool get _pass2Valid => pass2 == pass1 && _pass1Valid;
  bool get _isFormValid => _nameValid && _pass1Valid && _pass2Valid;
  Future<void> Function()? get savePressed => (!loading) ? _save : null;

  @computed
  String? get nameError {
    if (!_nameValid && name.isNotEmpty) {
      return 'Nome inválido';
    } else if (name.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get pass1Error {
    if (!_pass1Valid) {
      return 'Senha muito curta';
    } else {
      return null;
    }
  }

  @computed
  String? get pass2Error {
    if (!_pass2Valid && pass2.isEmpty && _required) {
      return 'Campo obrigatório';
    } else if (!_pass2Valid && _required) {
      return 'Senhas não coincidem';
    } else if (!_pass2Valid && pass2.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }
}
