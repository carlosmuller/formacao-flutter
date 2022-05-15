import 'package:bytebank/models/contact.dart';

class Transaction {
  final double _value;
  final Contact _contact;
  int? _id;

  static const _jsonValueField = 'value';
  static const _jsonContactField = 'contact';
  static const _jsonContactNameField = 'name';
  static const _jsonContactAccountNumberField = 'accountNumber';

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

  static Transaction fromJson(transactionJson) {
    final value = transactionJson[_jsonValueField];
    final contactJson = transactionJson[_jsonContactField];
    return Transaction(
        value,
        Contact(contactJson[_jsonContactNameField],
            contactJson[_jsonContactAccountNumberField])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _jsonValueField: value,
      _jsonContactField: {
        _jsonContactNameField: _contact.name,
        _jsonContactAccountNumberField: _contact.accountNumber
      }
    };
  }
}
