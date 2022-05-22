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
            child: Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressView extends StatelessWidget {
  final String title;
  final String message;

  ProgressView({this.title = loading, this.message = loading});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Loading(
          message: message,
        ),
      ),
    );
  }
}
