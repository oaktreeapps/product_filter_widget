// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_filter_widget/product_filter_widget.dart';
import 'util/data_source.dart';
import 'util/widget_structure.dart';

void main() {
  testWidgets('Expecting default values.', (WidgetTester tester) async {
    await tester.pumpWidget(
      BaseStructure(
        filterModelList: filterModelList,
      ),
    );

    expect(
      tester
          .widget<ProductFilterWidget>(find.byType(ProductFilterWidget))
          .filterModelList
          .length,
      7,
    );

    expect(
      tester.widget<ProductFilterWidget>(find.byType(ProductFilterWidget)).theme,
      isInstanceOf<FilterTheme>(),
    );

    expect(
      tester.widget<ProductFilterWidget>(find.byType(ProductFilterWidget)).onSubmit,
      isInstanceOf<Function(String)>(),
    );
  });

  testWidgets(
    'Expecting sizedBox when empty list',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const BaseStructure(
          filterModelList: [],
        ),
      );

      final Finder sizedBox = find.byKey(
        const ValueKey(
          'emptySizedBox',
        ),
      );
      expect(
        sizedBox,
        findsOneWidget,
      );
    },
  );

  testWidgets('Expecting filter view when the list is not empty.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      BaseStructure(
        filterModelList: filterModelList,
      ),
    );

    final Finder buildFilterView = find.byKey(
      const ValueKey(
        'filterView',
      ),
    );

    expect(
      buildFilterView,
      findsOneWidget,
    );
  });

  testWidgets(
      'The list filters and shows the correct number of results when the user searches.',
      (WidgetTester tester) async {
    // Test data
    final List<String> items = [
      'Nike',
      'Puma',
      'Reebok',
      'Bata',
      'Crocs',
      'Sketchers',
      'Sketchers Addition',
    ];

    List<String> filteredItems = items;

    // Mock search function
    void onSearchChanged({
      required String value,
    }) {
      filteredItems = items
          .where((item) => item.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    // Widget to test
    final testWidget = StatefulBuilder(
      builder: (context, setState) {
        return MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  key: const ValueKey('searchView'),
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      key: const Key('searchTextField'),
                      onChanged: (value) {
                        setState(() => onSearchChanged(value: value));
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 6),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    await tester.pumpWidget(testWidget);

    expect(find.byType(ListTile), findsNWidgets(items.length));

    ///correct number of results when search
    await tester.enterText(find.byKey(const Key('searchTextField')), 'puma');
    await tester.pump();

    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text('puma'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('searchTextField')), 'crocs');
    await tester.pump();

    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text('crocs'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('searchTextField')), 'sket');
    await tester.pump();

    expect(find.byType(ListTile), findsNWidgets(2));

    await tester.enterText(find.byKey(const Key('searchTextField')), '');
    await tester.pump();

    ///list reset when clears search
    expect(find.byType(ListTile), findsNWidgets(items.length));
    for (var item in items) {
      expect(find.text(item), findsOneWidget);
    }
  });
}
