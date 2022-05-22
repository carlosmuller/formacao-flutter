import 'dart:convert';

import 'package:bytebank/exceptions/custom_exceptions.dart';
import 'package:bytebank/texts.dart';
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

  Future<Transaction?> save(Transaction transaction, String password) async{
    Future.delayed(Duration(seconds: 3));
    final Response response = await _client.post(_endpoint,
        body: jsonEncode(transaction.toJson()),
        customHeaders: {
          'password': password
        }
    );
    if(response.statusCode == 200){
      return Transaction.fromJson(jsonDecode(response.body));
    }
    final statusCode = response.statusCode;
    throw _httpStatusExceptionMapper[statusCode] ?? Exception(unknownErrorMessage);
  }



  final Map<int, HttpException>  _httpStatusExceptionMapper = {
    400: HttpBadRequestException(transactionShouldHaveValue),
    401: HttpUnauthorizedException(authenticationError),
    409: HttpConflictException(transactionAlreadyExists)
  };

}