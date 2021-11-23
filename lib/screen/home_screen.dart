import 'package:financas/screen/login_screen.dart';

import '/model/usuario_autenticado.dart';

import '/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'conta_screen.dart';
import 'movimentacoes_screen.dart';

class HomeScreen extends StatelessWidget {
  final UsuarioAutenticado usuario;

  HomeScreen({Key? key, required this.usuario}) : super(key: key);

  final String appTitle = "Finanças";
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: appTitle,
      routes: {
        ContaScreen.routeName: (context) => ContaScreen(usuario: usuario),
        MovimentacoesScreen.routeName: (context) =>
            MovimentacoesScreen(usuario: usuario),
      },
      home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
            actions: [
              PopupMenuButton<String>(
                  onSelected: (choice) => choiceAction(choice, context),
                  itemBuilder: (context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                          value: choice, child: Text(choice));
                    }).toList();
                  })
            ],
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/financas_logo.jpeg',
              ),
            ],
          ))),
    );
  }

  void choiceAction(String choice, BuildContext context) {
    if (choice == Constants.contaOption) {
      navigatorKey.currentState!.pushNamed(ContaScreen.routeName);
    } else if (choice == Constants.movimentacoesOption) {
      navigatorKey.currentState!.pushNamed(MovimentacoesScreen.routeName);
    } else if (choice == Constants.logoutOption) {
      NavigatorState navigatorState = Navigator.of(context);
      while (navigatorState.canPop()) {
        navigatorState.pop();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        }),
      );
    }
  }
}
