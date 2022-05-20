import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNumeroConta,
                dica: _dicaCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
              ),
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text(_textoBotaoConfirmar),
                onPressed: () => _criaTransferencia(context),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (!_validaTransferencia(numeroConta, valor, context)) {
      _showErrorSnackBar(context, 'Valores Invalidos');
      return;
    }
    final bool saldoSuficiente =
        Provider.of<Saldo>(context, listen: false).temSaldoSuficiente(valor!);

    if (!saldoSuficiente) {
      _showErrorSnackBar(context, 'Saldo insuficiente!');
      return;
    }
    final transferenciaCriada = Transferencia(valor, numeroConta!);
    _atualizaEstado(context, transferenciaCriada);
    Navigator.pop(context);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _atualizaEstado(
      BuildContext context, Transferencia transferenciaCriada) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(transferenciaCriada);
    Provider.of<Saldo>(context, listen: false)
        .subtrai(transferenciaCriada.valor);
  }

  bool _validaTransferencia(int? numeroConta, double? valor, context) {
    final valoresPreenchidos = numeroConta != null && valor != null;
    return valoresPreenchidos;
  }
}
