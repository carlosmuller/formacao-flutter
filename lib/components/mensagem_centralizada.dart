import 'package:flutter/material.dart';

class MensagemCentralizada extends StatelessWidget {
  final String mensagem;
  final IconData? icone;
  final double tamanhoDoIcone;
  final double tamanhoDaFonte;

  const MensagemCentralizada(
      {Key? key,
      required this.mensagem,
      this.icone,
      this.tamanhoDoIcone = 64,
      this.tamanhoDaFonte = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            child: Icon(
              icone,
              size: tamanhoDoIcone,
            ),
            visible: icone != null,
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Text(
              mensagem,
              style: TextStyle(fontSize: tamanhoDaFonte),
            ),
          ),
        ],
      ),
    );
  }
}

class MensagemErroInesperado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MensagemCentralizada(
        mensagem: 'Erro inesperado', icone: Icons.error);
  }
}
