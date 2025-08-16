import 'package:flutter/material.dart';

final primaryColor = Colors.green;
final secondaryColor = Color(0xFFFFF8E1);
final thirdColor = Colors.white;

final appTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: primaryColor, centerTitle: true, foregroundColor: thirdColor),

  brightness: Brightness.light,

  primaryColor: primaryColor,
  
  colorScheme: ColorScheme.light(primary: primaryColor),
  
  progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
  
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
  ),
  
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: primaryColor),
    iconColor: secondaryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);