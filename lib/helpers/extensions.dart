import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

    return regex.hasMatch(this);
  }

  bool isNameValid() {
    final RegExp regex = RegExp(
        r"(?=^.{2,60}$)^[A-ZÀÁÂĖÈÉÊÌÍÒÓÔÕÙÚÛ][a-zàáâãèéêìíóôõùú]+(?:[ ](?:das?|dos?|de|e|[A-Z][a-z'][A-zçÇàáâãèéêìíóôõùúÀÁÂĖÈÉÊÌÍÒÓÔÕÙÚÛ]+))*$");

    return regex.hasMatch(this);
  }

  // 8 Caracteres | 1 Letra maiuscula | 1 Número | 1 Simbolo
  bool isPasswordValid() {
    final RegExp regex = RegExp(
        r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,}$");

    return regex.hasMatch(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yyyy', 'pt-BR').format(this);
  }
}
