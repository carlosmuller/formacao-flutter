import 'dart:convert';

import 'package:bytebank/http/interceptador.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class Cliente {
  Future<Response> get(String uri) async{
    Client client = getHttpClient();
    return client.get(Uri.tryParse(uri)!);
  }

  Client getHttpClient() {
    Client client = InterceptedClient.build(
        interceptors: [LoggingInterceptor()]
    );
    return client;
  }
}

