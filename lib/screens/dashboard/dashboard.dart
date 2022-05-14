import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:bytebank/textos.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBarDashboard),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _Item(
                textoContatos,
                Icons.people,
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ListaContatos();
                  }));
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _Item(
                tituloAppBarListaTransferencia,
                Icons.people,
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ListaTransferencia();
                  }));
                }
            ),
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final GestureTapCallback _onTap;
  final String _texto;
  final IconData _icon;

  const _Item(this._texto, this._icon, this._onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme
          .of(context)
          .primaryColor,
      child: InkWell(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 100,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _icon,
                color: Colors.white,
                size: 24.0,
              ),
              Text(_texto,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
