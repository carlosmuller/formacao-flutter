import 'dart:async';

import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/reponse_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/exceptions/custom_exceptions.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransactionFormState();
  }
}

class TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    print('Transação id: $transactionId');
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (password) {
                            _saveTransaction(context, password);
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction(BuildContext context, String password) async {
    final double? value = double.tryParse(_valueController.text);
    if (value == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(transactionShouldHaveValue)));
      return;
    }
    final Transaction transaction = await _webClient
        .save(Transaction(value, widget.contact, transactionId), password)
        .catchError((e) => _showFailureDialog(context, message: couldNotContactTheServer), test: (e) => e is TimeoutException)
        .catchError((e) => _showFailureDialog(context, message: e.message), test: (e) => e is HttpException)
        .catchError((e) => _showFailureDialog(context), test: (e) => e is Exception);


    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog(succesOnCreate);
          });
      Navigator.of(context).pop();
    }
  }

  Future _showFailureDialog(BuildContext context, {String message = unknownErrorMessage}) async {
    await showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
    });
  }
}
