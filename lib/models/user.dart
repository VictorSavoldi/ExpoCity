enum UserType { COMUM, ADMINISTRADOR }

enum UserBlock { FREE, BLOCKED }

class User {
  User.createUser({
    required this.name,
    required this.email,
    required this.password,
    this.userType = UserType.COMUM,
    this.userBlock = UserBlock.FREE,
  });

  User.getDataBase(
      {required this.id,
      required this.name,
      required this.email,
      required this.userType,
      required this.userBlock,
      required this.createdAt});

  User.getDataBaseManifestation(
      {required this.id,
      required this.name,
      this.email = '',
      required this.userType,
      required this.userBlock,
      required this.createdAt});

  String? id;
  String name;
  String email;
  String? password;
  UserType userType;
  UserBlock userBlock;
  DateTime? createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, userType: $userType, createdAt: $createdAt}';
  }
}
