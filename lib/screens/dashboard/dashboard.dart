import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Consumer<Saldo>(builder: (context, saldo, child) {
              return ElevatedButton(
                onPressed: () => saldo.adiciona(5.0),
                child: Text('Adiciona'),
              );
            })
          ],
        ),
      ),
    );
  }
}
