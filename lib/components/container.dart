import 'package:flutter/material.dart';

abstract class BlocContainer extends StatelessWidget {}

void push(BuildContext blocContext, BlocContainer container) {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) {
        return container;
      },
    ),
  );
}
