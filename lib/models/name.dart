import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String?> {
  NameCubit(String? initialState) : super(initialState);

  void change(String? name) => emit(name);

  @override
  void onChange(Change<String?> change) {
    debugPrint('$runtimeType > $change');
    super.onChange(change);
  }
}