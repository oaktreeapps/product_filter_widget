import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../filter_theme.dart';

/// A custom widget that builds a row of buttons: Reset and Submit.
/// It conditionally displays the Reset button based on the [needResetBtn] parameter.
/// It accepts [submit], [reset] callback functions, and a [FilterTheme] for custom styling.
class BuildButtons extends StatelessWidget {

  // Callback function to handle the submit action.
  final void Function() submit;

  // Callback function to handle the reset action.
  final void Function() reset;

  // Boolean flag to determine if the Reset button should be displayed.
  final bool needResetBtn;

  // The theme used for styling the buttons.
  final FilterTheme theme;

  // Constructor to initialize all parameters, including the [needResetBtn], [reset], [submit], and [theme].
  const BuildButtons({
    super.key,
    required this.needResetBtn,
    required this.reset,
    required this.submit,
    required this.theme,
  });

  String get fontFamily => theme.fontFamily.isNotEmpty
      ? theme.fontFamily
      : GoogleFonts.lato().fontFamily!;

  @override
  Widget build(BuildContext context) {
    // Builds the container that holds the buttons with custom decoration and border.
    return Container(
      width: double.infinity, // Takes the full width available.
      height: 50, // Sets the height of the container to 50.
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200, // Light gray top border.
          ),
        ),
      ),
      child: Row(
        children: [
          // Conditionally displays the Reset button if [needResetBtn] is true.
          if (needResetBtn)
            Container(
              width: MediaQuery.sizeOf(context).width * 0.351, // Sets the width to 35.1% of the screen width.
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: theme.dividerColor.withOpacity(0.2), // Divider color from the theme with slight opacity.
                  ),
                ),
              ),
              child: GestureDetector(
                key: const ValueKey('onTapReset'),
                behavior: HitTestBehavior.translucent, // Ensures that taps on the transparent areas are also detected.
                onTap: () => reset(), // Calls the reset callback when tapped.
                child: Container(
                  width: double.infinity, // Makes the container take the full width.
                  alignment: Alignment.center, // Centers the text inside the container.
                  decoration: BoxDecoration(color: theme.resetButtonBackgroundColor), // Background color of the Reset button from the theme.
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: theme.resetButtonTextColor, // Text color from the theme.
                      fontWeight: FontWeight.w400, // Regular font weight for the Reset button text.
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox(), // Empty space if Reset button is not needed.

          // Submit button that takes the remaining space in the row.
          Expanded(
            child: GestureDetector(
              key: const ValueKey('onTapSubmit'),
              behavior: HitTestBehavior.translucent, // Ensures that taps on the transparent areas are also detected.
              onTap: () => submit(), // Calls the submit callback when tapped.
              child: Container(
                width: double.infinity, // Makes the container take the full width.
                alignment: Alignment.center, // Centers the text inside the container.
                decoration: BoxDecoration(
                  color: theme.submitButtonBackgroundColor, // Background color of the Submit button from the theme.
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: theme.submitButtonTextColor, // Text color from the theme.
                    fontWeight: FontWeight.bold, // Bold font weight for the Submit button text.
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
