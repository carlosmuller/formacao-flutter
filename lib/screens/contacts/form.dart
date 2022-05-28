import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/styles.dart';
import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/texts.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {

  const ContactForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactFormState();
  }
}

class ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  ContactFormState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactFormTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                label: contactNameLabel,
                controller: _nameController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Editor(
                  controller: _accountNumberController,
                  label: accountNumberLabel,
                  hint: dicaCampoNumeroConta,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text(createContact),
                    onPressed: () async {
                      final String? name = _nameController.text;
                      final int? accountNumber =
                          int.tryParse(_accountNumberController.text);
                      if (name == null || accountNumber == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(cotactShouldHaveNameAndAccountNumber)));
                        return;
                      }
                      final contact = Contact(name, accountNumber);
                      final contactDao = AppDependencies.of(context)!.contactDao;
                      await contactDao.save(contact).then((id) {
                        contact.id = id;
                      });
                      Navigator.pop(context);
                    },
                    style: positivePrimaryAction(context),
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
