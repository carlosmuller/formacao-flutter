import 'dart:convert';

import 'package:bytebank/exceptions/custom_exceptions.dart';
import 'package:bytebank/http/web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient{
  final String _endpoint = '/transactions';

  final WebClient _client = WebClient();

  Future<List<Transaction>> listAll() async{
    final Response  response= await _client.get(_endpoint);
    return (jsonDecode(response.body) as List)
        .map((item) => Transaction.fromJson(item))
        .toList(growable: false);
  }

  Future<Transaction> save(Transaction transaction, String password) async{
    final Response response = await _client.post(_endpoint,
        body: jsonEncode(transaction.toJson()),
        customHeaders: {
          'password': password
        }
    );
    if(response.statusCode == 200){
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpStatusExceptionMapper[response.statusCode]?? Exception('Status code not expected ${response.statusCode}');
  }
}