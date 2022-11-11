import 'package:intl/intl.dart';

import '/model/conta.dart';
import 'package:flutter/material.dart';

class ContaData extends StatelessWidget {
  final Conta conta;
  const ContaData({Key? key, required this.conta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(symbol: 'R\$', locale: 'pt_Br');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          child: Text(
            "Agência: ${conta.agencia}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          child: Text(
            "Numero: ${conta.numero}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          child: Text(
            "Saldo: ${currencyFormat.format(conta.saldo)}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
