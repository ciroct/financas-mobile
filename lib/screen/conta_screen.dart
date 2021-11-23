import '/model/usuario_autenticado.dart';
import '/widget/conta_body.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ContaScreen extends StatelessWidget {
  static const routeName = '/conta';

  final UsuarioAutenticado usuario;

  const ContaScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conta de ${usuario.nome}'),
      ),
      body: ContaBody(
        usuario: usuario,
      ),
    );
  }
}
