class Contact{
  static const _jsonIdField = 'id';
  static const _jsonNameField = 'name';
  static const _jsonAccountNumberField = 'accountNumber';

  final String _name;
  final int _accountNumber;
  int? _id;

  Contact(this._name, this._accountNumber,[this._id]);

  int get accountNumber => _accountNumber;

  String get name => _name;

  int? get id => _id;

  set id(int? id) {
    _id = id;
  }

  @override
  String toString() {
    return 'Contato{_nome: $_name, _numeroDaConta: $_accountNumber}';
  }

  Map<String, dynamic> toJson() => {
      _jsonNameField: _name,
      _jsonAccountNumberField: _accountNumber
    };


  Contact.fromJson(Map<String, dynamic> json):
    _id= json[_jsonIdField],
    _name= json[_jsonNameField],
    _accountNumber= json[_jsonAccountNumberField];


}