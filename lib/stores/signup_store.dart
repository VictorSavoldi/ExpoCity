import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/models/user.dart';
import 'package:expocity/repositories/user_repository.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String name = '';

  @observable
  String email = '';

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

  @action
  void setName(String value) => name = value;
  void setEmail(String value) => email = value;
  void setPass1(String value) => pass1 = value;
  void setPass2(String value) => pass2 = value;

  @action
  Future<void> _signUp() async {
    if (!_isFormValid) {
      _required = true;
      return;
    }

    loading = true;

    try {
      GetIt.I<UserManagerStore>()
          .setUserSingUp(await UserRepository().signUp(User.createUser(name: name, email: email, password: pass1)));

      errorText = '';
    } catch (e) {
      errorText = e.toString();
    }

    loading = false;
  }

  @computed
  bool get _nameValid => name.isNotEmpty && name.isNameValid();
  bool get _emailValid => email.isNotEmpty && email.isEmailValid();
  bool get _pass1Valid => pass1.isNotEmpty && pass1.length >= 6;
  bool get _pass2Valid => pass2.isNotEmpty && pass2 == pass1;
  bool get _isFormValid => _nameValid && _emailValid && _pass1Valid && _pass2Valid;
  Future<void> Function()? get signUpPressed => (!loading) ? _signUp : null;

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
  String? get emailError {
    if (!_emailValid && email.isNotEmpty) {
      return 'E-mail inválido';
    } else if (email.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get pass1Error {
    if (!_pass1Valid && pass1.isNotEmpty) {
      return 'Senha muito curta';
    } else if (pass1.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get pass2Error {
    if (!_pass2Valid && pass2.isNotEmpty) {
      return 'Senhas não coincidem';
    } else if (pass2.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }
}
