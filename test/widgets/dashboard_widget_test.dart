import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'dashboard_widget_test.mocks.dart';
import '../matchers/matchers.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets(
    'Should display logo when the dashboard is opened',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: DashboardContainer(),
        ),
      );
      final findMainImage = find.byType(Image);
      expect(findMainImage, findsOneWidget);
      final mainImage = findMainImage.evaluate().single.widget as Image;
      if (mainImage.image is AssetImage) {
        final image = mainImage.image as AssetImage;
        expect(image.assetName, 'images/bytebank_logo.png');
      }
    },
  );

  testWidgets(
    'Should display the features when Dashboard is opened',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: DashboardContainer(),
        ),
      );
      final finderFeatureItem = find.byType(FeatureItem);
      final featureItems = finderFeatureItem.evaluate();
      expect(featureItems.isEmpty, false);
      expect(featureItems.length, 3);
    },
  );

  testWidgets(
    'Should display the transfer feature when Dashboard is opened',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: DashboardContainer(),
        ),
      );
      final transferFeatureItem = find.byWidgetPredicate(
        (widget) =>
            featureItemMatcher(widget, 'Transferir', Icons.monetization_on),
      );
      expect(transferFeatureItem, findsOneWidget);
    },
  );

  testWidgets(
    'Should display the transaction list feature when Dashboard is opened',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: DashboardContainer(),
        ),
      );
      final transactionListFeatureItem = find.byWidgetPredicate(
        (widget) => featureItemMatcher(widget, 'Transações', Icons.description),
      );
      expect(transactionListFeatureItem, findsOneWidget);
    },
  );

  testWidgets(
    'Should display the change name feature when Dashboard is opened',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: DashboardContainer()),

      );
      final changeNameFeatureItem = find.byWidgetPredicate(
        (widget) =>
            featureItemMatcher(widget, 'Mudar Nome', Icons.person_outline),
      );
      expect(changeNameFeatureItem, findsOneWidget);
    },
  );
}
