import '/utils/loading_indicator.dart';
import '/http/web_service.dart';
import '/model/conta.dart';
import '/model/usuario_autenticado.dart';

import 'package:flutter/material.dart';

import 'conta_data.dart';

class ContaBody extends StatefulWidget {
  final UsuarioAutenticado usuario;

  const ContaBody({Key? key, required this.usuario}) : super(key: key);

  @override
  ContaBodyState createState() => ContaBodyState();
}

class ContaBodyState extends State<ContaBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Conta>(
        initialData: null,
        future: Webservice(token: widget.usuario.token)
            .load(Conta.get(widget.usuario.contaId)),
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
              final Conta? conta = snapshot.data;
              if (conta == null) {
                return Center(
                  child: Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          'Ops! Sua conta não foi encontrada.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ContaData(conta: conta);
              }
          }
          return const Text('Falha ao carregar os dados da conta');
        });
  }
}
