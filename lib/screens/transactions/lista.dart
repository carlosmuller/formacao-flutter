import 'package:bytebank/components/loading.dart';
import 'package:bytebank/components/centralized_message.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {

  TransactionList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransactionListState();
  }
}

class TransactionListState extends State<TransactionList> {
  final TransactionWebClient webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transactionListTitle),
      ),
      body:FutureBuilder<List<Transaction>>(
        initialData: List.empty(growable: false),
        future: webClient.listAll(),
        builder: (context, snapshot) {
          //conteudo retornado da future
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Loading();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if( snapshot.hasData){
                final List<Transaction> transactions = snapshot.data?? List.empty();
                if(transactions.isEmpty){
                  return const CentralizedMessage(
                      mensagem: noTransactions,
                      icone: Icons.warning,
                  );
                }
                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return _ItemTransaction(transaction);
                  },
                );
              }
              return const CentralizedMessage(
                mensagem: noTransactions,
                icone: Icons.warning,
              );
          }
          return UknownErroMessage();
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

class _ItemTransaction extends StatelessWidget {
  final Transaction _transaction;

  const _ItemTransaction(this._transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transaction.value.toString()),
        subtitle: Text(_transaction.contactAccountNumber.toString()),
      ),
    );
  }
}
