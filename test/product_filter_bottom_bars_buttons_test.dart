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
    'Submit button gesture test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildSubmitButton = find.byKey(
        const ValueKey(
          'onTapSubmit',
        ),
      );

      expect(
        buildSubmitButton,
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Reset button gesture test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BaseStructure(
          filterModelList: filterModelList,
        ),
      );

      final Finder buildResetButton = find.byKey(
        const ValueKey(
          'onTapReset',
        ),
      );

      expect(
        buildResetButton,
        findsOneWidget,
      );
    },
  );
}
