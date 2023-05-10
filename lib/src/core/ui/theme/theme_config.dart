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
    focusedBorder: _defaultInputBorder,
    enabledBorder: _defaultInputBorder,
    border: _defaultInputBorder,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.instance.primaryColor,
    primary: AppColors.instance.primaryColor,
    scrim: AppColors.instance.secondaryColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  elevatedButtonTheme:
      ElevatedButtonThemeData(style: AppStyles.instance.primaryButtonStyle),
);
