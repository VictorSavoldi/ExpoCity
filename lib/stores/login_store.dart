import 'package:expocity/helpers/extensions.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../repositories/user_repository.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String _email = '';

  @observable
  String _password = '';

  @observable
  bool loading = false;

  @observable
  bool _required = false;

  @observable
  String errorText = '';

  @action
  void setEmail(String value) => _email = value;
  void setPassword(String value) => _password = value;

  @action
  Future<void> _login() async {
    errorText = '';

    if (!_isFormValid) {
      _required = true;
      return;
    }

    loading = true;

    try {
      GetIt.I<UserManagerStore>()
          .setUser(await UserRepository().loginWithEmail(_email, _password));

      errorText = '';
    } catch (e) {
      errorText = e.toString();
    }
    loading = false;
  }

  @computed
  bool get _emailValid => _email.isNotEmpty && _email.isEmailValid();
  bool get _passwordValid => _password.isNotEmpty;
  Future<void> Function()? get loginPressed => (!loading) ? _login : null;
  bool get _isFormValid => _emailValid && _passwordValid;

  @computed
  String? get emailError {
    if (!_emailValid && _email.isNotEmpty) {
      return 'E-mail inválido';
    } else if (_email.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get passwordError {
    if (_password.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }
}
