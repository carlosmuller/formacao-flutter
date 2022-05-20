import 'package:bytebank/screens/dashboard/saldo.dart';
import 'package:bytebank/screens/dashboard/ultimasTransferencias.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SaldoCard(),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FormularioDeposito();
                        },
                      ),
                    );
                  },
                  child: Text('Receber depósito'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FormularioTransferencia();
                        },
                      ),
                    );
                  },
                  child: Text('Nova Transferencia'),
                ),
              ],
            ),
            UltimasTransferencias(),
          ],
        ),
      ),
    );
  }
}
