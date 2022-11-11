import '/widget/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login no Financas'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            Image.asset(
              'images/financas_logo.jpeg',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26.0),
            ),
            const LoginForm(),
          ],
        )));
  }
}
