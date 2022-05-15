import 'dart:convert';

import 'package:bytebank/http/interceptador.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class Cliente {
  final String _host = 'http://192.168.15.13:8080';
  final Duration? timeout;

  Cliente({this.timeout});
  Future<Response> get(String uri) async{
    Client client = getHttpClient();
    return client.get(Uri.tryParse('$_host$uri')!).timeout(timeout?? const Duration(seconds: 5));
  }

  Client getHttpClient() {
    Client client = InterceptedClient.build(
        interceptors: [LoggingInterceptor()]
    );
    return client;
  }
}

