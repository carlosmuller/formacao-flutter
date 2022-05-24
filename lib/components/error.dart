import 'package:bytebank/components/centralized_message.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String _message;
  final Function? _action;
  const ErrorView(this._message, this._action);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(error),
      ),
      body: Column(
        children: [
          CentralizedMessage(
            message: _message,
            icon: Icons.error,
          ),
          Visibility(
              child: ElevatedButton(
                onPressed: () => _action!(),
                child: Text(back),
              ),
            visible: _action != null,
          )
        ],
      ),
    );
  }
}
