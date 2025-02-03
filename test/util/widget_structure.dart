import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_filter_widget/product_filter_widget.dart';

class BaseStructure extends StatefulWidget {
  final List<FilterModel> filterModelList;

  const BaseStructure({
    super.key,
    required this.filterModelList,
  });

  @override
  State<BaseStructure> createState() => _BaseStructureState();
}

class _BaseStructureState extends State<BaseStructure> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: ProductFilterWidget(
        filterModelList: widget.filterModelList,
        onSubmit: (selectedValues) {
          if (kDebugMode) {
            print(selectedValues);
          }
        },
      ),
    );
  }
}
