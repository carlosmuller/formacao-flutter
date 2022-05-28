import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts/list.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:bytebank/screens/transactions/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import 'actions.dart';
import 'transfer_flow_test.mocks.dart';

@GenerateMocks([ContactDao, TransactionWebClient, Transaction])
void main() {
  testWidgets('Should transfer to a contact', (widgetTester) async {
    final mockedContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    when(mockTransactionWebClient.save(any, any))
        .thenAnswer((realInvocation) async => MockTransaction());
    var count = 0;
    when(mockedContactDao.listAll()).thenAnswer((_) async {
      ++count;
      print('Chamei listAll $count vezes');
      return [Contact('Alex', 1000)];
    });
    await widgetTester.pumpWidget(BytebankApp(
      contactDao: mockedContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));
    final dashboard = find.byType(DashboardView);
    expect(dashboard, findsOneWidget);

    await clickOnTransferFeatureItem(widgetTester);
    await widgetTester.pumpAndSettle();

    final contactList = find.byType(ContactListContainer);
    expect(contactList, findsOneWidget);
    verify(mockedContactDao.listAll()).called(1);
    final contactItem = find.byWidgetPredicate(
      (widget) => findContactInList(widget, 'Alex', 1000),
    );
    expect(contactItem, findsOneWidget);
    await widgetTester.tap(contactItem);
    await widgetTester.pumpAndSettle();

    final transactionForm = find.byType(TransactionFormContainer);
    expect(transactionForm, findsOneWidget);

    final valueField = find.byWidgetPredicate(
      (widget) => textFieldByLabelTextMatcher(widget, 'Valor'),
    );
    expect(valueField, findsOneWidget);
    await widgetTester.enterText(valueField, '500');

    final createTransactionButton =
        find.widgetWithText(ElevatedButton, 'Criar Transação');
    expect(createTransactionButton, findsOneWidget);
    await widgetTester.tap(createTransactionButton);
    await widgetTester.pumpAndSettle();

    final passwordField = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.obscureText,
    );
    expect(passwordField, findsOneWidget);
    await widgetTester.enterText(passwordField, '1000');

    final confirmButton = find.widgetWithText(TextButton, 'confirm');
    expect(passwordField, findsOneWidget);

    await widgetTester.tap(confirmButton);
    await widgetTester.pumpAndSettle();

    final contactListBack = find.byType(ContactListContainer);
    expect(contactListBack, findsOneWidget);

    final contactItemBack = find.byWidgetPredicate(
          (widget) => findContactInList(widget, 'Alex', 1000),
    );
    expect(contactItemBack, findsOneWidget);
  });
}

bool findContactInList(
    Widget widget, String contactName, int contactAccountNumber) {
  if (widget is ContactItem) {
    return widget.contactName == contactName &&
        widget.contactAccountNumber == contactAccountNumber;
  }
  return false;
}
