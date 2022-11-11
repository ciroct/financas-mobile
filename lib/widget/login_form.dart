import 'package:financas/http/web_service.dart';
import 'package:financas/model/usuario_autenticado.dart';
import 'package:financas/utils/dialog_builder.dart';

import '/screen/home_screen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          textFormField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              label: 'E-mail',
              icon: Icons.email,
              message: 'Informe seu e-mail'),
          textFormField(
              controller: _passwordController,
              obscure: true,
              label: 'Senha',
              icon: Icons.lock,
              message: 'Informe sua senha'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
                child: const Text('Entrar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    final Webservice webservice = Webservice();
                    try {
                      DialogBuilder(context)
                          .showLoadingIndicator('Autenticando usuário');

                      UsuarioAutenticado res =
                          await webservice.attemptLogIn(username, password);

                      if (!context.mounted) return;

                      DialogBuilder(context).hideOpenDialog();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(usuario: res)));
                    } catch (e) {
                      DialogBuilder(context).hideOpenDialog();
                      displayDialog(context, 'Ocorreu um erro',
                          "$e Nenhum usuário foi encontrado com este login e senha");
                    }
                  } else {
                    displayDialog(
                        context, "Ocorreu um erro", "Informe o login e senha");
                  }
                }),
          ),
        ],
      ),
    );
  }

  TextFormField textFormField(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      bool obscure = false,
      String? label,
      IconData? icon,
      String? message}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
      ),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return message;
        }
        return null;
      },
    );
  }
}
