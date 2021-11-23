import 'package:financas/model/usuario_autenticado.dart';
import 'package:financas/widget/movimentacoes_body.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MovimentacoesScreen extends StatelessWidget {
  static const routeName = '/movimentacoes';

  final UsuarioAutenticado usuario;

  const MovimentacoesScreen({Key? key, required this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movimentações'),
        ),
        body: MovimentacoesBody(usuario: usuario));
  }
}
