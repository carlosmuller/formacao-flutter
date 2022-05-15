import 'package:bytebank/components/carregando.dart';
import 'package:bytebank/components/mensagem_centralizada.dart';
import 'package:bytebank/dao/transferencia_dao.dart';
import 'package:bytebank/http/cliente_web.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:bytebank/service/tranferencia_service.dart';
import 'package:bytebank/textos.dart';
import 'package:flutter/material.dart';

class ListaTransferencia extends StatefulWidget {

  ListaTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBarListaTransferencia),
      ),
      body:FutureBuilder<List<Transferencia>>(
        initialData: List.empty(growable: false),
        future: TransferenciaService().listaTransacoes(),
        builder: (context, snapshot) {
          //conteudo retornado da future
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Carregando();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if( snapshot.hasData){
                final List<Transferencia> transferencias = snapshot.data?? List.empty();
                if(transferencias.isEmpty){
                  return const MensagemCentralizada(
                      mensagem: textoSemTransferencia,
                      icone: Icons.warning,
                  );
                }
                return ListView.builder(
                  itemCount: transferencias.length,
                  itemBuilder: (context, indice) {
                    final transferencia = transferencias[indice];
                    return ItemTransferencia(transferencia);
                  },
                );
              }
              return const MensagemCentralizada(
                mensagem: textoSemTransferencia,
                icone: Icons.warning,
              );
          }
          return MensagemErroInesperado();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //         return FormularioTransferencia();
      //       })).then(
      //           (transferenciaRecebida) => _atualiza(transferenciaRecebida));
      //     }),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroDaConta.toString()),
      ),
    );
  }
}
