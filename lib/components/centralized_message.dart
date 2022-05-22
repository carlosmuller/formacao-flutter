import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class CentralizedMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double iconSize;
  final double fontSize;

  const CentralizedMessage(
      {Key? key,
      required this.message,
      this.icon,
      this.iconSize = 64,
      this.fontSize = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null,
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Text(
              message,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}

class UnknownErrorMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CentralizedMessage(
        message: unknownErrorMessage, icon: Icons.error);
  }
}
