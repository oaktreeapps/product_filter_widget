library product_filter_widget;

import 'dart:convert';

import 'package:product_filter_widget/src/filter_theme.dart';
import 'package:product_filter_widget/src/models/filter_model/filter_model.dart';
import 'package:product_filter_widget/src/ui/widgets/app_bar.dart';
import 'package:product_filter_widget/src/ui/widgets/button.dart';
import 'package:product_filter_widget/src/ui/widgets/left_panel.dart';
import 'package:product_filter_widget/src/ui/widgets/right_panel.dart';
import 'package:flutter/material.dart';

export 'package:product_filter_widget/src/models/filter_model/filter_model_utils.dart';
export 'package:product_filter_widget/src/models/filter_model/filter_model.dart';
export 'package:product_filter_widget/src/models/filter_model/sub_data_model.dart';
export 'package:product_filter_widget/src/filter_theme.dart';

// The main widget class for displaying the filter view in the e-commerce app.
class ProductFilterWidget extends StatefulWidget {
  /// Whether the reset button is needed in the UI.
  final bool needResetBtn;
  final bool? needRangeBar;

  ///
  final bool isResetFieldsAfterSubmit;

  /// Callback for when the filters are submitted. It passes a Map with filter values.
  final Function(String) onSubmit;

  /// The theme used for styling the filter view.
  final FilterTheme theme;

  /// List of filtering.
  final List<FilterModel> filterModelList;

  const ProductFilterWidget({
    super.key,
    required this.onSubmit,
    this.needRangeBar = true,
    required this.filterModelList,
    this.needResetBtn = true,
    this.isResetFieldsAfterSubmit = false,
    this.theme = const FilterTheme(),
  });

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

// The state class for managing the state of the FilterView widget.
class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  late String selectedId; // ID of the currently selected filter.
  late List<FilterModel> filterModelList; // List of all filter models.
  late RangeValues? currentRange; // Current range values for the price filter.
  late TextEditingController
      searchController; // Controller for the search input.
  late int selectedIndex = 0;
  late List<FilterSubSelectionModel> tempList; // for storing original list

  @override
  void initState() {
    super.initState();
    selectedId = "0"; // Default selected filter ID.
    // if ((widget.needRangeBar ?? false) && widget.rangeValues != null) {
    //   currentRange = widget.rangeValues!; // Default price range.
    // }
    searchController = TextEditingController();

    // Initialize the filter models based on the provided filter data.
    filterModelList = widget.filterModelList;

    // Set the initial selected filter ID and search results.
    selectedId =
        filterModelList.isNotEmpty ? filterModelList.first.filterId : '';
    tempList = filterModelList.isNotEmpty
        ? filterModelList.first.filterSubSelectionList
        : [];
  }

  // Submit the selected filters by calling the onSubmit callback.
  void _submit() {
    final selectedValues = {
      for (final filter in filterModelList)
        filter.filterTitle: (filter.filterSubSelectionList.where((item) => (item.selected ||
                (item.rangeValues != null && (item.rangeValues!.start != item.minRangeValue ||
                    item.rangeValues!.end != item.maxRangeValue))))
            .map((item) => filter.filterType == FilterType.priceRange
                  ? {
                      'id': item.filterSubId,
                      'min': item.rangeValues?.start.toStringAsFixed(2) ??
                          item.label,
                      'max': item.rangeValues?.end.toStringAsFixed(2) ??
                          item.label,
                    }
                  : {
                      'id': item.filterSubId,
                      'value': item.rangeValues?.toString() ?? item.label,
                    },
            )).toList()
    }..removeWhere((key, value) => value.isEmpty);

    // Convert the selectedValues map to JSON
    final jsonString = jsonEncode(selectedValues);
    widget.onSubmit(jsonString);

    if (widget.isResetFieldsAfterSubmit) {
      setState(() {
        filterModelList = filterModelList
            .map(
              _resetFilterModel,
            )
            .toList(); // Reset all filters after submission.
      });
    }
  }

  // Reset a filter model to its initial state.
  FilterModel _resetFilterModel(FilterModel filter) {
    return filter.copyWith(
      filterSubSelectionList: filter.filterSubSelectionList.map((item) {
        if (item.rangeValues != null) {
          return item.copyWith(
            rangeValues: RangeValues(
              item.minRangeValue!,
              item.maxRangeValue!,
            ),
          );
        }
        return item.copyWith(
          selected: false,
        );
      }).toList(),
    );
  }

