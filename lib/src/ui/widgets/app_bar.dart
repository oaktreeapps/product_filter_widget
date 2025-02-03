import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../filter_theme.dart';

/// A custom AppBar widget used to display a header with a back button and a title.
/// It accepts a [FilterTheme] object to customize the appearance of the AppBar.
class BuildAppBar extends StatelessWidget {
  // The theme used to style the AppBar (background color, text color, divider color).
  final FilterTheme theme;

  // Constructor to initialize [theme] required for styling the AppBar.
  const BuildAppBar({
    super.key,
    required this.theme,
  });

  String get fontFamily => theme.fontFamily.isNotEmpty
      ? theme.fontFamily
      : GoogleFonts.lato().fontFamily!;

  @override
  Widget build(BuildContext context) {
    // Builds the AppBar container with custom decoration and styling.
    return Container(
      alignment: Alignment.center, // Aligns the content to the center of the AppBar.
      decoration: BoxDecoration(
        color: theme.appBarBackgroundColor, // Background color from theme.
        border: Border(
          bottom: BorderSide(
            color: theme.appBarDividerColor, // Bottom border color from theme.
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20, // Horizontal padding of 20.
        vertical: 15,  // Vertical padding of 15.
      ),
      child: Row(
        children: [
          // GestureDetector used to detect tap event on the back button.
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context); // Pops the current screen off the navigator stack.
            },
            child: Icon(
              Icons.arrow_back, // The back arrow icon.
              color: theme.appBarTextColor, // Color of the back arrow icon from the theme.
            ),
          ),
          const SizedBox(
            width: 10, // Adds a 10-pixel gap between the back button and title.
          ),
          // Title text displayed in the AppBar.
          Text(
            'Product Filters',
            style: TextStyle(
              color: theme.appBarTextColor, // Text color from the theme.
              fontWeight: FontWeight.bold,    // Bold text style for the title.
              fontSize: 16,                   // Font size of 16.
              fontFamily: fontFamily,
            ),
          )
        ],
      ),
    );
  }
}
