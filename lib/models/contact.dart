class Contact{
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
}