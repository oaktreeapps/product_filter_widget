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
    'Left panel listview test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildLeftPanelListView = find.byKey(
        const ValueKey(
          'LeftPanelListView',
        ),
      );

      expect(
        buildLeftPanelListView,
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Left panel listview item click test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildLeftPanelListItemClickView = find.byKey(
        const ValueKey(
          'onTapSelectLeftPanelItem',
        ),
      );

      expect(
        buildLeftPanelListItemClickView,
        findsExactly(7),
      );
    },
  );
}
