enum UserType { COMUM, ADMINISTRADOR }

class User {
  User.createUser({
    required this.name,
    required this.email,
    required this.password,
    this.userType = UserType.COMUM,
  });

  User.getDataBase(
      {required this.id,
      required this.name,
      required this.email,
      required this.userType,
      required this.createdAt});

  User.getDataBaseManifestation(
      {required this.id,
      required this.name,
      this.email = '',
      required this.userType,
      required this.createdAt});

  String? id;
  String name;
  String email;
  String? password;
  UserType userType;
  DateTime? createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, userType: $userType, createdAt: $createdAt}';
  }
}
