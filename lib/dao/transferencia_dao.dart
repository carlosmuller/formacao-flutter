import 'package:bytebank/infra/banco_de_dados.dart';
import 'package:bytebank/models/transferencia.dart';

class TransferenciaDAO {
  static const String criaTabela = 'CREATE TABLE $_nomeDaTabela('
      '$_id INTEGER PRIMARY KEY, '
      '$_valor INTEGER, '
      '$_numeroDaConta INTEGER)';

  static const String _nomeDaTabela = 'transferencias';
  static const String _id = 'id';
  static const String _valor = 'valor';
  static const String _numeroDaConta = 'numero_da_conta';

  Future<int> salva(Transferencia transferencia) async {
    final db = await getDatabase();
    return db.insert(
      _nomeDaTabela,
      {
        _valor: transferencia.valor * 100,
        _numeroDaConta: transferencia.numeroDaConta ,
      },
    );
  }

  Future<List<Transferencia>> listaTodos() async {
    final db = await getDatabase();
    final resultados = await db.query(_nomeDaTabela);
    return _paraLista(resultados);
  }

  List<Transferencia> _paraLista(List<Map<String, dynamic>> resultados) {
    return resultados.map((Map<String, dynamic> linha) {
      final Transferencia transferencia =
          Transferencia(linha[_valor] / 100, linha[_numeroDaConta], linha[_id]);
      return transferencia;
    }).toList(growable: false);
  }
}
