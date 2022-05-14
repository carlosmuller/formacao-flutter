import 'package:bytebank/components/carregando.dart';
import 'package:bytebank/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:bytebank/textos.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaContatosState();
  }
}

class ListaContatosState extends State<ListaContatos> {
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBarContatos),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: List.empty(growable: false),
        future: _dao.listaTodos(),
        builder: (context, snapshot) {
          //conteudo retornado da future
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Carregando();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data!;
              return ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (context, indice) {
                  final contato = contatos[indice];
                  return _ContatoItem(contato);
                },
              );
          }
          return Text('deu ruim');
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioContato();
            })).then((contatoRecebido) {
              setState(() {});
            });
          }),
    );
  }
}

class _ContatoItem extends StatelessWidget {
  final Contato _contato;

  const _ContatoItem(this._contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _contato.nome,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _contato.numeroDaConta.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
