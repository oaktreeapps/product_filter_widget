# product_filter_widget

This flutter package provides a customizable product filter component. It allows users to filter products based on various criteria, such as size, color, brand, price range, and more.

## Features

* Supports different filter types: checkbox, color checkbox, radio button
* Price range filter with custom currency symbol
* Customizable theme for submit and reset buttons
* Quickly filter results using text or keywords with search.


## Installation

To use this package in your Flutter project, add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  product_filter_widget: ^0.1.0-dev.1
```

Add then following import:

```dart
import 'package:product_filter_widget/product_filter_widget.dart';
```

## Usage

```
import 'package:product_filter_widget/product_filter_widget.dart';

List<FilterModel> filterModelList = [
  // ... (define your filter models)
  FilterModelUtils.buildFilterModel(
        filterType: FilterType.checkBox,
        'Size',
        sizes,
      ),
      FilterModelUtils.buildFilterModel(
        filterType: FilterType.colorCheckBox,
        'Color',
        colors,
      ),
      FilterModelUtils.buildFilterModel(
        filterType: FilterType.checkBox,
        'Brand',
        brands,
      ),
      FilterModelUtils.buildFilterModel(
        filterType: FilterType.checkBox,
        'Categories',
        categories,
      ),
      FilterModelUtils.buildPriceRangeFilter(
        title: 'Price',
        priceRangeTitle: 'Price Range',
        currency: "\$",
        range: const RangeValues(
          0,
          10000,
        ),
      ),
      FilterModelUtils.buildFilterModel(
        filterType: FilterType.radio,
        'Country of Origin',
        countryOfOrigin,
      ),
      FilterModelUtils.buildFilterModel(
        filterType: FilterType.radio,
        'Discount',
        discounts,
      ),
];

ProductFilterWidget(
  onSubmit: (selectedValues) {
    log(selectedValues);
  },
  filterModelList: filterModelList,
  theme: const FilterTheme(
    submitButtonBackgroundColor: Colors.blueGrey,
    submitButtonTextColor: Colors.white,
    resetButtonBackgroundColor: Colors.black,
    resetButtonTextColor: Colors.white,
  ),
)
```


## Sample Response

```
{
  "Size": [
    {
      "id": "eb714e7eff282b18",
      "value": "S"
    },
    {
      "id": "b61c8b17d052dfc4",
      "value": "M"
    }
  ],
  "Color": [
    {
      "id": "18ac29bc21fdbb7a",
      "value": "Yellow"
    },
    {
      "id": "31841fe40e0ac41b",
      "value": "Green"
    }
  ],
  "Brand": [
    {
      "id": "f73ca4a34536e2f7",
      "value": "Puma"
    },
    {
      "id": "67f65b2e7338b8a5",
      "value": "Reebok"
    }
  ],
  "Categories": [
    {
      "id": "6321f4276607724d",
      "value": "Footwear"
    },
    {
      "id": "5de9ce46bee5efaf",
      "value": "Beauty"
    }
  ],
  "Price": [
    {
      "id": "2e2e2c6a17b8b822",
      "min": "480.17",
      "max": "5570.01"
    }
  ],
  "Country of Origin": [
    {
      "id": "14636b1d2f18dc7e",
      "value": "Canada"
    }
  ],
  "Discount": [
    {
      "id": "77ee2e5270b67f47",
      "value": "30% and above"
    }
  ]
}
```

## Demo
<p align="center">
<img src="https://github.com/oaktreeapps/product_filter_widget/blob/master/recording_ios.gif" width="300"/>
</p>


## Contributions

Feel free to contribute to this project.

* If you find a bug or want have a new feature request, please file an [issue][issue].
* If you fixed a bug or implemented a feature, please send a [pull request][pr].


<!-- Links -->
[issue]: https://github.com/oaktreeapps/product_filter_widget/issues
[pr]: https://github.com/oaktreeapps/product_filter_widget/pulls


