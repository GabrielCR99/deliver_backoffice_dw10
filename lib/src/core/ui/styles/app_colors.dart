import 'package:flutter/material.dart';

final class AppColors {
  static AppColors? _instance;

  AppColors._();

  static AppColors get instance {
    _instance ??= AppColors._();

    return _instance!;
  }

  Color get primaryColor => const Color(0xFF007D21);
  Color get secondaryColor => const Color(0xFFFFAB18);
  Color get black => const Color(0xFF140E0E);
}

extension AppColorsExtension on BuildContext {
  AppColors get appColors => AppColors.instance;
}
