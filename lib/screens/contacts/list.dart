import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:bytebank/screens/transactions/form.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class ContactListState {
  const ContactListState();
}

@immutable
class LoadingContactsListState extends ContactListState {
  const LoadingContactsListState();
}

@immutable
class InitContactListState extends ContactListState {
  const InitContactListState();

  void reload() {}
}

@immutable
class FatalErrorContactsListState extends ContactListState {
  const FatalErrorContactsListState();
}

@immutable
class LoadedContactsListState extends ContactListState {
  final List<Contact> _contacts;

  const LoadedContactsListState(this._contacts);

  List<Contact> get contacts => _contacts;
}

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit() : super(InitContactListState());

  void reload(ContactDao dao) async {
    emit(LoadingContactsListState());
    await Future.delayed(Duration(seconds: 1));
    dao.listAll().onError((error, stackTrace) {
      emit(FatalErrorContactsListState());
      return List.empty();
    }).then((contacts) => emit(LoadedContactsListState(contacts)));
  }
}

class ContactListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    final ContactDao dao = ContactDao();
    return BlocProvider<ContactListCubit>(
      create: (BuildContext context) {
        final cubit = ContactListCubit();
        cubit.reload(dao);
        return cubit;
      },
      child: ContactList(dao: dao),
    );
  }
}

class ContactList extends StatelessWidget {
  final ContactDao dao;

  const ContactList({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactListTitle),
      ),
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (context, state) {
          if (state is InitContactListState ||
              state is LoadingContactsListState) {
            return Loading();
          }
          if (state is LoadedContactsListState) {
            final contacts = state.contacts;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return _ItemContact(
                  contact,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return TransactionForm(contact: contact);
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
          return Text(unknownErrorMessage);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ContactForm();
              },
            ),
          );
          update(context);
        },
      ),
    );
  }

  void update(BuildContext context) {
     context.read<ContactListCubit>().reload(dao);
  }
}

class _ItemContact extends StatelessWidget {
  final Contact _contact;
  final Function onClick;

  const _ItemContact(this._contact, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          _contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
