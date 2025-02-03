import 'package:google_fonts/google_fonts.dart';
import 'package:product_filter_widget/src/ui/widgets/type_widgets.dart';
import 'package:flutter/material.dart';
import '../../filter_theme.dart';
import '../../models/filter_model/filter_model.dart';

/// The right panel of the filter section.
/// This widget displays search functionality, the option to select all items,
/// and a list of filter sub-selections with their corresponding widgets.
class RightPanel extends StatefulWidget {
  // The theme used for styling the right panel (colors, text, etc.).
  final FilterTheme theme;

// The type of filter to be displayed (e.g., checkbox, radio button, etc.).
  final FilterType filterType;

// Determines whether to show the "Select All" option in the filter.
  final bool showSelectAllOption;

// Determines whether to show the search bar option in the filter.
  final bool showSearchOption;

// The controller for managing input in the search field.
  final TextEditingController searchController;

// A list of sub-selection models representing the filter options.
  final List<FilterSubSelectionModel> selectFilterModelSubSelectionList;

// Callback triggered when a checkbox state changes.
// [updatedSubSelection]: Updated list of sub-selection models.
  final Function(
    List<FilterSubSelectionModel> updatedSubSelection,
  ) onCheckBoxStateChange;

// Callback triggered when a radio button state changes.
// [updatedSubSelection]: Updated list of sub-selection models.
  final Function(
    List<FilterSubSelectionModel> updatedSubSelection,
  ) onRadioBoxStateChange;

// Callback triggered when the "Select All" option state changes.
// [updatedSubSelection]: Updated list of sub-selection models.
  final Function(
    List<FilterSubSelectionModel> updatedSubSelection,
  ) onSelectAllStateChange;

// Callback triggered when the search input changes.
// [updatedSubSelection]: Updated list of sub-selection models based on the search.
  final Function(
    List<FilterSubSelectionModel> updatedSubSelection,
  ) onSearchStateChange;

// Callback triggered when the range value changes (e.g., slider or range bar).
// [updatedSubSelection]: Updated list of sub-selection models based on the range.
  final Function(
    List<FilterSubSelectionModel> updatedSubSelection,
  ) onRangeValueStateChange;

  const RightPanel({
    super.key,
    required this.theme,
    required this.filterType,
    required this.showSelectAllOption,
    required this.showSearchOption,
    required this.searchController,
    required this.selectFilterModelSubSelectionList,
    required this.onCheckBoxStateChange,
    required this.onRadioBoxStateChange,
    required this.onSelectAllStateChange,
    required this.onSearchStateChange,
    required this.onRangeValueStateChange,
  });

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  String get fontFamily => widget.theme.fontFamily.isNotEmpty
      ? widget.theme.fontFamily
      : GoogleFonts.lato().fontFamily!;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          key: const ValueKey('rightPanelListView'),
          children: [
            const SizedBox(height: 10),
            // Conditionally render the search bar if the filter model shows the search option.
            if (widget.showSearchOption)
              SizedBox(
                key: const ValueKey('searchView'),
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TextField(
                    controller: widget.searchController,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: fontFamily,
                    ),
                    onChanged: (value) {
                      onSearchChanged(
                        value: value,
                      );
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: fontFamily,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            // Conditionally render the "Select All" option if enabled.
            if (widget.showSelectAllOption)
              GestureDetector(
                key: const ValueKey('selectAllTile'),
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  selectAllTap();
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: widget.selectFilterModelSubSelectionList.isEmpty
                          ? false
                          : widget.selectFilterModelSubSelectionList.every(
                              (element) => element.selected,
                            ),
                      activeColor: widget.theme.rightPanelActiveColor,
                      onChanged: (value) {
                        final updatedList = widget
                            .selectFilterModelSubSelectionList
                            .map((item) {
                          return item.copyWith(
                            selected: value ?? false,
                          );
                        }).toList();

                        // Pass the updated list to the parent callback
                        widget.onSelectAllStateChange(updatedList);
                      },
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Select All',
                      style: TextStyle(
                        fontSize: 14,
                        color: getColorSelectAll(),
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '(${widget.selectFilterModelSubSelectionList.length})',
                      style: TextStyle(
                        fontSize: 14,
                        color: getColorSelectAll(),
                        fontFamily: fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            // Render the filter sub-selection widgets.
            ...widget.selectFilterModelSubSelectionList.map(
              (singleSubListSelectedElement) {
                return GetTypeWidget(
                  singleSubListSelectedElement: singleSubListSelectedElement,
                  theme: widget.theme,
                  filterType: widget.filterType,
                  onRangeStateChange: (updatedSubSelection) {
                    final updatedList =
                        widget.selectFilterModelSubSelectionList.map((item) {
                      if (item == singleSubListSelectedElement) {
                        return item.copyWith(
                          rangeValues: updatedSubSelection.rangeValues,
                        );
                      }
                      return item;
                    }).toList();

                    // Pass the updated list to the parent callback
                    widget.onRangeValueStateChange(updatedList);
                  },
                  onRadioBoxStateChange: (updatedSubSelection) {
                    onRadioBoxStateChanged(
                      updatedSubSelection: updatedSubSelection,
                      singleSubListSelectedElement:
                          singleSubListSelectedElement,
                    );
                  },
                  onCheckBoxStateChange: (updatedSubSelection) {
                    final updatedList =
                        widget.selectFilterModelSubSelectionList.map((item) {
                      if (item == singleSubListSelectedElement) {
                        return item.copyWith(
                          selected: !item.selected,
                        );
                      }
                      return item;
                    }).toList();

                    // Pass the updated list to the parent callback
                    widget.onCheckBoxStateChange(updatedList);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onRadioBoxStateChanged({
    required FilterSubSelectionModel updatedSubSelection,
    required FilterSubSelectionModel singleSubListSelectedElement,
  }) {
    final updatedList = widget.selectFilterModelSubSelectionList.map((item) {
      if (item == singleSubListSelectedElement) {
        return item.copyWith(
          selected: updatedSubSelection.selected,
        );
      } else {
        return item.copyWith(
          selected: false,
        );
      }
    }).toList();
    // Pass the updated list to the parent callback
    widget.onRadioBoxStateChange(updatedList);
  }

  ///on click of select all check
  void selectAllTap() {
    final updatedList = widget.selectFilterModelSubSelectionList.map(
      (item) {
        return item.copyWith(
          selected: !(widget.selectFilterModelSubSelectionList.isEmpty
              ? false
              : widget.selectFilterModelSubSelectionList.every(
                  (element) => element.selected,
                )),
        );
      },
    ).toList();

    // Pass the updated list to the parent callback
    widget.onSelectAllStateChange(updatedList);
  }

  ///value on search changed
  void onSearchChanged({
    required String value,
  }) {
    final updatedList = widget.selectFilterModelSubSelectionList.where(
      (item) {
        return item.label.toLowerCase().contains(
              value.toLowerCase(),
            );
      },
    ).toList();
    widget.onSearchStateChange(updatedList);
  }

  ///color based on selection
  Color getColorSelectAll() {
    return (widget.selectFilterModelSubSelectionList.isEmpty
            ? false
            : widget.selectFilterModelSubSelectionList.every(
                (element) => element.selected,
              ))
        ? widget.theme.rightPanelActiveColor
        : widget.theme.rightPanelTextColor;
  }
}
