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
    'Expecting all sub widgets when the list is not empty.',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildAppBar = find.byKey(
        const ValueKey(
          'appBar',
        ),
      );

      final Finder buildLeftPanel = find.byKey(
        const ValueKey(
          'leftPanel',
        ),
      );

      final Finder buildRightPanel = find.byKey(
        const ValueKey(
          'rightPanel',
        ),
      );

      final Finder buildBottomButtons = find.byKey(
        const ValueKey(
          'bottomButtons',
        ),
      );

      expect(
        buildAppBar,
        findsOneWidget,
      );

      expect(
        buildLeftPanel,
        findsOneWidget,
      );

      expect(
        buildRightPanel,
        findsOneWidget,
      );

      expect(
        buildBottomButtons,
        findsOneWidget,
      );
    },
  );
}
