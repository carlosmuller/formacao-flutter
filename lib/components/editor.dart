import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType? tipoTeclado;

  const Editor(
      {Key? key, this.controlador, this.rotulo, this.dica, this.icone, this.tipoTeclado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
            icon: icone != null? Icon(icone): null, labelText: rotulo, hintText: dica),
        keyboardType: tipoTeclado ?? TextInputType.text,
      ),
    );
  }
}
