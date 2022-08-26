import 'package:expocity/models/user.dart';
import 'package:expocity/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User? user;

  @action
  void setUser(User? value) => user = value;

  @action
  void setUserSingUp(User value) => user = value;

  @computed
  bool get isLoggedin => user != null;

  // ignore: body_might_complete_normally_nullable
  Future<User?> _getCurrentUser() async {
    setUser(await UserRepository().currentUser());
  }

  Future<void> logout() async {
    await UserRepository().logout();

    setUser(null);
  }
}
