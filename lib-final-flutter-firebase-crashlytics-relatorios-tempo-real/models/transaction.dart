import 'package:bytebank/models/contact.dart';

class Transaction {
  final double _value;
  final Contact _contact;
  final String _id;

  static const _jsonIdField = 'id';
  static const _jsonValueField = 'value';
  static const _jsonContactField = 'contact';


  Transaction(this._value, this._contact, this._id);

  int get contactAccountNumber => _contact.accountNumber;

  double get value => _value;


  @override
  String toString() {
    return 'Transferencia{_valor: $_value, contato: $_contact, _id: $_id}';
  }

  Transaction.fromJson(Map<String, dynamic> transactionJson):
    _id = transactionJson[_jsonIdField],
    _value = transactionJson[_jsonValueField],
    _contact = Contact.fromJson(transactionJson[_jsonContactField]);

  Map<String, dynamic> toJson() => {
      _jsonIdField: _id,
      _jsonValueField: value,
      _jsonContactField: _contact.toJson()
    };
}
