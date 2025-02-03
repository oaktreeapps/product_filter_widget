import 'package:flutter/material.dart';
import 'package:product_filter_widget/src/utilities/generate_hash.dart';

/// A data model class representing a sub-item with an ID, name, and count.
class SubDataModel {
  /// Unique identifier for the sub-item.
  String? id;

  /// Name of the sub-item.
  final String name;

  /// Count or quantity associated with the sub-item.
  final String? count;

  /// Color of sub-item.
  final Color? color;

  /// Constructor to initialize the `SubDataModel` with required fields.
  ///
  /// All fields are marked as required to ensure that the object is created
  /// with valid data.
  SubDataModel({
    this.id,
    this.color,
    this.count,
    required this.name,
  }) {
    id ??= generateHashKey();
  }

  /// Creates a copy of the current `SubDataModel` with updated values.
  ///
  /// The method allows selective modification of properties by passing new
  /// values for them. If a parameter is not provided, the current value
  /// is retained.
  ///
  /// Example:
  /// ```dart
  /// SubDataModel model = SubDataModel(id: '1', name: 'Item', count: '5');
  /// SubDataModel updatedModel = model.copyWith(name: 'Updated Item');
  /// ```
  /// In the above example, the `id` and `count` remain the same, while the
  /// `name` is updated.
}
