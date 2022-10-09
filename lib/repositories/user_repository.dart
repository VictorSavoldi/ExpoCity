import 'package:expocity/repositories/parse_errors.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../models/user.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set(keyUserType, user.userType.index);
    parseUser.set(keyUserBlock, user.userBlock.index);

    final response = await parseUser.signUp();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<void> save(User user) async {
    final ParseUser parseUser = await ParseUser.currentUser();

    parseUser.set<String>(keyUserName, user.name);

    if (user.password != null) {
      parseUser.password = user.password;
    }

    final response = await parseUser.save();

    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code).toString());
    }

    if (user.password != null) {
      await parseUser.logout();

      final loginResponse = await ParseUser(user.email, user.password, user.email).login();

      if (!loginResponse.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code).toString());
      }
    }
  }

  Future<void> blockUser({required User user}) async {
    final ParseCloudFunction function = ParseCloudFunction('blockUser');

    final Map<String, dynamic> params = <String, dynamic>{'objectId': user.id, 'blockIndex': 1};

    final ParseResponse parseResponse = await function.execute(parameters: params);
    if (parseResponse.success && parseResponse.result != null) {
      print(parseResponse.result);
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<User?> currentUser() async {
    final parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      final response = await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
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
      userType: UserType.values[parseUser.get(keyUserType)],
      userBlock: UserBlock.values[parseUser.get(keyUserBlock)],
      createdAt: parseUser.get(keyUserCreatedAt),
      email: parseUser.get(keyUserEmail),
    );
  }

  User mapParseToUserManifestation(ParseUser parseUser) {
    return User.getDataBaseManifestation(
      id: parseUser.get(keyUserId),
      name: parseUser.get(keyUserName),
      userType: UserType.values[parseUser.get(keyUserType)],
      userBlock: UserBlock.values[parseUser.get(keyUserBlock)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }
}
