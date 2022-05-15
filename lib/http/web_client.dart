import 'package:bytebank/http/intercptors/interceptador.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class WebClient {
  final String _host = 'http://192.168.15.13:8080';
  final Duration? timeout;
  final List<InterceptorContract>? customInterceptors;
  Client? _client;

  WebClient({
    this.timeout = const Duration(seconds: 5),
    this.customInterceptors,
  });

  Future<Response> get(String uri) async {
    return _getClient().get(_mountUri(uri));
  }

  Uri _mountUri(String uri) => Uri.tryParse('$_host$uri')!;

  Future<Response> post(String uri,
      {String? body, Map<String, String>? customHeaders}) async {
    var headers = {
      'Content-type': 'application/json',
    };
    headers.addAll(customHeaders!);
    return await _getClient()
        .post(_mountUri(uri), body: body, headers: headers);
  }

  _getClient() {
    if (_client == null) {
      final List<InterceptorContract> interceptors = [LoggingInterceptor()];
      interceptors.addAll(customInterceptors ?? List.empty());
      _client = InterceptedClient.build(
          interceptors: interceptors, requestTimeout: timeout);
    }
    return _client;
  }
}
