import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    /// app light theme colors
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.purple,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.offWhite,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.lightBlue,
      onSurface: AppColors.purple,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        side: const BorderSide(width: 1, color: AppColors.purple),
        foregroundColor: AppColors.purple,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.purple,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.purple),
      titleMedium: TextStyle(color: AppColors.purple),
      titleSmall: TextStyle(color: AppColors.purple),
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),
    ),

    /// app bar
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.purple,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    /// filled button
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    /// outline button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    /// text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      hintStyle: const TextStyle(fontSize: 16, color: AppColors.gray),
      enabledBorder: borderDecoration(),
      focusedBorder: borderDecoration(),
      errorBorder: borderDecoration(color: AppColors.red),
      focusedErrorBorder: borderDecoration(color: AppColors.red),
      border: borderDecoration(),
      disabledBorder: borderDecoration(color: AppColors.gray),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.purple,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    /// app dark theme colors
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.purple,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.darkBlue,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.darkBlue,
      onSurface: AppColors.purple,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.purple),
      titleMedium: TextStyle(color: AppColors.purple),
      titleSmall: TextStyle(color: AppColors.purple),
      bodyLarge: TextStyle(color: AppColors.offWhite),
      bodyMedium: TextStyle(color: AppColors.offWhite),
      bodySmall: TextStyle(color: AppColors.offWhite),
      labelLarge: TextStyle(color: AppColors.offWhite),
      labelMedium: TextStyle(color: AppColors.offWhite),
      labelSmall: TextStyle(color: AppColors.offWhite),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        side: const BorderSide(width: 1, color: AppColors.purple),
        foregroundColor: AppColors.purple,
      ),
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.purple,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      hintStyle: const TextStyle(fontSize: 16, color: AppColors.offWhite),
      enabledBorder: borderDecoration(),
      focusedBorder: borderDecoration(),
      errorBorder: borderDecoration(color: AppColors.red),
      focusedErrorBorder: borderDecoration(color: AppColors.red),
      border: borderDecoration(),
      disabledBorder: borderDecoration(color: AppColors.gray),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkBlue,
      elevation: 0,
    ),
  );

  static OutlineInputBorder borderDecoration({Color color = AppColors.purple}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
