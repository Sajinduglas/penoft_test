import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorExtension get white => ColorExtension();
}

class ColorExtension {
  Color get c500 => Colors.white;
}

