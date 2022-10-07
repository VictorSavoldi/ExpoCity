import 'package:expocity/components/custom_buttons/custom_elevated_button.dart';
import 'package:expocity/stores/login_store.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../components/colors.dart';
import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/error_box.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => userManagerStore.user != null, (u) {
      if (u != null) {
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final LoginStore loginStore = LoginStore();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: const Text('Entrar'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Acessar com E-mail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Observer(builder: (_) {
                      return ErrorBox(message: loginStore.errorText);
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 4, top: 1),
                      child: Text(
                        'E-mail',
                        style: TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(), isDense: true, errorText: loginStore.emailError),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        textInputAction: TextInputAction.next,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Senha',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: loginStore.passwordError,
                        ),
                        obscureText: true,
                        onChanged: loginStore.setPassword,
                      );
                    }),
                    Observer(builder: (_) {
                      return CustomElevatedButton(
                        edgeInsets: const EdgeInsets.only(top: 20, bottom: 15),
                        onPressed: loginStore.loginPressed,
                        containerActionButton: Container(
                          alignment: Alignment.center,
                          child: loginStore.loading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text('ENTRAR'),
                        ),
                      );
                    }),
                    const Divider(color: Colors.black54),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Não possui uma conta? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => SignUpScreen(),
                              ));
                            },
                            child: const Text(
                              'Cadastre-se',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: defaultColor,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
