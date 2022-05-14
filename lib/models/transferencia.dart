import 'package:bytebank/models/contato.dart';

class Transferencia {
  final double _valor;
  final Contato _contato;
  int? _id;

  Transferencia(this._valor, this._contato,[this._id]);

  int get numeroDaConta => this._contato.numeroDaConta;

  double get valor => _valor;

  int? get id => _id;

  set id(int? id) {
    _id = id;
  }


  @override
  String toString() {
    return 'Transferencia{_valor: $_valor, contato: $_contato, _id: $_id}';
  }

  static Transferencia doJson(transferenciaJson) {
    final  valor = transferenciaJson['value'];
    final contatoJson = transferenciaJson['contact'];
    return Transferencia(valor, Contato(contatoJson['name'], contatoJson['accountNumber']));
  }
}
