import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  @immutable
  const AppDependencies({
    required Widget child,
    required this.contactDao,
    required this.transactionWebClient,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao || transactionWebClient != oldWidget.transactionWebClient;
  }

  static AppDependencies? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }
}
