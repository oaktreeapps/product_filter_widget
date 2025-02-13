import 'package:flutter/material.dart';
import 'package:product_filter_widget/product_filter_widget.dart';

final List<SubDataModel> colors = [
  SubDataModel(
    name: 'Pink',
    color: Colors.pink,
  ),
  SubDataModel(
    name: 'Yellow',
    color: Colors.yellow,
  ),
  SubDataModel(
    name: 'Green',
    color: Colors.green,
  ),
  SubDataModel(
    name: 'Black',
    color: Colors.black,
  ),
  SubDataModel(
    name: 'Blue',
    color: Colors.blue,
  ),
  SubDataModel(
    name: 'Cyan',
    color: Colors.cyan,
  ),
  SubDataModel(
    name: 'Purple',
    color: Colors.purple,
  ),
  SubDataModel(
    name: 'Accent',
    color: Colors.greenAccent,
  ),
];

final List<SubDataModel> sizes = [
  SubDataModel(
    name: 'XS',
    count: '12',
  ),
  SubDataModel(
    name: 'S',
    count: '12',
  ),
  SubDataModel(
    name: 'M',
    count: '21',
  ),
  SubDataModel(
    name: 'XS',
    count: '5',
  ),
  SubDataModel(
    name: 'L',
    count: '21',
  ),
];

final List<SubDataModel> categories = [
  SubDataModel(
    name: 'Clothing',
    count: '250',
  ),
  SubDataModel(
    name: 'Footwear',
    count: '250',
  ),
  SubDataModel(
    name: 'Accessories',
    count: '250',
  ),
  SubDataModel(
    name: 'Beauty',
    count: '250',
  ),
  SubDataModel(
    name: 'Home',
    count: '250',
  ),
  SubDataModel(
    name: 'Electronics',
    count: '250',
  ),
];

final List<SubDataModel> brands = [
  SubDataModel(
    name: 'Nike',
    count: '21',
  ),
  SubDataModel(
    name: 'Puma',
    count: '21',
  ),
  SubDataModel(
    name: 'Reebok',
    count: '21',
  ),
  SubDataModel(
    name: 'Bata',
    count: '21',
  ),
  SubDataModel(
    name: 'Crocs',
    count: '21',
  ),
];

final List<SubDataModel> countryOfOrigin = [
  SubDataModel(
    name: 'India',
  ),
  SubDataModel(
    name: 'USA',
  ),
  SubDataModel(
    name: 'Canada',
  ),
  SubDataModel(
    name: 'China',
  ),
];

final List<SubDataModel> discounts = [
  SubDataModel(
    name: '10% and above',
  ),
  SubDataModel(
    name: '20% and above',
  ),
  SubDataModel(
    name: '30% and above',
  ),
  SubDataModel(
    name: '40% and above',
  ),
];

///filter model test
List<FilterModel> filterModelList = [
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
