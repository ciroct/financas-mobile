import 'package:financas/screen/login_screen.dart';
import 'package:financas/widget/conta_body.dart';
import 'package:financas/widget/movimentacoes_body.dart';

import '/model/usuario_autenticado.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UsuarioAutenticado usuario;
  const HomeScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String appTitle = 'Finanças';
  final navigatorKey = GlobalKey<NavigatorState>();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text('$appTitle - ${widget.usuario.nome}'),
          actions: [_logoutIcon()],
        ),
        body: _choiceAction(currentPageIndex, context),
        //body: IndexedStack(
        //  index: currrentPageIndex,
        //  children: [_choiceAction(currrentPageIndex, context)],
        //),
        bottomNavigationBar: _barraDeNavegacaoInferior(),
      ),
    );
  }

  IconButton _logoutIcon() {
    return IconButton(
      onPressed: _logout,
      icon: const Icon(Icons.logout),
      tooltip: 'Sair',
    );
  }

  Widget _choiceAction(int choice, BuildContext context) {
    if (choice == 1) {
      return ContaBody(usuario: widget.usuario);
    } else if (choice == 2) {
      return MovimentacoesBody(usuario: widget.usuario);
    }
    return _homeBody();
  }

  Center _homeBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/financas_logo.jpeg'),
      ],
    ));
  }

  BottomNavigationBar _barraDeNavegacaoInferior() {
    return BottomNavigationBar(
        currentIndex: currentPageIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => currentPageIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Conta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.balance),
            label: 'Movimentações',
          ),
        ]);
  }

  void _logout() {
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
