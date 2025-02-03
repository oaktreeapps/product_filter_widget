import 'package:flutter/material.dart';

/// A class that defines a customizable theme for a filter widget.
///
/// The `FilterTheme` class allows you to define various color properties
/// for different parts of a filter interface, such as the app bar,
/// left and right panels, buttons, and dividers.
/// Each property has a default value, so you can override only the colors
/// you need to customize.
///
/// Example usage:
/// ```dart
/// FilterTheme(
///   appBarBackgroundColor: Colors.blue,
///   appBarTextColor: Colors.white,
/// );
/// ```

class FilterTheme {
  /// The background color of the app bar.
  final Color appBarBackgroundColor;

  /// The text color used in the app bar.
  final Color appBarTextColor;

  /// The color of the back icon in the app bar.
  final Color appBarBackIconColor;

  /// The color of the divider in the app bar.
  final Color appBarDividerColor;

  /// The background color of the left panel.
  final Color leftPanelColor;

  /// The background color of the selected tile in the left panel.
  final Color leftPanelSelectedTileColor;

  /// The background color of the unselected tile in the left panel.
  final Color leftPanelUnSelectedTileColor;

  /// The border color of the selected tile in the left panel.
  final Color leftPanelSelectedTileBorderColor;

  /// The text color used in the left panel.
  final Color leftPanelTextColor;

  /// The color of dividers used across the widget.
  final Color dividerColor;

  /// The color used for displaying counts (e.g., item counts).
  final Color countColor;

  /// The text color used in the right panel.
  final Color rightPanelTextColor;

  /// The color used for active states in the right panel.
  final Color rightPanelActiveColor;

  /// The color used for inactive states in the right panel.
  final Color rightPanelInActiveColor;

  /// The color of the divider used in the price range slider.
  final Color priceRangeDividerColor;

  /// The background color of the overall filter widget.
  final Color backgroundColor;

  /// The background color of the submit button.
  final Color submitButtonBackgroundColor;

  /// The text color of the submit button.
  final Color submitButtonTextColor;

  /// The text color of the reset button.
  final Color resetButtonTextColor;

  /// The background color of the reset button.
  final Color resetButtonBackgroundColor;

  /// The font family for all text
  final String fontFamily;

  /// Creates a `FilterTheme` instance with customizable color properties.
  ///
  /// All properties have default values, so you can provide only the colors
  /// you want to override.
  const FilterTheme({
    this.appBarBackgroundColor = Colors.white,
    this.appBarTextColor = Colors.black,
    this.appBarBackIconColor = Colors.white,
    this.appBarDividerColor = const Color(0xFFEEEEEE),
    this.leftPanelColor = const Color(0xFFF5F5F5),
    this.leftPanelSelectedTileColor = Colors.white,
    this.leftPanelSelectedTileBorderColor = const Color(0xFFE0E0E0),
    this.leftPanelUnSelectedTileColor = Colors.transparent,
    this.leftPanelTextColor = Colors.black,
    this.dividerColor = Colors.black,
    this.countColor = Colors.black,
    this.rightPanelTextColor = Colors.black,
    this.rightPanelActiveColor = Colors.pink,
    this.rightPanelInActiveColor = Colors.black,
    this.priceRangeDividerColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.submitButtonBackgroundColor = Colors.white,
    this.submitButtonTextColor = Colors.pink,
    this.resetButtonTextColor = Colors.black,
    this.resetButtonBackgroundColor = Colors.white,
    this.fontFamily = '',
  });
}
