part of '../../../app_widget.dart';

final _defaultInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey[400]!),
  borderRadius: const BorderRadius.all(Radius.circular(7)),
);

final _theme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyles.instance.textRegular.copyWith(color: Colors.black),
    errorStyle:
        TextStyles.instance.textRegular.copyWith(color: Colors.redAccent),
    isDense: true,
    contentPadding: const EdgeInsets.all(20),
    filled: true,
    fillColor: Colors.white,
    hoverColor: Colors.white,
    focusedBorder: _defaultInputBorder,
    enabledBorder: _defaultInputBorder,
    border: _defaultInputBorder,
  ),
  useMaterial3: true,
  cardColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.instance.primaryColor,
    primary: AppColors.instance.primaryColor,
    secondary: AppColors.instance.secondaryColor,
    onSecondary: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  cardTheme:
      const CardTheme(color: Colors.white, surfaceTintColor: Colors.white),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  elevatedButtonTheme:
      ElevatedButtonThemeData(style: AppStyles.instance.primaryButtonStyle),
);
