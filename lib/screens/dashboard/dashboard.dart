import 'package:bytebank/components/container.dart';
import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/contacts/list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions/lista.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit(null),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String?>(
          builder: (context, String? state) {
            var title = '$dashboardTitle ${state ?? ""}!';
            return Text(title);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/bytebank_logo.png'),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FeatureItem(
                          contactsText,
                          Icons.monetization_on,
                          () => _goToContacts(context),
                        ),
                        FeatureItem(
                          transactionListTitle,
                          Icons.description,
                          () => _goToTransactionList(context),
                        ),
                        FeatureItem(
                          titleAppBarChangeName,
                          Icons.person_outline,
                          () => _showChangeName(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _goToContacts(BuildContext blocContext) {
    push(
      blocContext,
      ContactListContainer(),
    );
  }

  _goToTransactionList(BuildContext blocContext) {
    Navigator.of(blocContext).push(MaterialPageRoute(builder: (context) {
      return TransactionList();
    }));
  }

  _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider.value(
            value: BlocProvider.of<NameCubit>(blocContext),
            child: NameContainer(),
          );
        },
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final Function _onTap;
  final String _name;
  final IconData _icon;

  const FeatureItem(this._name, this._icon, this._onTap, {Key? key})
      : super(key: key);

  String get name => _name;

  IconData get icon => _icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => _onTap(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(_name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
