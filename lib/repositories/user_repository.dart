import 'package:expocity/repositories/parse_errors.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../models/user.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set(keyUserType, user.userType.index);

    final response = await parseUser.signUp();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(
          ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(
          ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<User?> currentUser() async {
    final parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response!.success) {
        return mapParseToUser(response.result);
      } else {
        parseUser.logout();
      }
    }
    return null;
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();

    await currentUser.logout();
  }

  User mapParseToUser(ParseUser parseUser) {
    return User.getDataBase(
      id: parseUser.get(keyUserId),
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      userType: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }
}
