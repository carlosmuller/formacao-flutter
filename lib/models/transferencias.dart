import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class Transferencias extends ChangeNotifier{
  final List<Transferencia> _transferencias = List.empty(growable: true);


  List<Transferencia> get transferencias => _transferencias;

  get length => _transferencias.length;

  void adiciona(Transferencia transferencia){
    _transferencias.add(transferencia);
    notifyListeners();
  }

  Transferencia get(int indice) => _transferencias[indice];


}