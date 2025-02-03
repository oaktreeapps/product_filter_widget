import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../filter_theme.dart';
import '../../models/filter_model/filter_model.dart';

/// A custom widget for the left panel of a filter section.
/// It displays a list of filter titles and allows the user to select a filter item,
/// triggering a callback with the filter's ID and corresponding sub-selection list.
class LeftPanel extends StatelessWidget {
  // The theme used for styling the left panel (colors, text, etc.).
  final FilterTheme theme;

  // Callback function that is called when a filter item is tapped,
  // passing the filter ID and the corresponding sub-selections.
  final Function(
    String filterId,
    List<FilterSubSelectionModel> updateSubSelectionList,
  ) onTap;

  // The ID of the currently selected filter.
  final String selectedId;

  // The list of filters to be displayed in the panel.
  final List<FilterModel> filterModelList;

  // The list of search results for filtering.

  // Constructor to initialize the [theme], [onTap], [selectedId],
  // [filterModelList], and [searchResults] parameters.
  const LeftPanel({
    super.key,
    required this.theme,
    required this.onTap,
    required this.selectedId,
    required this.filterModelList,
  });

  String get fontFamily => theme.fontFamily.isNotEmpty
      ? theme.fontFamily
      : GoogleFonts.lato().fontFamily!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width *
          0.35, // Sets the width to 35% of the screen width.
      child: Container(
        color: theme.leftPanelColor, // Background color for the left panel.
        child: ListView(
          key: const ValueKey('LeftPanelListView'),
          children: filterModelList.map((e) {
            // Determines if the current filter is selected based on its ID.
            bool selected = selectedId == e.filterId;

            return Container(
              decoration: BoxDecoration(
                // Conditional color based on selection.
                color: selected
                    ? theme.leftPanelSelectedTileColor
                    : theme.leftPanelUnSelectedTileColor,
                border: Border(
                  bottom: BorderSide(
                    color: theme
                        .leftPanelSelectedTileBorderColor, // Bottom border color.
                  ),
                ),
              ),
              child: GestureDetector(
                key: const ValueKey('onTapSelectLeftPanelItem'),
                behavior: HitTestBehavior.translucent,
                // Detect taps even in transparent areas.
                onTap: () {
                  // Calls the [onTap] callback with the filter ID and its sub-selection list.
                  onTap(
                    e.filterId,
                    List.from(
                      e.filterSubSelectionList,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  // Padding around the text.
                  child: Text(
                    e.filterTitle, // The title of the filter.
                    style: TextStyle(
                      color: theme.leftPanelTextColor,
                      // Text color from the theme.
                      fontSize: 13,
                      // Font size for the filter title.
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal, // Bold if selected.
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            );
          }).toList(), // Converts the list of filters to a list of widgets.
        ),
      ),
    );
  }
}
