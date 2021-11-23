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
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email, color: Colors.blue),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe seu e-mail';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
              prefixIcon: Icon(Icons.lock, color: Colors.blue),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe sua senha';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
                child: const Text('Entrar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    final Webservice _webservice = Webservice();
                    try {
                      DialogBuilder(context)
                          .showLoadingIndicator('Autenticando usuário');
                      UsuarioAutenticado res =
                          await _webservice.attemptLogIn(username, password);
                      DialogBuilder(context).hideOpenDialog();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(usuario: res)));
                    } catch (e) {
                      displayDialog(context, "Ocorreu um erro",
                          "Nenhum usuário foi encontrado com este login e senha");
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
}
