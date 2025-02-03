import 'package:flutter/material.dart';
import 'package:product_filter_widget/src/models/filter_model/sub_data_model.dart';
import '../../utilities/generate_hash.dart';
import 'filter_model.dart';

class FilterModelUtils {
  // Helper method to build a FilterModel for a given title and data.
  static FilterModel buildFilterModel(
    String title,
    List<SubDataModel> subDataModelList, {
    required FilterType filterType,
  }) {
    return FilterModel(
      filterType: filterType,
      // Determine filter type.
      filterId: generateHashKey(),
      // Generate a unique ID for the filter.
      filterTitle: title,
      // Set the filter title.
      showSelectAll: filterType != FilterType.radio,
      // Show 'Select All' option for non-radio filters.
      showSearchOption: filterType != FilterType.radio,
      // Show 'showSearchOption' option for non-radio filters.
      filterSubSelectionList: subDataModelList.map(
        (item) {
          // Map the data into sub-selection models.
          if (filterType == FilterType.colorCheckBox) {
            return FilterSubSelectionModel(
              label: item.name,
              boxColor: item.color,
              needColorBox: true,
            );
          } else {
            return FilterSubSelectionModel(
              label: item.name,
              count: item.count,
            );
          }
        },
      ).toList(),
    );
  }

  // Build a filter model specifically for the price range.
  static FilterModel buildPriceRangeFilter({
    required RangeValues range,
    required String title,
    required String priceRangeTitle,
    String? currency,
  }) {
    return FilterModel(
      filterType: FilterType.priceRange,
      filterId: generateHashKey(),
      currency: currency,
      filterTitle: title,
      showSelectAll: false,
      showSearchOption: false,
      filterSubSelectionList: [
        FilterSubSelectionModel(
          label: '',
          rangeValues: range,
          maxRangeValue: range.end,
          minRangeValue: range.start,
          currency: currency,
          priceRangeTitle: priceRangeTitle,
        ),
      ],
    );
  }
}
