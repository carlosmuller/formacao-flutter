import 'package:bytebank/infra/banco_de_dados.dart';
import 'package:bytebank/models/contato.dart';

class ContatoDao {
  static const String criaTabela = 'CREATE TABLE $_nomeDaTabela('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numeroDaConta INTEGER)';

  static const String _nomeDaTabela = 'contatos';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numeroDaConta = 'numero_da_conta';

  Future<int> salva(Contato contato) async {
    final db = await getDatabase();
    return db.insert(
      _nomeDaTabela,
      {
        _nome: contato.nome,
        _numeroDaConta: contato.numeroDaConta,
      },
    );
  }

  Future<List<Contato>> listaTodos() async {
    final db = await getDatabase();
    final resultados = await db.query(_nomeDaTabela);
    return _paraLista(resultados);
  }

  List<Contato> _paraLista(List<Map<String, dynamic>> resultados) {
    return resultados.map((Map<String, dynamic> linha) {
      final Contato contato =
          Contato(linha[_nome],
              linha[_numeroDaConta],
              linha[_id]);
      return contato;
    }).toList(growable: false);
  }
}
