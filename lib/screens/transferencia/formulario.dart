import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/styles.dart';
import 'package:bytebank/dao/contato_dao.dart';
import 'package:bytebank/dao/transferencia_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/textos.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  // const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroDaConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  Contato? _contato;
  List<Contato> _contatos = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    ContatoDao().listaTodos().then((contatos) {
      this._contatos = contatos;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(tituloAppBarFormularioTransferencia),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Autocomplete<Contato>(
              // fieldViewBuilder: ,
              displayStringForOption: (Contato contato) =>
                  '${contato.nome} - ${contato.numeroDaConta}',
              optionsBuilder: (_controladorCampoNumeroDaConta) {
                if (_controladorCampoNumeroDaConta.text == '') {
                  debugPrint('vazio');
                  return List.empty();
                }
                return _contatos.where((Contato contato) {
                  final textoDigitado =
                      _controladorCampoNumeroDaConta.text.toLowerCase();
                  return contato.numeroDaConta == int.tryParse(textoDigitado) ||
                      contato.nome.contains(textoDigitado);
                });
              },
              onSelected: (Contato contato) {
                debugPrint('Você selecionou ${contato}');
                _contato = contato;
              },

              // controlador: _controladorCampoNumeroDaConta,
              // rotulo: rotuloCampoNumeroConta,
              // dica: dicaCampoNumeroConta,
              // tipoTeclado: TextInputType.number,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: rotuloCampoValor,
              dica: dicaCampoValor,
              icone: Icons.monetization_on,
              tipoTeclado: TextInputType.number,
            ),
            ElevatedButton(
              child: Text(confirmar),
              onPressed: () => _criaTransferencia(context),
              style: acaoPrimariaPositiva(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (_contato == null || valor == null) {
      debugPrint('${_contato} - ${valor}');
      return;
    }
    final transferenciaCriada = Transferencia(valor, _contato!);
    TransferenciaDAO()
        .salva(transferenciaCriada)
        .then((value) => Navigator.pop(context, transferenciaCriada));
  }
}
