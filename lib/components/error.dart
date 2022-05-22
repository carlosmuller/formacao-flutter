import 'package:bytebank/components/centralized_message.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String _message;

  const ErrorView(this._message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(error),
      ),
      body: CentralizedMessage(
        message: _message,
        icon: Icons.error,
      ),
    );
  }
}
