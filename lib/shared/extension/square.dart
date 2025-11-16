import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  SizedBox square(double dimension) => SizedBox.square(
        dimension: dimension,
        child: this,
      );
}
