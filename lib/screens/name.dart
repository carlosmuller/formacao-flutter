import 'package:bytebank/components/editor.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String> {
  NameCubit(String initialState) : super(initialState);

  void change(String name) => emit(name);

  @override
  void onChange(Change<String> change) {
    debugPrint('$runtimeType > $change');
    super.onChange(change);
  }
}

class NameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Fulano"),
      child: NameView(),
    );
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
                onPressed: (){
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
