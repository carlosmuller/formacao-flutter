class Contato{
  final String _nome;
  final int _numeroDaConta;
  int? _id;

  Contato(this._nome, this._numeroDaConta,[this._id]);

  int get numeroDaConta => _numeroDaConta;

  String get nome => _nome;

  int? get id => _id;

  set id(int? id) {
    _id = id;
  }

  @override
  String toString() {
    return 'Contato{_nome: $_nome, _numeroDaConta: $_numeroDaConta}';
  }
}