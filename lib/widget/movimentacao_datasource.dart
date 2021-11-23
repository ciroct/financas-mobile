import 'package:financas/model/movimentacao.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MovimentacaoDataSource extends DataGridSource {
  final dateFormat = DateFormat('dd/MM/yyyy');
  final currencyFormat = NumberFormat.currency(symbol: 'R\$', locale: 'pt_Br');
  List<DataGridRow> _movimentacaoData = [];

  MovimentacaoDataSource({required List<Movimentacao> movimentacoes}) {
    _movimentacaoData = movimentacoes
        .map<DataGridRow>((m) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'data', value: dateFormat.format(m.data)),
              DataGridCell<String>(columnName: 'descricao', value: m.descricao),
              DataGridCell<String>(columnName: 'tipo', value: m.tipo),
              DataGridCell<String>(
                  columnName: 'valor', value: currencyFormat.format(m.valor)),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _movimentacaoData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .map<Widget>((e) => Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.value.toString()),
                ))
            .toList());
  }
}
