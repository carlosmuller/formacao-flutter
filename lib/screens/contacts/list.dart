import 'package:bytebank/components/loading.dart';
import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:bytebank/screens/transactions/form.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactListState();
  }
}

class ContactListState extends State<ContactList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactListTitle),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List.empty(growable: false),
        future: _dao.listAll(),
        builder: (context, snapshot) {
          //conteudo retornado da future
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data!;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _ItemContact(contact, onClick: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                       return TransactionForm(contact: contact);
                    }));
                  },);
                },
              );
          }
          return Text('deu ruim');
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ContactForm();
            })).then((newContact) {

            });
          }),
    );
  }
}

class _ItemContact extends StatelessWidget {
  final Contact _contact;
  final Function onClick;

  const _ItemContact(this._contact,{
      required this.onClick
    });

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
