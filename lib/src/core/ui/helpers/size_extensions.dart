import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double get height => size.height;
  double get width => size.width;
  double get shortestSide => size.shortestSide;
  double get longestSide => size.longestSide;

  double percentWidth(double percent) {
    assert(percent >= 0.0 && percent <= 1, 'percent must be between 0.0 and 1');

    return width * percent;
  }

  double percentHeight(double percent) {
    assert(percent >= 0.0 && percent <= 1, 'percent must be between 0.0 and 1');

    return height * percent;
  }
}
