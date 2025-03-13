import 'package:flutter/material.dart';

class WidgetStructure {
  static double scale = 1;
  final Size baseSize;

  WidgetStructure({required Size currentSize, required this.baseSize}) {
    scale = _area(currentSize) / _area(baseSize);
  }

  double _area(Size size) {
    return size.height * size.width;
  }
}