import 'dart:convert';

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

  Future<Transaction> save(Transaction transaction) async{
    final Response response = await _client.post(_endpoint,
        body: jsonEncode(transaction.toJson())
    );
    return Transaction.fromJson(jsonDecode(response.body));
  }
}