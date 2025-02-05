import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_filter_widget/product_filter_widget.dart';
import 'data_source.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<FilterModel> filterModelList;

  @override
  void initState() {
    super.initState();
    filterModelList = [
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: ProductFilterWidget(
        onSubmit: (selectedValues) {
          log(selectedValues);
        },
        isResetFieldsAfterSubmit: false,
        filterModelList: filterModelList,
        theme: const FilterTheme(
          submitButtonBackgroundColor: Colors.blueGrey,
          submitButtonTextColor: Colors.white,
          resetButtonBackgroundColor: Colors.black,
          resetButtonTextColor: Colors.white,
        ),
      ),
    );
  }
}
