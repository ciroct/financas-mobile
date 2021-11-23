import 'dart:convert';

import '/http/web_service.dart';
import '/utils/constants.dart';
import 'package:intl/intl.dart';

class Movimentacao {
  final int id;
  final double valor;
  final String descricao;
  final DateTime data;
  final String tipo;

  Movimentacao(
      {required this.id,
      required this.valor,
      required this.descricao,
      required this.data,
      required this.tipo});

  factory Movimentacao.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return Movimentacao(
        id: json['id'],
        valor: json['valor'],
        descricao: json['descricao'],
        data: dateFormat.parse(json['data']),
        tipo: json['tipo']);
  }

  static Resource<List<Movimentacao>> get(int contaId) {
    return Resource(
        url: Constants.restWebServiceURL,
        path: '${Constants.movimentacoesPath}$contaId',
        parse: (response) {
          Iterable list = json.decode(utf8.decode(response.bodyBytes));
          return list.map((model) => Movimentacao.fromJson(model)).toList();
        });
  }
}
