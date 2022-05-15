import 'package:bytebank/infra/database.dart';
import 'package:bytebank/models/contact.dart';

class ContactDao {
  static const String createTable = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contato) async {
    final db = await getDatabase();
    return db.insert(
      _tableName,
      {
        _name: contato.name,
        _accountNumber: contato.accountNumber,
      },
    );
  }

  Future<List<Contact>> listAll() async {
    final db = await getDatabase();
    final results = await db.query(_tableName);
    return toList(results);
  }

  List<Contact> toList(List<Map<String, dynamic>> results) {
    return results.map((Map<String, dynamic> row) {
      final Contact contact =
          Contact(row[_name],
              row[_accountNumber],
              row[_id]);
      return contact;
    }).toList(growable: false);
  }
}
