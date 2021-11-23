import 'dart:convert';

import '/utils/constants.dart';
import '/http/web_service.dart';

class Conta {
  final int id;
  final int agencia;
  final String numero;
  final double saldo;

  Conta(
      {required this.id,
      required this.agencia,
      required this.numero,
      required this.saldo});

  factory Conta.fromJson(Map<String, dynamic> json) {
    return Conta(
        id: json['id'],
        agencia: json['agencia'],
        numero: json['numero'],
        saldo: json['saldo']);
  }

  static Resource<Conta> get(int contaId) {
    return Resource(
        url: Constants.restWebServiceURL,
        path: '${Constants.contaPath}$contaId',
        parse: (response) {
          return Conta.fromJson(jsonDecode(response.body));
        });
  }
}
