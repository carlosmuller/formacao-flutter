import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;
  const Loading({Key? key, this.message = loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message, style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    );
  }
}
