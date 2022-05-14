class Transferencia {
  final double _valor;
  final int _numeroDaConta;
  int? _id;

  Transferencia(this._valor, this._numeroDaConta,[this._id]);

  int get numeroDaConta => _numeroDaConta;

  double get valor => _valor;

  int? get id => _id;

  set id(int? id) {
    _id = id;
  }


  @override
  String toString() {
    return 'Transferencia{_valor: $_valor, _numeroConta: $_numeroDaConta, _id: $_id}';
  }
}
