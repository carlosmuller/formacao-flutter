import 'dart:convert';

import 'package:bytebank/http/cliente_web.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

class TransferenciaService{
  final Cliente _cliente = Cliente();
  Future<List<Transferencia>> listaTransacoes() async{
    final Response  response= await _cliente.get('http://192.168.15.13:8080/transactions');
    return (jsonDecode(response.body) as List)
        .map((item) => Transferencia.doJson(item)).toList(growable: false);
  }
}