import 'package:flutter/material.dart';

class CustomAppTheme {
  static const Color primaryColor = Colors.lightGreen;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(color: primaryColor),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: primaryColor),
      selectedItemColor: primaryColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(color: primaryColor),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: primaryColor),
      selectedItemColor: primaryColor,
    ),
  );
}
