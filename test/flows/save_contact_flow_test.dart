import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_web_client.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:bytebank/screens/contacts/list.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import 'actions.dart';
import 'save_contact_flow_test.mocks.dart';


@GenerateMocks([ContactDao, TransactionWebClient])
void main() {
  testWidgets('Should save a contact', (widgetTester) async {
    final mockedContactDao = MockContactDao();
    var count = 0;
    when(mockedContactDao.listAll()).thenAnswer((_) async {
      ++count;
      print('Chamei listAll $count vezes');
      return List<Contact>.empty();
    });
    when(mockedContactDao.save(any)).thenAnswer((_) async => 1);
    await widgetTester.pumpWidget(BytebankApp(
      contactDao: mockedContactDao,
      transactionWebClient: MockTransactionWebClient(),
    ));
    final dashboard = find.byType(DashboardView);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate(
      (widget) =>
          featureItemMatcher(widget, 'Transferir', Icons.monetization_on),
    );
    expect(transferFeatureItem, findsOneWidget);

    await clickOnTransferFeatureItem(widgetTester);
    await widgetTester.pumpAndSettle();

    final contactList = find.byType(ContactListContainer);
    expect(contactList, findsOneWidget);
    verify(mockedContactDao.listAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await widgetTester.tap(fabNewContact);
    await widgetTester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate(
      (widget) => textFieldByLabelTextMatcher(widget, 'Nome completo'),
    );
    expect(nameTextField, findsOneWidget);
    await widgetTester.enterText(nameTextField, 'Alex');

    final accountNumberTextField = find.byWidgetPredicate(
      (widget) => textFieldByLabelTextMatcher(widget, 'Numero da conta'),
    );

    expect(accountNumberTextField, findsOneWidget);
    await widgetTester.enterText(accountNumberTextField, '1000');

    final createButton = find.widgetWithText(ElevatedButton, 'Criar');
    expect(createButton, findsOneWidget);
    await widgetTester.tap(createButton);
    await widgetTester.pumpAndSettle();

    verify(mockedContactDao.save(Contact('Alex', 1000))).called(1);
    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
    await widgetTester.pumpAndSettle();
    //gambeta para subistituir o verify com 2 pois ele não está vendo que foi chamado duas vezes
    expect(count,2);
  });
}
