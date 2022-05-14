import 'dart:convert';

import 'package:bytebank/http/interceptador.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Future<List<Transferencia>> listaTransacoes() async{
  Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()]
  );
  final Response response = await client.get(Uri.tryParse('http://192.168.15.13:8080/transactions')!);
  return (jsonDecode(response.body) as List)
      .map((item) => Transferencia.doJson(item)).toList(growable: false);
}