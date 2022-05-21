import 'package:bytebank/screens/contacts/list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions/lista.dart';
import 'package:bytebank/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({Key? key}) : super(key: key);

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
    return BlocBuilder<NameCubit, String?>(
      builder: (context, String? state) {
        var title = '$dashboardTitle ${state ?? ""}!';
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(
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
                    _Item(
                      contactsText,
                      Icons.monetization_on,
                      () => _goToContacts(context),
                    ),
                    _Item(
                      transactionListTitle,
                      Icons.description,
                      () => _goToTransactionList(context),
                    ),
                    _Item(
                      titleAppBarChangeName,
                      Icons.person_outline,
                      () => _showChangeName(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _goToContacts(BuildContext blocContext) {
    Navigator.of(blocContext).push(MaterialPageRoute(builder: (context) {
      return ContactList();
    }));
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

class _Item extends StatelessWidget {
  final Function _onTap;
  final String _texto;
  final IconData _icon;

  const _Item(this._texto, this._icon, this._onTap, {Key? key})
      : super(key: key);

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
                Text(_texto,
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
