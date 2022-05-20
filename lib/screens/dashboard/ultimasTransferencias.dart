import 'dart:math';

import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Últimas transferências',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            if (transferencias.vazia) {
              return SemTransferenciaCadastrada();
            }
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: min(3, transferencias.length),
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                final transferencia = transferencias.getReversed(indice);
                return ItemTransferencia(transferencia);
              },
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListaTransferencias();
                },
              ),
            );
          },
          child: Text('Transferencias'),
        ),
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Sem transfêrencia cadastrada',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
