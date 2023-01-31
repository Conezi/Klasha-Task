import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      backgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.lightPrimary,
      dividerColor: AppColors.lightDivider,
      canvasColor: AppColors.lightCanvas,
      dialogBackgroundColor: AppColors.lightBackground,
      shadowColor: AppColors.lightShadowColor,
      hoverColor: AppColors.lightSecondaryAccent.withOpacity(0.5),
      focusColor: AppColors.lightSecondaryAccent.withOpacity(0.5),
      scaffoldBackgroundColor: AppColors.lightBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(
        secondary: AppColors.lightSecondaryAccent,
        primary: AppColors.lightSecondaryAccent,
      ),
      appBarTheme: AppBarTheme(
          elevation: 1.0,
          titleTextStyle: ThemeData.dark()
              .textTheme
              .headline6!
              .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
          iconTheme: ThemeData.light().iconTheme,
          color: AppColors.lightSecondaryAccent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          )),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.lightSecondaryAccent,
      ));
}
