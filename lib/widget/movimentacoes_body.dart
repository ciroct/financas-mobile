import '/model/usuario_autenticado.dart';
import '/utils/loading_indicator.dart';
import '/http/web_service.dart';
import '/model/movimentacao.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'movimentacao_datasource.dart';
import 'movimentacao_list.dart';

class MovimentacoesBody extends StatefulWidget {
  final UsuarioAutenticado usuario;
  const MovimentacoesBody({Key? key, required this.usuario}) : super(key: key);

  @override
  createState() => MovimentacoesBodyState();
}

class MovimentacoesBodyState extends State<MovimentacoesBody> {
  late MovimentacaoDataSource movimentacaoDataSource;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movimentacao>>(
        initialData: const [],
        future: Webservice(token: widget.usuario.token)
            .load(Movimentacao.get(widget.usuario.contaId)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: const <Widget>[
                    LoadingIndicator(text: 'Carregando'),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Movimentacao>? movimentacoes = snapshot.data;
              if (movimentacoes == null || movimentacoes.isEmpty) {
                return Center(
                  child: Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          'Ops! Não foram encontradas movimentações para a sua conta.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                movimentacaoDataSource =
                    MovimentacaoDataSource(movimentacoes: movimentacoes);
                return MovimentacaoList(
                    movimentacaoDataSource: movimentacaoDataSource);
              }
          }
          return const Text('Falha ao listar as movimentações');
        });
  }
}
