import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/styles.dart';
import 'package:bytebank/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/textos.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  const FormularioContato({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioContatoState();
  }
}

class FormularioContatoState extends State<FormularioContato> {
  final ContatoDao _dao = ContatoDao();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroDaContaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBarFormularioContato),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                rotulo: rotuloCampoContatoNome,
                controlador: _nomeController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Editor(
                  controlador: _numeroDaContaController,
                  rotulo: rotuloCampoNumeroConta,
                  dica: dicaCampoNumeroConta,
                  tipoTeclado: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(criarContato),
                    onPressed: () {
                      final String? nome = _nomeController.text;
                      final int? numeroDaconta =
                          int.tryParse(_numeroDaContaController.text);
                      if (nome == null || numeroDaconta == null) {
                        return;
                      }
                      final contato = Contato(nome, numeroDaconta);
                      _dao.salva(contato).then((id) {
                        contato.id = id;
                        Navigator.pop(context, contato);
                      });
                    },
                    style: acaoPrimariaPositiva(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
