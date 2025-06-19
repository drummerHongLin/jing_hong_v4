import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;



abstract final class AppTheme{



static const _inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      // grey3 works for both light and dark themes
      color: Colors.grey,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData lightTheme = ThemeData(
        useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
      fontFamily: "Poppins",
      fontFamilyFallback: ['NotoSansSC']
  );


    static ThemeData dartTheme = ThemeData(
        useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
    fontFamily: "Poppins",
      fontFamilyFallback: ['NotoSansSC']
  );



}