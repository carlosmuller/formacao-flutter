import 'package:bytebank/http/intercptors/interceptador.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class WebClient {
  final String _host = 'http://192.168.15.13:8080';
  final Duration? _timeout;
  final Client _client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  WebClient([this._timeout]);

  Future<Response> get(String uri) async {
    return _client
        .get(_mountUri(uri))
        .timeout(_timeout ?? const Duration(seconds: 5));
  }

  Uri _mountUri(String uri) => Uri.tryParse('$_host$uri')!;

  Future<Response> post(String uri,
      {String? body, Map<String, String>? headers}) async {
    return await _client.post(_mountUri(uri), body: body, headers: {
      'Content-type': 'application/json',
      'password': '1000'
    }).timeout(_timeout ?? const Duration(seconds: 5));
  }
}
