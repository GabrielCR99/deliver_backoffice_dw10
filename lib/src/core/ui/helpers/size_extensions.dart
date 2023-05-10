import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);

  double get height => _mediaQuery.size.height;
  double get width => _mediaQuery.size.width;
  double get shortestSide => _mediaQuery.size.shortestSide;
  double get longestSide => _mediaQuery.size.longestSide;

  double percentWidth(double percent) {
    assert(percent >= 0.0 && percent <= 1, 'percent must be between 0.0 and 1');

    return width * percent;
  }

  double percentHeight(double percent) {
    assert(percent >= 0.0 && percent <= 1, 'percent must be between 0.0 and 1');

    return height * percent;
  }
}
