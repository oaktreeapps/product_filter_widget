import 'package:cupertino_range_slider_improved/cupertino_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../filter_theme.dart';
import '../../models/filter_model/filter_model.dart';

/// A widget that renders different types of filter options based on the [filterType].
/// It supports Checkbox, Radio button, and Price Range filter types.
class GetTypeWidget extends StatefulWidget {
  /// The current sub-selection model representing the selected item in the filter.
  /// This holds the data for the specific item that is currently selected.
  final FilterSubSelectionModel singleSubListSelectedElement;

  /// The type of filter to be displayed (e.g., checkbox, radio button, or price range).
  /// Determines the behavior and appearance of the filter widget.
  final FilterType filterType;

  /// The theme used to style the widget.
  /// Includes properties like active and inactive colors, fonts, and overall design.
  final FilterTheme theme;

  /// Callback triggered when the state of a checkbox changes.
  /// [updatedSubSelection]: The updated sub-selection model reflecting the checkbox change.
  final Function(
    FilterSubSelectionModel updatedSubSelection,
  ) onCheckBoxStateChange;

  /// Callback triggered when the state of a radio button changes.
  /// [updatedSubSelection]: The updated sub-selection model reflecting the radio button change.
  final Function(
    FilterSubSelectionModel updatedSubSelection,
  ) onRadioBoxStateChange;

  /// Callback triggered when the value of the range (e.g., slider or range bar) changes.
  /// [updatedSubSelection]: The updated sub-selection model reflecting the range value change.
  final Function(
    FilterSubSelectionModel updatedSubSelection,
  ) onRangeStateChange;

  const GetTypeWidget({
    super.key,
    required this.filterType,
    required this.singleSubListSelectedElement,
    required this.theme,
    required this.onCheckBoxStateChange,
    required this.onRadioBoxStateChange,
    required this.onRangeStateChange,
  });

  @override
  State<GetTypeWidget> createState() => _GetTypeWidgetState();
}

class _GetTypeWidgetState extends State<GetTypeWidget> {
  late String defaultFontFamily;

  @override
  void initState() {
    super.initState();
    defaultFontFamily = GoogleFonts.lato().fontFamily!;
  }

  String get fontFamily => widget.theme.fontFamily.isNotEmpty
      ? widget.theme.fontFamily
      : defaultFontFamily;

  /// This method returns the widget based on the selected filter type.
  @override
  Widget build(BuildContext context) {
    switch (widget.filterType) {
      case FilterType.checkBox:
        return _buildCheckBoxWidget();
      case FilterType.radio:
        return _buildRadioButtonWidget();
      case FilterType.colorCheckBox:
        return _buildCheckBoxWidget();
      case FilterType.priceRange:
        return _buildPriceRangeWidget();
      default:
        return const SizedBox(); // Return an empty container if no matching filter type
    }
  }

  /// Builds the checkbox widget to select/deselect an item.
  Widget _buildCheckBoxWidget() {
    return ListTile(
      splashColor: Colors.transparent,
      onTap: () {
        widget.onCheckBoxStateChange(
          widget.singleSubListSelectedElement.copyWith(
            selected: !widget.singleSubListSelectedElement.selected,
          ),
        );
      },
      dense: true,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          widget.onCheckBoxStateChange(
            widget.singleSubListSelectedElement.copyWith(
              selected: !widget.singleSubListSelectedElement.selected,
            ),
          );
        },
        icon: Icon(
          Icons.done,
          size: 18,
          color: widget.singleSubListSelectedElement.selected
              ? widget.theme.rightPanelActiveColor
              : widget.theme.rightPanelInActiveColor.withOpacity(0.3),
        ),
      ),
      trailing: widget.singleSubListSelectedElement.count != null
          ? Text(
              '(${widget.singleSubListSelectedElement.count})',
              style: TextStyle(
                fontSize: 12,
                color: widget.singleSubListSelectedElement.selected
                    ? widget.theme.rightPanelActiveColor
                    : widget.theme.rightPanelInActiveColor,
                fontFamily: fontFamily,
              ),
            )
          : null,
      title: Row(
        children: [
          if (widget.singleSubListSelectedElement.needColorBox)
            Container(
              height: 18,
              width: 25,
              decoration: BoxDecoration(
                color: widget.singleSubListSelectedElement.boxColor,
              ),
            ),
          if (widget.singleSubListSelectedElement.needColorBox)
            const SizedBox(
              width: 10,
            ),
          Text(
            widget.singleSubListSelectedElement.label,
            style: TextStyle(
              fontSize: 13.5,
              color: widget.singleSubListSelectedElement.selected
                  ? widget.theme.rightPanelActiveColor
                  : widget.theme.rightPanelInActiveColor,
              fontWeight: widget.singleSubListSelectedElement.selected
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontFamily: fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the radio button widget to select a single option.
  Widget _buildRadioButtonWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onRadioBoxStateChange(
          widget.singleSubListSelectedElement.copyWith(
            selected: !widget.singleSubListSelectedElement.selected,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            Icon(
              widget.singleSubListSelectedElement.selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: widget.singleSubListSelectedElement.selected
                  ? widget.theme.rightPanelActiveColor
                  : widget.theme.rightPanelInActiveColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.singleSubListSelectedElement.label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: widget.singleSubListSelectedElement.selected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: widget.singleSubListSelectedElement.selected
                    ? widget.theme.rightPanelActiveColor
                    : widget.theme.rightPanelInActiveColor,
                fontFamily: fontFamily,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Builds the price range slider and label.
  Widget _buildPriceRangeWidget() {
    return widget.singleSubListSelectedElement.rangeValues == null
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.singleSubListSelectedElement.priceRangeTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: widget.theme.rightPanelTextColor,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.singleSubListSelectedElement.currency}${widget.singleSubListSelectedElement.rangeValues!.start.toInt()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.theme.rightPanelTextColor,
                            fontFamily: fontFamily,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 0.6,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.singleSubListSelectedElement.currency}${widget.singleSubListSelectedElement.rangeValues!.end.toInt()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: widget.theme.rightPanelTextColor,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 15,
                child: CupertinoRangeSlider(
                  minValue:
                      widget.singleSubListSelectedElement.rangeValues?.start ??
                          0.0,
                  maxValue:
                      widget.singleSubListSelectedElement.rangeValues?.end ??
                          0.0,
                  min: widget.singleSubListSelectedElement.minRangeValue ?? 0.0,
                  max: widget.singleSubListSelectedElement.maxRangeValue ??
                      10000.0,
                  activeColor: widget.theme.rightPanelActiveColor,
                  thumbColor: widget.theme.rightPanelActiveColor,
                  trackColor: Colors.grey,
                  onMinChanged: (value) {
                    final rangeValues = RangeValues(
                      value,
                      widget.singleSubListSelectedElement.rangeValues!.end,
                    );
                    widget.onRangeStateChange(
                      widget.singleSubListSelectedElement.copyWith(
                        rangeValues: rangeValues,
                      ),
                    );
                    setState(() {});
                  },
                  onMaxChanged: (value) {
                    final rangeValues = RangeValues(
                      widget.singleSubListSelectedElement.rangeValues!.start,
                      value,
                    );
                    widget.onRangeStateChange(
                      widget.singleSubListSelectedElement.copyWith(
                        rangeValues: rangeValues,
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
            ],
          );
  }
}
