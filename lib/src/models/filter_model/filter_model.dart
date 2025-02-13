import 'package:flutter/material.dart';
import '../../utilities/generate_hash.dart';

/// A model representing a filter with various configuration options.
class FilterModel {
  /// Unique identifier for the filter.
  final String filterId;

  /// Title of the filter.
  final String filterTitle;

  /// Currency of the price range.
  final String? currency;

  /// Type of the filter (e.g., checkbox, radio, price range).
  final FilterType filterType;

  /// Whether to show the "Select All" option.
  final bool showSelectAll;

  /// Whether to show the search option within the filter.
  final bool showSearchOption;

  /// List of sub-selection options for the filter.
  final List<FilterSubSelectionModel> filterSubSelectionList;

  /// Creates a new `FilterModel` instance.
  ///
  /// - [filterId]: Unique identifier for the filter.
  /// - [filterTitle]: Title of the filter.
  /// - [filterSubSelectionList]: List of sub-selection options.
  /// - [filterType]: Type of the filter.
  /// - [showSelectAll]: Optional, defaults to `true`.
  /// - [showSearchOption]: Optional, defaults to `true`.
  FilterModel({
    required this.filterId,
    required this.filterTitle,
    required this.filterSubSelectionList,
    required this.filterType,
    this.showSelectAll = true,
    this.showSearchOption = true,
    this.currency,
  });

  /// Creates a copy of the current `FilterModel` with modified properties.
  ///
  /// Only the specified properties will be replaced; others will remain unchanged.
  FilterModel copyWith({
    String? filterId,
    String? filterTitle,
    FilterType? filterType,
    bool? showSelectAll,
    bool? showSearchOption,
    List<FilterSubSelectionModel>? filterSubSelectionList,
  }) {
    return FilterModel(
      filterId: filterId ?? this.filterId,
      filterTitle: filterTitle ?? this.filterTitle,
      filterType: filterType ?? this.filterType,
      showSelectAll: showSelectAll ?? this.showSelectAll,
      showSearchOption: showSearchOption ?? this.showSearchOption,
      filterSubSelectionList:
          filterSubSelectionList ?? this.filterSubSelectionList,
    );
  }
}

/// A model representing a sub-selection option within a filter.
class FilterSubSelectionModel {
  /// Unique identifier for the sub-selection.
  final String filterSubId;

  /// Label for the sub-selection.
  final String label;

  /// Title for the price range selection (if applicable).
  final String priceRangeTitle;

  /// Whether this sub-selection is selected.
  final bool selected;

  /// The range values for a range slider (if applicable).
  final RangeValues? rangeValues;

  /// Minimum value for the range slider (if applicable).
  final double? minRangeValue;

  /// Maximum value for the range slider (if applicable).
  final double? maxRangeValue;

  /// Count of items associated with this sub-selection.
  final String? count;

  /// Currency of price range.
  final String? currency;

  /// Whether to display a color box for this sub-selection.
  final bool needColorBox;

  /// Color of the box (if `needColorBox` is `true`).
  final Color? boxColor;

  /// Creates a new `FilterSubSelectionModel` instance.
  ///
  /// - [filterSubId]: Optional, defaults to a generated hash key.
  /// - [label]: Label for the sub-selection.
  /// - [priceRangeTitle]: Optional, defaults to "Selected Price Range".
  /// - [minRangeValue]: Optional, defaults to `0`.
  /// - [maxRangeValue]: Optional, defaults to `1000`.
  /// - [selected]: Optional, defaults to `false`.
  /// - [boxColor]: Optional, defaults to `Colors.black`.
  /// - [needColorBox]: Optional, defaults to `false`.
  /// - [rangeValues]: Optional, specifies the range values for sliders.
  /// - [count]: Optional, specifies the count for this sub-selection.
  FilterSubSelectionModel({
    String? filterSubId,
    this.currency,
    this.minRangeValue = 0,
    this.maxRangeValue = 1000,
    this.priceRangeTitle = "Price Range",
    this.count,
    required this.label,
    this.selected = false,
    this.boxColor = Colors.black,
    this.needColorBox = false,
    this.rangeValues,
  }) : filterSubId = filterSubId ?? generateHashKey();

  /// Creates a copy of the current `FilterSubSelectionModel` with modified properties.
  ///
  /// Only the specified properties will be replaced; others will remain unchanged.
  FilterSubSelectionModel copyWith({
    String? filterSubId,
    String? label,
    String? priceRangeTitle,
    bool? selected,
    RangeValues? rangeValues,
    double? minRangeValue,
    double? maxRangeValue,
    String? count,
    String? currency,
    bool? needColorBox,
    Color? boxColor,
  }) {
    return FilterSubSelectionModel(
      filterSubId: filterSubId ?? this.filterSubId,
      label: label ?? this.label,
      priceRangeTitle: priceRangeTitle ?? this.priceRangeTitle,
      selected: selected ?? this.selected,
      rangeValues: rangeValues ?? this.rangeValues,
      minRangeValue: minRangeValue ?? this.minRangeValue,
      maxRangeValue: maxRangeValue ?? this.maxRangeValue,
      count: count ?? this.count,
      needColorBox: needColorBox ?? this.needColorBox,
      boxColor: boxColor ?? this.boxColor,
      currency: currency ?? this.currency,
    );
  }
}

/// Enumeration for defining different types of filters.
enum FilterType {
  /// A filter that uses checkboxes for multiple selections.
  checkBox,

  /// A filter that uses checkboxes for multiple color selections.
  colorCheckBox,

  /// A filter that uses radio buttons for single selection.
  radio,

  /// A filter that uses a range slider for selecting a price range.
  priceRange,
}
