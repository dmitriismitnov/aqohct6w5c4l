import 'package:aqohct6w5c4l/main.dart';
import 'package:aqohct6w5c4l/screens/main/widgets/product_card.dart';
import 'package:aqohct6w5c4l/screens/main/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test main scree', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);

    final productsList = find.byType(MainScreenProductsList);
    expect(productsList, findsOneWidget);

    await tester.pump();

    final listOfProductCards = find.byType(MainScreenProductCard);
    expect(listOfProductCards, findsWidgets);

    final listOfRemoveProductCardButton = find.byIcon(Icons.restore_from_trash_rounded);
    expect(listOfRemoveProductCardButton, findsWidgets);

    await tester.tap(listOfRemoveProductCardButton.first);
  });
}
