import 'package:bytebank/infra/database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';

class TransactionDAO {
  static const String createTable = 'CREATE TABLE $_talbeName('
      '$_id INTEGER PRIMARY KEY, '
      '$_value INTEGER, '
      '$_accountNumber INTEGER)';

  static const String _talbeName = 'transactions';
  static const String _id = 'id';
  static const String _value = 'value';
  static const String _accountNumber = 'account_number';

  Future<int> save(Transaction transferencia) async {
    final db = await getDatabase();
    return db.insert(
      _talbeName,
      {
        _value: transferencia.value * 100,
        _accountNumber: transferencia.contactAccountNumber ,
      },
    );
  }

  Future<List<Transaction>> listAll() async {
    final db = await getDatabase();
    final results = await db.query(_talbeName);
    return _toList(results);
  }

  List<Transaction> _toList(List<Map<String, dynamic>> results) {
    return results.map((Map<String, dynamic> row) {
      final Transaction transaction =
          Transaction(row[_value] / 100, Contact(row[_accountNumber], row[_accountNumber]), row[_id]);
      return transaction;
    }).toList(growable: false);
  }
}