  // Reset only the currently selected filter.
  void _reset() {
    setState(() {
      final selectedFilter = filterModelList.firstWhere(
        (filter) => filter.filterId == selectedId,
      );
      filterModelList = filterModelList
          .map(
            (filter) => filter.filterId == selectedFilter.filterId
                ? _resetFilterModel(filter)
                : filter,
          )
          .toList();
    });
  }

  void updateTheFilterModel(updatedSubSelection) {
    filterModelList[selectedIndex] = filterModelList[selectedIndex].copyWith(
      filterSubSelectionList: updatedSubSelection,
    );
    for (var item in updatedSubSelection) {
      final index = tempList.indexWhere(
        (original) => original.label == item.label,
      );
      if (index != -1) {
        tempList[index] = tempList[index].copyWith(
          selected: item.selected,
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: widget.theme.backgroundColor,
        body: filterModelList.isEmpty
            ? const SizedBox.shrink(
                key: ValueKey('emptySizedBox'),
              )
            : GestureDetector(
                key: const ValueKey('filterView'),
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                // Close the keyboard when tapping outside.
                child: Column(
                  children: [
                    BuildAppBar(
                      key: const ValueKey('appBar'),
                      theme: widget.theme,
                    ), // Custom app bar.
                    Expanded(
                      child: Row(
                        children: [
                          LeftPanel(
                            key: const ValueKey('leftPanel'),
                            onTap: (filterId, updateSubSelectionList) {
                              setState(
                                () {
                                  selectedId =
                                      filterId; // Update selected filter ID.
                                  selectedIndex = filterModelList.indexWhere(
                                    (element) => element.filterId == selectedId,
                                  );
                                  if (selectedIndex != -1) {
                                    filterModelList[selectedIndex] =
                                        filterModelList[selectedIndex].copyWith(
                                      filterSubSelectionList:
                                          updateSubSelectionList,
                                    );
                                  }
                                  tempList = filterModelList[selectedIndex]
                                      .filterSubSelectionList;
                                },
                              );
                            },
                            theme: widget.theme,
                            filterModelList: filterModelList,
                            selectedId: selectedId,
                          ),
                          Container(
                            width: 0.3,
                            color: widget.theme.dividerColor.withOpacity(
                              0.5,
                            ), // Divider between panels.
                          ),
                          RightPanel(
                            key: const ValueKey('rightPanel'),
                            theme: widget.theme,
                            showSelectAllOption:
                                filterModelList[selectedIndex].showSelectAll,
                            searchController: searchController,
                            selectFilterModelSubSelectionList:
                                filterModelList[selectedIndex]
                                    .filterSubSelectionList,
                            filterType:
                                filterModelList[selectedIndex].filterType,
                            showSearchOption:
                                filterModelList[selectedIndex].showSearchOption,
                            onSearchStateChange: (updatedSubSelection) {
                              if (searchController.text.isNotEmpty) {
                                updateTheFilterModel(updatedSubSelection);
                                tempList = tempList;
                              } else {
                                filterModelList[selectedIndex] =
                                    filterModelList[selectedIndex].copyWith(
                                        filterSubSelectionList: tempList);

                                setState(() {});
                              }
                            },
                            onSelectAllStateChange: (updatedSubSelection) =>
                                updateTheFilterModel(updatedSubSelection),
                            onRangeValueStateChange: (updatedSubSelection) =>
                                updateTheFilterModel(updatedSubSelection),
                            onCheckBoxStateChange: (updatedSubSelection) =>
                                updateTheFilterModel(updatedSubSelection),
                            onRadioBoxStateChange: (updatedSubSelection) =>
                                updateTheFilterModel(updatedSubSelection),
                          ),
                        ],
                      ),
                    ),
                    BuildButtons(
                      key: const ValueKey('bottomButtons'),
                      theme: widget.theme,
                      needResetBtn: widget.needResetBtn,
                      // Display reset button if needed.
                      reset: _reset,
                      // Reset action.
                      submit: _submit, // Submit action.
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
