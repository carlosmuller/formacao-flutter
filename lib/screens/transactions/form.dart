import 'dart:async';

import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/exceptions/custom_exceptions.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:bytebank/infra/firebaseHelper.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/texts.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  final double? value;

  const ShowFormState({this.value});
}

@immutable
class SendingFormState extends TransactionFormState {
  const SendingFormState();
}

@immutable
class SentFormState extends TransactionFormState {
  const SentFormState();
}

@immutable
class FatalErrorTransactionFormState extends TransactionFormState {
  final String _message;
  final StackTrace _stacktrace;
  final Transaction _transaction;
  final _error;

  const FatalErrorTransactionFormState(
      this._error, this._message, this._stacktrace, this._transaction);

  StackTrace get stacktrace => _stacktrace;

  String get message => _message;

  Transaction get transaction => _transaction;

  get error => _error;
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit(TransactionFormState initialState)
      : super(ShowFormState());

  Future<void> save(Transaction newTransaction, String password, TransactionWebClient client) async {
    emit(SendingFormState());
    await client
        .save(newTransaction, password)
        .then((value) => emit(SentFormState()))
        .catchError(
      (error, stacktrace) async {
        emit(FatalErrorTransactionFormState(
            error, error.message, stacktrace, newTransaction));
      },
      test: (e) => e is HttpException,
    ).catchError(
      (error, stacktrace) async {
        emit(FatalErrorTransactionFormState(
            error, error.message, stacktrace, newTransaction));
      },
      test: (e) => e is TimeoutException,
    ).catchError(
      (error, stacktrace) async {
        emit(FatalErrorTransactionFormState(
            error, error.message, stacktrace, newTransaction));
      },
      test: (e) => e is Exception,
    );
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact contact;

  TransactionFormContainer({required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (_) => TransactionFormCubit(ShowFormState()),
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (context, state) {
          if (state is SentFormState) {
            Navigator.pop(context);
          }
        },
        listenWhen: (oldState, newState) =>
            oldState is SendingFormState && newState is SentFormState,
        child: TransactionForm(contact),
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final _contact;

  TransactionForm(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, TransactionFormState state) {
        if (state is ShowFormState) {
          return _BasicForm(_contact, value: state.value);
        }
        if (state is SendingFormState || state is SentFormState) {
          return ProgressView(
            title: transactionFormTitle,
            message: sendingTransaction,
          );
        }
        if (state is FatalErrorTransactionFormState) {
          sendToFireBase({'http_body': state.transaction.toJson().toString()},
              state.error, state.stacktrace);
          return ErrorView(state.message, () {
            context
                .read<TransactionFormCubit>()
                .emit(ShowFormState(value: state.transaction.value));
          });
        }
        return _BasicForm(_contact);
      },
    );
  }
}

class _BasicForm extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  final Contact _contact;

  final double? value;

  _BasicForm(this._contact, {Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      _valueController.value = TextEditingValue(text: value.toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(transactionFormTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Editor(
                  controller: _valueController,
                  label: valueFieldLabel,
                  hint: valueFieldHint,
                  icon: Icons.monetization_on,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(transactionFormAction),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (password) async {
                            final double? value =
                                double.tryParse(_valueController.text);
                            if (value == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(transactionShouldHaveValue)));
                              return;
                            }
                            final newTransaction =
                                Transaction(value, _contact, transactionId);
                            final transactionWebClient = AppDependencies.of(context)!.transactionWebClient;
                            await BlocProvider.of<TransactionFormCubit>(context)
                                .save(newTransaction, password, transactionWebClient);
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
