import 'package:cryptodata/components/presentation/pages/quick_search_list_page.dart';
import 'package:cryptodata/components/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("MyWidget has a title and message", (WidgetTester tester) async {
    final addField = find.byKey(ValueKey("valueText"));
    final searchButton = find.byKey(ValueKey("searchKey"));

    await tester.pumpWidget(MaterialApp(home: MyCryptoListPage()));
    await tester.pumpWidget(SearchWidget());
    await tester.enterText(addField, "btcusd");
    await tester.tap(searchButton);
    await tester.pump();

    expect(find.text("btcusd"), findsOneWidget);
  });
}
