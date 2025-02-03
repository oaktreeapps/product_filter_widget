// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'util/data_source.dart';
import 'util/widget_structure.dart';

void main() {
  testWidgets(
    'Right panel listview test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildRightPanelListView = find.byKey(
        const ValueKey(
          'rightPanelListView',
        ),
      );

      expect(
        buildRightPanelListView,
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Finds search view test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildSearchViewItem = find.byKey(
        const ValueKey(
          'searchView',
        ),
      );

      expect(
        buildSearchViewItem,
        findsExactly(1),
      );
    },
  );

  testWidgets(
    'Finds select all checkbox test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildSelectAllTileItem = find.byKey(
        const ValueKey(
          'selectAllTile',
        ),
      );

      expect(
        buildSelectAllTileItem,
        findsExactly(1),
      );
    },
  );
}
