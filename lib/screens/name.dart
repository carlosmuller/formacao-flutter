import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/name.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatelessWidget {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(titleAppBarChangeName),
      ),
      body: Column(
        children: [
          Editor(
            controller: _nameController,
            hint: desiredName,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  context.read<NameCubit>().change(name);
                  Navigator.pop(context);
                },
                child: Text(change),
              ),
            ),
          )
        ],
      ),
    );
  }
}
