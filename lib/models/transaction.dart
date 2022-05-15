import 'package:bytebank/models/contact.dart';

class Transaction {
  final double _value;
  final Contact _contact;
  int? _id;

  static const _jsonValueField = 'value';
  static const _jsonContactField = 'contact';


  Transaction(this._value, this._contact, [this._id]);

  int get contactAccountNumber => _contact.accountNumber;

  double get value => _value;

  int? get id => _id;

  set id(int? id) {
    _id = id;
  }

  @override
  String toString() {
    return 'Transferencia{_valor: $_value, contato: $_contact, _id: $_id}';
  }

  Transaction.fromJson(Map<String, dynamic> transactionJson):
    _value = transactionJson[_jsonValueField],
    _contact = Contact.fromJson(transactionJson[_jsonContactField]);

  Map<String, dynamic> toJson() => {
      _jsonValueField: value,
      _jsonContactField: _contact.toJson()
    };
}
