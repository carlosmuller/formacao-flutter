import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clickOnTransferFeatureItem(WidgetTester widgetTester) async {
  final transferFeatureItem = find.byWidgetPredicate(
    (widget) => featureItemMatcher(widget, 'Transferir', Icons.monetization_on),
  );
  expect(transferFeatureItem, findsOneWidget);
  return widgetTester.tap(transferFeatureItem);
}
