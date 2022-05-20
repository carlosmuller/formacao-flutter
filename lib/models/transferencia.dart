class Transferencia {
  final double _valor;
  final int _numeroConta;


  Transferencia(this._valor, this._numeroConta);


  double get valor => _valor;

  int get numeroConta => _numeroConta;

  String valorFormatado() => 'R\$ $_valor';
  String contaFormatada() => 'Conta: $_numeroConta';

  @override
  String toString() {
    return 'Transferencia{valor: $_valor, numeroConta: $_numeroConta}';
  }
}
