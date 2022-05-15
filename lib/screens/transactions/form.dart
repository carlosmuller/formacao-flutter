import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm({Key? key, required this.contact})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransactionFormState();
  }
}

class TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient =  TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(transactionFormTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Editor(
                  controller: _valueController,
                  label: valueFieldLabel,
                  hint: valueFieldHint,
                  icon: Icons.monetization_on,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(transactionFormAction),
                    onPressed: () => _saveTransaction(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction(BuildContext context) {
    final double? value = double.tryParse(_valueController.text);
    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(transactionShouldHaveValue))
      );
      return;
    }
    final transaction = Transaction(value, widget.contact);
    _webClient.save(transaction).then((transctionFromClient) {
      if(transctionFromClient != null){
        Navigator.of(context).pop();
      }
    });
  }
}
