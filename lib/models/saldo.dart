import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier{
  double _valor;


  Saldo(this._valor);

  void adiciona(double valor) {
    _valor += valor;
    notifyListeners();
  }

  void subtrai(double valor) {
    _valor -= valor;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $_valor';
  }
}