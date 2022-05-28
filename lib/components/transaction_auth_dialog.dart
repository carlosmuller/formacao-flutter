import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const transactionAuthDialogTextFieldPasswordKey = Key('transactionAuthDialogTextFieldPassword');
class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(authDialogTitle),
      content: TextField(
        key: transactionAuthDialogTextFieldPasswordKey,
        obscureText: true,
        maxLength: 4,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        controller: _passwordController,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              cancel,
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.of(context).pop();
          },
          child: const Text(confirm),
        )
      ],
    );
  }
}
