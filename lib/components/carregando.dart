import 'package:bytebank/textos.dart';
import 'package:flutter/material.dart';

class Carregando extends StatelessWidget {
  const Carregando({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(carregando),
        ],
      ),
    );
  }
}
